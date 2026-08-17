import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/persona.dart';

Persona _persona({
  String? peakStart,
  String? peakEnd,
  String? troughStart,
  String? troughEnd,
  String? recoveryStart,
  String? recoveryEnd,
}) =>
    Persona(
      userId: 'u',
      name: 'Test',
      emoji: '🧪',
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
      recoveryStartTime: recoveryStart,
      recoveryEndTime: recoveryEnd,
    );

DateTime _at(int hour, int minute) => DateTime(2026, 1, 1, hour, minute);

void main() {
  group('energyStateAt', () {
    test('peak / trough / recovery / neutral windows', () {
      final p = _persona(
        peakStart: '09:00',
        peakEnd: '12:00',
        troughStart: '14:00',
        troughEnd: '16:00',
        recoveryStart: '16:00',
        recoveryEnd: '18:00',
      );
      expect(p.energyStateAt(_at(10, 0)), EnergyState.peak);
      expect(p.energyStateAt(_at(15, 0)), EnergyState.trough);
      expect(p.energyStateAt(_at(17, 0)), EnergyState.recovery);
      expect(p.energyStateAt(_at(8, 0)), EnergyState.neutral);
    });

    test('peak window crossing midnight', () {
      final p = _persona(peakStart: '23:00', peakEnd: '02:00');
      expect(p.energyStateAt(_at(23, 30)), EnergyState.peak);
      expect(p.energyStateAt(_at(1, 0)), EnergyState.peak);
      expect(p.energyStateAt(_at(3, 0)), EnergyState.neutral);
    });

    test('peak takes precedence over overlapping trough', () {
      final p = _persona(
        peakStart: '09:00',
        peakEnd: '12:00',
        troughStart: '11:00',
        troughEnd: '13:00',
      );
      expect(p.energyStateAt(_at(11, 30)), EnergyState.peak);
    });

    test('no windows set -> neutral', () {
      expect(_persona().energyStateAt(_at(10, 0)), EnergyState.neutral);
    });

    test('energy level maps from state', () {
      final p = _persona(peakStart: '09:00', peakEnd: '12:00');
      expect(p.energyStateAt(_at(10, 0)).level, 10);
      expect(p.energyStateAt(_at(20, 0)).level, 5);
    });
  });
}
