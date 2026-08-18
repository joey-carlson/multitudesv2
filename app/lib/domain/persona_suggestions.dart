/// Persona suggestions (roadmap F5): from observed usage, propose either a new
/// persona the user is missing, or an adjustment to an existing persona's peak
/// window. Heuristics-first, on-device; suggestions require the user's approval
/// (never auto-applied).
library;

import 'calendar_event.dart';
import 'calendar_matcher.dart';
import 'energy_reading.dart';
import 'persona.dart';

/// Suggests adding a preset archetype the user doesn't have yet, backed by a
/// cluster of unmatched events that fit that archetype's lexicon.
class ArchetypeSuggestion {
  ArchetypeSuggestion({
    required this.archetype,
    required this.matchCount,
    required this.sampleTitles,
  });

  final PersonaArchetype archetype;
  final int matchCount;
  final List<String> sampleTitles; // up to a few example event titles
}

/// Suggests shifting an existing persona's peak window toward the hours when
/// the user actually logs high energy.
class PeakAdjustmentSuggestion {
  PeakAdjustmentSuggestion({
    required this.persona,
    required this.suggestedStart,
    required this.suggestedEnd,
    required this.basedOnReadings,
  });

  final Persona persona;
  final String suggestedStart; // "HH:00"
  final String suggestedEnd;
  final int basedOnReadings; // how many high-energy check-ins informed this
}

/// From [unmatchedEvents] (events with no effective persona), suggest preset
/// archetypes the user hasn't added, ranked by how many unmatched events fit.
List<ArchetypeSuggestion> suggestNewArchetypes({
  required List<Persona> personas,
  required List<CalendarEvent> unmatchedEvents,
  int minEvents = 3,
}) {
  final existing = personas.map((p) => p.archetype).toSet();
  final out = <ArchetypeSuggestion>[];

  for (final archetype in archetypeTemplates.keys) {
    if (existing.contains(archetype)) continue;
    final hits =
        unmatchedEvents.where((e) => eventMatchesArchetype(e, archetype)).toList();
    if (hits.length < minEvents) continue;
    final titles = <String>[];
    for (final e in hits) {
      if (!titles.contains(e.title)) titles.add(e.title);
      if (titles.length == 3) break;
    }
    out.add(ArchetypeSuggestion(
        archetype: archetype, matchCount: hits.length, sampleTitles: titles));
  }

  out.sort((a, b) => b.matchCount.compareTo(a.matchCount));
  return out;
}

/// Suggest a peak-window adjustment for [persona] if the user's high-energy
/// check-ins ([readings], energy ≥ [highThreshold]) cluster outside the
/// persona's configured peak. Returns null when there isn't enough signal or
/// the current peak already fits. Proposes a 3-hour window centered on the
/// average high-energy hour.
PeakAdjustmentSuggestion? suggestPeakAdjustment(
  Persona persona,
  List<EnergyReading> readings, {
  int highThreshold = 7,
  int minReadings = 4,
}) {
  final high = readings.where((r) => r.energyLevel >= highThreshold).toList();
  if (high.length < minReadings) return null;

  final avgHour = (high.map((r) => r.timestamp.hour).reduce((a, b) => a + b) /
          high.length)
      .round();

  // If the current peak already covers the observed high hour, no change.
  final at = DateTime(2026, 1, 1, avgHour);
  if (persona.isAtPeak(at)) return null;

  final start = (avgHour - 1).clamp(0, 23);
  final end = (avgHour + 2).clamp(0, 23);
  String hh(int h) => '${h.toString().padLeft(2, '0')}:00';

  // Skip if it would produce the same window the persona already has.
  final proposedStart = hh(start);
  final proposedEnd = hh(end);
  if (persona.peakStartTime == proposedStart &&
      persona.peakEndTime == proposedEnd) {
    return null;
  }

  return PeakAdjustmentSuggestion(
    persona: persona,
    suggestedStart: proposedStart,
    suggestedEnd: proposedEnd,
    basedOnReadings: high.length,
  );
}
