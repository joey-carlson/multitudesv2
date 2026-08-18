import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/persona.dart';

Persona _persona({required double ideal}) => Persona(
      userId: 'u',
      name: 'T',
      emoji: '🧪',
      archetype: PersonaArchetype.professional,
      primaryEnergy: '',
      strengths: const [],
      weaknesses: const [],
      triggerConditions: const [],
      idealTasks: const [],
      idealWeeklyHours: ideal,
    );

void main() {
  group('Persona.balanceScore', () {
    test('on-target scores 1.0', () {
      expect(_persona(ideal: 40).balanceScore(40), 1.0);
    });

    test('underserved scales with ratio', () {
      expect(_persona(ideal: 40).balanceScore(10), closeTo(0.25, 1e-9));
    });

    test('overworked diminishes toward 0', () {
      expect(_persona(ideal: 40).balanceScore(80), 0.0); // 2 - 2.0
      expect(_persona(ideal: 40).balanceScore(60), closeTo(0.5, 1e-9)); // 2 - 1.5
    });

    test('no target set -> neutral 0.5', () {
      expect(_persona(ideal: 0).balanceScore(5), 0.5);
    });

    test('stays within 0..1 for negative or huge inputs', () {
      expect(_persona(ideal: 40).balanceScore(-5), 0.0); // clamped
      expect(_persona(ideal: 40).balanceScore(1000), 0.0); // over-fed clamps
      expect(_persona(ideal: -10).balanceScore(5), 0.5); // negative target guard
    });
  });

  group('Persona.fedState', () {
    test('below 50% of target is starving', () {
      expect(_persona(ideal: 40).fedState(10), FedState.starving); // 25%
      expect(_persona(ideal: 40).fedState(19), FedState.starving); // 47.5%
    });

    test('within 50%-115% is fed', () {
      expect(_persona(ideal: 40).fedState(20), FedState.fed); // 50%
      expect(_persona(ideal: 40).fedState(40), FedState.fed); // 100%
      expect(_persona(ideal: 40).fedState(46), FedState.fed); // 115%
    });

    test('above 115% is over-fed', () {
      expect(_persona(ideal: 40).fedState(50), FedState.overFed); // 125%
    });

    test('no weekly target -> noTarget', () {
      expect(_persona(ideal: 0).fedState(5), FedState.noTarget);
    });
  });
}
