/// Heuristic event→persona matching (roadmap F1/F2, heuristics-first).
///
/// Pure, deterministic, on-device, and unit-tested. Scores each persona against
/// an event by keyword overlap (event title/notes vs. the persona's name,
/// primary energy, ideal tasks, and triggers), and reports the persona's energy
/// state at the event's start time so the UI can flag good/poor timing.
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

  /// Number of overlapping keywords (higher = stronger fit).
  final int score;

  /// The persona's predicted energy state at the event's start time.
  final EnergyState stateAtEvent;

  /// True when the event lands in this persona's peak window.
  bool get wellTimed => stateAtEvent == EnergyState.peak;

  /// True when the event lands in this persona's low-energy trough.
  bool get poorlyTimed => stateAtEvent == EnergyState.trough;
}

/// Very common words that add noise rather than signal to matching.
const _stopwords = {
  'the', 'and', 'for', 'with', 'your', 'you', 'that', 'this', 'from', 'into',
  'time', 'work', 'make', 'over', 'about', 'when', 'what', 'their', 'they',
};

Set<String> _tokens(String? text) {
  if (text == null) return {};
  return text
      .toLowerCase()
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.length >= 4 && !_stopwords.contains(w))
      .toSet();
}

Set<String> _personaKeywords(Persona p) => {
      ..._tokens(p.name),
      ..._tokens(p.primaryEnergy),
      for (final t in p.idealTasks) ..._tokens(t),
      for (final t in p.triggerConditions) ..._tokens(t),
    };

/// Rank personas by fit for [event]; strongest first. Personas with no keyword
/// overlap are omitted. Ties are broken by the persona name for determinism.
List<PersonaMatch> rankPersonasForEvent(
  CalendarEvent event,
  List<Persona> personas,
) {
  final eventTokens = {..._tokens(event.title), ..._tokens(event.notes)};

  final matches = <PersonaMatch>[];
  for (final p in personas) {
    final overlap = _personaKeywords(p).intersection(eventTokens).length;
    if (overlap == 0) continue;
    matches.add(PersonaMatch(
      persona: p,
      score: overlap,
      stateAtEvent: p.energyStateAt(event.start),
    ));
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
  Map<String, String> overrides,
) {
  final overrideId = overrides[event.id];
  if (overrideId != null) {
    for (final p in personas) {
      if (p.id == overrideId) return p;
    }
  }
  final matches = rankPersonasForEvent(event, personas);
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
}) {
  final hours = <String, double>{};
  for (final e in events) {
    if (hiddenEventIds.contains(e.id)) continue;
    final kind = e.calendarId == null
        ? CalendarKind.unset
        : (kindByCalendarId[e.calendarId] ?? CalendarKind.unset);
    if (kind == CalendarKind.ignore) continue;

    final persona = effectivePersonaForEvent(e, personas, overrides);
    final pid = persona?.id;
    if (pid == null) continue;
    hours[pid] = (hours[pid] ?? 0) + e.duration.inMinutes / 60.0;
  }
  return hours;
}
