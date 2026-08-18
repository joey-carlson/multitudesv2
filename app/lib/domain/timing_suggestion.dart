/// Timing suggestions (roadmap F2): flag events scheduled outside their
/// persona's strong hours and propose the persona's peak window instead.
/// Non-destructive — the app suggests; the user reschedules in their calendar.
library;

import 'calendar_event.dart';
import 'persona.dart';

enum SuggestionSeverity {
  /// Event falls in the persona's low-energy trough — strong case to move.
  high,

  /// Event is merely outside the persona's peak — a softer nudge.
  low,
}

class TimingSuggestion {
  TimingSuggestion({
    required this.event,
    required this.persona,
    required this.currentState,
    required this.peakStart,
    required this.peakEnd,
    required this.severity,
  });

  final CalendarEvent event;
  final Persona persona;
  final EnergyState currentState;
  final String peakStart;
  final String peakEnd;
  final SuggestionSeverity severity;
}

/// Suggests a better time for [event] given its effective [persona], or null
/// when there's nothing to suggest: no persona, no defined peak window, or the
/// event already lands in the persona's peak/recovery window.
TimingSuggestion? suggestTimingForEvent(CalendarEvent event, Persona? persona) {
  if (persona == null) return null;
  final ps = persona.peakStartTime;
  final pe = persona.peakEndTime;
  if (ps == null || pe == null) return null;

  final state = persona.energyStateAt(event.start);
  if (state == EnergyState.peak || state == EnergyState.recovery) return null;

  return TimingSuggestion(
    event: event,
    persona: persona,
    currentState: state,
    peakStart: ps,
    peakEnd: pe,
    severity:
        state == EnergyState.trough ? SuggestionSeverity.high : SuggestionSeverity.low,
  );
}
