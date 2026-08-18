import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/energy_impact.dart';
import 'package:multitudes/domain/persona.dart';

Persona _p({String? peakStart, String? peakEnd, String? troughStart, String? troughEnd, String? recStart, String? recEnd}) =>
    Persona(
      userId: 'u',
      name: 'T',
      emoji: '🧩',
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
      recoveryStartTime: recStart,
      recoveryEndTime: recEnd,
    );

DateTime _at(int h) => DateTime(2026, 1, 1, h);

void main() {
  group('estimateEnergyImpact', () {
    test('no persona -> neutral', () {
      expect(estimateEnergyImpact(null, _at(10)), EnergyImpact.neutral);
    });

    test('during peak -> energizing', () {
      final p = _p(peakStart: '09:00', peakEnd: '12:00');
      expect(estimateEnergyImpact(p, _at(10)), EnergyImpact.energizing);
    });

    test('during trough -> somewhat draining', () {
      final p = _p(troughStart: '14:00', troughEnd: '16:00');
      expect(estimateEnergyImpact(p, _at(15)), EnergyImpact.somewhatDraining);
    });

    test('during recovery -> somewhat energizing', () {
      final p = _p(recStart: '16:00', recEnd: '18:00');
      expect(estimateEnergyImpact(p, _at(17)), EnergyImpact.somewhatEnergizing);
    });

    test('outside any window -> neutral', () {
      final p = _p(peakStart: '09:00', peakEnd: '12:00');
      expect(estimateEnergyImpact(p, _at(20)), EnergyImpact.neutral);
    });
  });

  group('EnergyImpact.fromValue', () {
    test('round-trips values', () {
      for (final e in EnergyImpact.values) {
        expect(EnergyImpact.fromValue(e.value), e);
      }
    });

    test('unknown value -> neutral', () {
      expect(EnergyImpact.fromValue(99), EnergyImpact.neutral);
    });
  });
}
