import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_event.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/timing_suggestion.dart';

Persona _p({String? peakStart, String? peakEnd, String? troughStart, String? troughEnd}) =>
    Persona(
      userId: 'u',
      name: 'Emma',
      emoji: '🧠',
      archetype: PersonaArchetype.professional,
      primaryEnergy: '',
      strengths: const [],
      weaknesses: const [],
      triggerConditions: const [],
      idealTasks: const [],
      peakStartTime: peakStart,
      peakEndTime: peakEnd,
      troughStartTime: troughStart,
      troughEndTime: troughEnd,
    );

CalendarEvent _eventAt(int hour) => CalendarEvent(
      id: 'e',
      title: 'X',
      start: DateTime(2026, 1, 1, hour),
      end: DateTime(2026, 1, 1, hour + 1),
    );

void main() {
  group('suggestTimingForEvent', () {
    final emma = _p(
        peakStart: '09:00', peakEnd: '12:00', troughStart: '14:00', troughEnd: '16:00');

    test('trough event -> high-severity suggestion to peak', () {
      final s = suggestTimingForEvent(_eventAt(15), emma)!;
      expect(s.severity, SuggestionSeverity.high);
      expect(s.currentState, EnergyState.trough);
      expect(s.peakStart, '09:00');
      expect(s.peakEnd, '12:00');
    });

    test('off-peak (neutral) event -> low-severity suggestion', () {
      final s = suggestTimingForEvent(_eventAt(20), emma)!;
      expect(s.severity, SuggestionSeverity.low);
      expect(s.currentState, EnergyState.neutral);
    });

    test('event already in peak -> no suggestion', () {
      expect(suggestTimingForEvent(_eventAt(10), emma), isNull);
    });

    test('no persona -> no suggestion', () {
      expect(suggestTimingForEvent(_eventAt(15), null), isNull);
    });

    test('persona with no peak window -> no suggestion', () {
      expect(suggestTimingForEvent(_eventAt(15), _p()), isNull);
    });
  });
}
