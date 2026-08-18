/// Rebalancing suggestions (roadmap F4): for personas that are under-fed,
/// find an open slot in the user's calendar during that persona's peak window
/// and suggest one of its activities. Heuristics-first, on-device,
/// non-destructive (the user schedules it themselves).
library;

import 'calendar_event.dart';
import 'persona.dart';

class RebalanceSuggestion {
  RebalanceSuggestion({
    required this.persona,
    required this.slotStart,
    required this.slotEnd,
    required this.activities,
  });

  final Persona persona;
  final DateTime slotStart;
  final DateTime slotEnd;
  final List<String> activities; // a few ideal tasks to do in the slot
}

int? _minutes(String? hhmm) {
  if (hhmm == null) return null;
  final p = hhmm.split(':');
  return int.parse(p[0]) * 60 + int.parse(p[1]);
}

/// For each [starving] persona (already determined under-fed) that has a normal
/// daytime peak window, find the earliest day in the next [daysAhead] days
/// whose peak window has no overlapping event in [events], and suggest filling
/// it with a couple of the persona's ideal activities. [events] should already
/// exclude hidden/ignored events.
List<RebalanceSuggestion> suggestRebalance({
  required List<Persona> starving,
  required List<CalendarEvent> events,
  required DateTime from,
  int daysAhead = 7,
}) {
  final out = <RebalanceSuggestion>[];

  for (final p in starving) {
    final ps = _minutes(p.peakStartTime);
    final pe = _minutes(p.peakEndTime);
    if (ps == null || pe == null || pe <= ps) continue; // need a normal window

    final day0 = DateTime(from.year, from.month, from.day);
    for (var d = 0; d < daysAhead; d++) {
      final day = day0.add(Duration(days: d));
      final slotStart = day.add(Duration(minutes: ps));
      final slotEnd = day.add(Duration(minutes: pe));
      if (slotEnd.isBefore(from)) continue; // already passed today

      final busy = events.any(
          (e) => e.start.isBefore(slotEnd) && e.end.isAfter(slotStart));
      if (busy) continue;

      out.add(RebalanceSuggestion(
        persona: p,
        slotStart: slotStart,
        slotEnd: slotEnd,
        activities: p.idealTasks.take(3).toList(),
      ));
      break; // one (soonest) slot per persona
    }
  }
  return out;
}
