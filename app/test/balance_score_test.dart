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
  });
}
