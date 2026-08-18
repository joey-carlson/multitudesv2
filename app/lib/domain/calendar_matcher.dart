/// Heuristic event→persona matching (roadmap F1/F2, heuristics-first).
///
/// Pure, deterministic, on-device, and unit-tested. This is an
/// information-retrieval problem (not a wellbeing claim), so it uses standard
/// text-matching techniques: a per-archetype keyword lexicon plus the persona's
/// own words, weighted by a time-of-day prior (event in the persona's peak) and
/// a work/personal domain prior. Optional semantic/LLM matching is left for a
/// later online-enrichment layer.
library;

import 'calendar_classification.dart';
import 'calendar_event.dart';
import 'persona.dart';

/// A ranked match of a persona to an event.
class PersonaMatch {
  PersonaMatch({
    required this.persona,
    required this.score,
    required this.stateAtEvent,
  });

  final Persona persona;

  /// Composite fit score (higher = stronger). Combines keyword overlap with
  /// time-of-day and domain priors.
  final double score;

  /// The persona's predicted energy state at the event's start time.
  final EnergyState stateAtEvent;

  /// True when the event lands in this persona's peak window.
  bool get wellTimed => stateAtEvent == EnergyState.peak;

  /// True when the event lands in this persona's low-energy trough.
  bool get poorlyTimed => stateAtEvent == EnergyState.trough;
}

/// Common grammar/filler words that add noise rather than signal.
const _stopwords = {
  'the', 'and', 'for', 'with', 'your', 'you', 'that', 'this', 'from', 'into',
  'about', 'when', 'what', 'their', 'they', 'are', 'was', 'will', 'not', 'but',
  'out', 'get', 'got', 'per', 'via', 'its', 'time',
};

/// Words commonly seen in calendar titles/notes, by archetype. Expands coverage
/// well beyond a persona's own configured words (which real events rarely
/// contain). Terms are lowercase, length >= 3 (tokenizer floor).
const Map<PersonaArchetype, Set<String>> _archetypeLexicon = {
  PersonaArchetype.professional: {
    'meeting', 'call', 'sync', 'standup', 'review', 'planning', 'deadline',
    'presentation', 'interview', 'email', 'report', 'budget', 'deck', 'client',
    'stakeholder', 'sprint', 'retro', 'kickoff', 'okr', 'okrs', 'demo',
    'offsite', 'hiring', 'strategy', 'finance', 'invoice', 'board', 'quarterly',
  },
  PersonaArchetype.artist: {
    'paint', 'painting', 'draw', 'drawing', 'design', 'write', 'writing',
    'music', 'guitar', 'piano', 'sketch', 'studio', 'create', 'craft', 'photo',
    'photography', 'band', 'rehearsal', 'art', 'novel', 'poem', 'film', 'sing',
  },
  PersonaArchetype.builder: {
    'build', 'fix', 'repair', 'assemble', 'garage', 'workshop', 'install',
    'prototype', 'tinker', 'woodworking', 'wiring', 'plumbing', 'maker', 'diy',
  },
  PersonaArchetype.guardian: {
    'doctor', 'dentist', 'appointment', 'appt', 'insurance', 'taxes', 'tax',
    'checkup', 'security', 'backup', 'safety', 'maintenance', 'inspection',
    'vaccine', 'physical', 'renewal',
  },
  PersonaArchetype.architect: {
    'plan', 'organize', 'schedule', 'clean', 'declutter', 'setup', 'roadmap',
    'system', 'sort', 'inbox', 'tidy', 'audit',
  },
  PersonaArchetype.historian: {
    'journal', 'retrospective', 'document', 'notes', 'archive', 'photos',
    'memories', 'reflection', 'recap', 'summary',
  },
  PersonaArchetype.optimizer: {
    'automate', 'script', 'configure', 'optimize', 'tool', 'workflow',
    'integrate', 'refactor',
  },
  PersonaArchetype.innerChild: {
    'play', 'game', 'gaming', 'fun', 'hangout', 'party', 'movie', 'dinner',
    'lunch', 'friends', 'family', 'kids', 'birthday', 'date', 'relax',
    'vacation', 'beach', 'walk', 'coffee', 'brunch', 'gym', 'run', 'yoga',
    'hike', 'workout',
  },
};

/// The calendar domain an archetype typically lives in (used as a light prior).
/// Ambiguous archetypes are omitted (no prior).
const Map<PersonaArchetype, CalendarKind> _archetypeDomain = {
  PersonaArchetype.professional: CalendarKind.work,
  PersonaArchetype.architect: CalendarKind.work,
  PersonaArchetype.optimizer: CalendarKind.work,
  PersonaArchetype.artist: CalendarKind.personal,
  PersonaArchetype.innerChild: CalendarKind.personal,
  PersonaArchetype.builder: CalendarKind.personal,
};

Set<String> _tokens(String? text) {
  if (text == null) return {};
  return text
      .toLowerCase()
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.length >= 3 && !_stopwords.contains(w))
      .toSet();
}

