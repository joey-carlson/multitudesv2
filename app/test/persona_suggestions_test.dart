import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/calendar_event.dart';
import 'package:multitudes/domain/energy_reading.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/persona_suggestions.dart';

CalendarEvent _e(String title) => CalendarEvent(
      id: title,
      title: title,
      start: DateTime(2026, 1, 1, 12),
      end: DateTime(2026, 1, 1, 13),
    );

Persona _persona(PersonaArchetype a, {String? peakStart, String? peakEnd}) => Persona(
      id: a.value,
      userId: 'u',
      name: a.value,
      emoji: '🧩',
      archetype: a,
      primaryEnergy: '',
      strengths: const [],
      weaknesses: const [],
      triggerConditions: const [],
      idealTasks: const [],
      peakStartTime: peakStart,
      peakEndTime: peakEnd,
    );

EnergyReading _reading(int hour, int level) => EnergyReading(
      personaId: 'p',
      energyLevel: level,
      timestamp: DateTime(2026, 1, 2, hour),
    );

void main() {
  group('suggestNewArchetypes', () {
    test('suggests a missing archetype from unmatched-event cluster', () {
      final personas = [_persona(PersonaArchetype.professional)];
      final unmatched = [_e('Morning gym'), _e('Evening run'), _e('Yoga class')];
      final s = suggestNewArchetypes(personas: personas, unmatchedEvents: unmatched);
      // gym/run/yoga are inner-child lexicon terms
      expect(s.first.archetype, PersonaArchetype.innerChild);
      expect(s.first.matchCount, 3);
      expect(s.first.sampleTitles, isNotEmpty);
    });

    test('does not suggest an archetype the user already has', () {
      final personas = [_persona(PersonaArchetype.innerChild)];
      final unmatched = [_e('gym'), _e('run'), _e('yoga')];
      final s = suggestNewArchetypes(personas: personas, unmatchedEvents: unmatched);
      expect(s.where((x) => x.archetype == PersonaArchetype.innerChild), isEmpty);
    });

    test('respects the minimum-events threshold', () {
      final personas = <Persona>[];
      final s = suggestNewArchetypes(
          personas: personas, unmatchedEvents: [_e('gym')], minEvents: 3);
      expect(s, isEmpty);
    });
  });

  group('suggestPeakAdjustment', () {
    test('suggests shifting peak toward observed high-energy hours', () {
      // Peak set to morning, but high energy consistently ~15:00.
      final p = _persona(PersonaArchetype.professional,
          peakStart: '07:00', peakEnd: '09:00');
      final readings = [
        _reading(15, 8),
        _reading(15, 9),
        _reading(16, 7),
        _reading(14, 8),
      ];
      final s = suggestPeakAdjustment(p, readings)!;
      expect(s.suggestedStart, '14:00'); // avg 15 → 15-1
      expect(s.suggestedEnd, '17:00'); // 15+2
      expect(s.basedOnReadings, 4);
    });

    test('no suggestion when high energy already falls in peak', () {
      final p = _persona(PersonaArchetype.professional,
          peakStart: '09:00', peakEnd: '12:00');
      final readings = [
        _reading(10, 8),
        _reading(11, 9),
        _reading(10, 7),
        _reading(11, 8),
      ];
      expect(suggestPeakAdjustment(p, readings), isNull);
    });

    test('no suggestion without enough high-energy readings', () {
      final p = _persona(PersonaArchetype.professional,
          peakStart: '07:00', peakEnd: '09:00');
      expect(suggestPeakAdjustment(p, [_reading(15, 9), _reading(15, 8)]), isNull);
    });

    test('late-night high energy averages to midnight, not noon (circular)', () {
      final p = _persona(PersonaArchetype.professional,
          peakStart: '07:00', peakEnd: '09:00');
      final s = suggestPeakAdjustment(p, [
        _reading(23, 8),
        _reading(0, 9),
        _reading(1, 8),
        _reading(23, 9),
      ])!;
      // Center ~00:00 → window 23:00–02:00 (wraps midnight), not ~noon.
      expect(s.suggestedStart, '23:00');
      expect(s.suggestedEnd, '02:00');
    });
  });
}