/// Public tokenizer, so learned associations are recorded with the same
/// tokenization the matcher uses.
Set<String> matchTokens(String? text) => _tokens(text);

/// Whether an event's title/notes overlap a given archetype's keyword lexicon.
/// Used to detect "gaps" — clusters of events matching an archetype the user
/// has not yet added as a persona (roadmap F5).
bool eventMatchesArchetype(CalendarEvent event, PersonaArchetype archetype) {
  final lex = _archetypeLexicon[archetype];
  if (lex == null) return false;
  final tokens = {..._tokens(event.title), ..._tokens(event.notes)};
  return lex.intersection(tokens).isNotEmpty;
}

Set<String> _personaKeywords(Persona p) => {
      ..._tokens(p.name),
      ..._tokens(p.primaryEnergy),
      for (final t in p.idealTasks) ..._tokens(t),
      for (final t in p.triggerConditions) ..._tokens(t),
      ...?_archetypeLexicon[p.archetype],
    };

/// Weight applied to learned (user-taught) token matches — higher than lexicon
/// matches because they are explicit user signal.
const double _learnedWeight = 2.0;

/// Rank personas by fit for [event]; strongest first. A persona must share at
/// least one keyword (lexicon/own words or a learned token) to be a candidate;
/// time-of-day and domain priors then refine the ranking. [eventKind] is the
/// event's calendar classification (work/personal), used for the domain prior.
/// [learnedByPersona] maps persona id → tokens taught by prior manual
/// assignments. Ties broken by name.
List<PersonaMatch> rankPersonasForEvent(
  CalendarEvent event,
  List<Persona> personas, {
  CalendarKind eventKind = CalendarKind.unset,
  Map<String, Set<String>> learnedByPersona = const {},
}) {
  final eventTokens = {..._tokens(event.title), ..._tokens(event.notes)};

  final matches = <PersonaMatch>[];
  for (final p in personas) {
    final overlap = _personaKeywords(p).intersection(eventTokens).length;
    final learned = learnedByPersona[p.id] ?? const <String>{};
    final learnedOverlap = learned.intersection(eventTokens).length;
    if (overlap == 0 && learnedOverlap == 0) continue;

    final state = p.energyStateAt(event.start);
    var score = overlap.toDouble() + learnedOverlap * _learnedWeight;

    // Time-of-day prior: activity aligned with the persona's strong hours fits.
    score += switch (state) {
      EnergyState.peak => 1.5,
      EnergyState.recovery => 0.5,
      EnergyState.trough => -0.5,
      EnergyState.neutral => 0.0,
    };

    // Domain prior: nudge toward personas whose domain matches the calendar.
    final domain = _archetypeDomain[p.archetype];
    if (domain != null &&
        (eventKind == CalendarKind.work || eventKind == CalendarKind.personal)) {
      score += eventKind == domain ? 1.0 : -0.5;
    }

    matches.add(PersonaMatch(persona: p, score: score, stateAtEvent: state));
  }

  matches.sort((a, b) {
    final byScore = b.score.compareTo(a.score);
    return byScore != 0 ? byScore : a.persona.name.compareTo(b.persona.name);
  });
  return matches;
}

/// The persona in effect for an event: a manual assignment ([overrides] maps
/// event id → persona id) wins; otherwise the top auto-match; else null.
Persona? effectivePersonaForEvent(
  CalendarEvent event,
  List<Persona> personas,
  Map<String, String> overrides, {
  CalendarKind eventKind = CalendarKind.unset,
  Map<String, Set<String>> learnedByPersona = const {},
}) {
  final overrideId = overrides[event.id];
  if (overrideId != null) {
    for (final p in personas) {
      if (p.id == overrideId) return p;
    }
  }
  final matches = rankPersonasForEvent(event, personas,
      eventKind: eventKind, learnedByPersona: learnedByPersona);
  return matches.isEmpty ? null : matches.first.persona;
}

/// Hours per persona id attributed from [events] via their effective persona,
/// skipping hidden events and events on ignored calendars. Used to fold
/// calendar time into the persona balance.
Map<String, double> calendarHoursByPersona({
  required List<CalendarEvent> events,
  required List<Persona> personas,
  required Map<String, String> overrides,
  required Set<String> hiddenEventIds,
  required Map<String, CalendarKind> kindByCalendarId,
  Map<String, Set<String>> learnedByPersona = const {},
}) {
  final hours = <String, double>{};
  for (final e in events) {
    if (hiddenEventIds.contains(e.id)) continue;
    final kind = e.calendarId == null
        ? CalendarKind.unset
        : (kindByCalendarId[e.calendarId] ?? CalendarKind.unset);
    if (kind == CalendarKind.ignore) continue;

    final persona = effectivePersonaForEvent(e, personas, overrides,
        eventKind: kind, learnedByPersona: learnedByPersona);
    final pid = persona?.id;
    if (pid == null) continue;
    hours[pid] = (hours[pid] ?? 0) + e.duration.inMinutes / 60.0;
  }
  return hours;
}
