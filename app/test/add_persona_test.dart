import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/domain/persona.dart';

void main() {
  group('personaFromTemplate', () {
    test('uses template defaults when no overrides', () {
      final p = personaFromTemplate(PersonaArchetype.professional, userId: 'u');
      expect(p.archetype, PersonaArchetype.professional);
      expect(p.name, 'The Professional');
      expect(p.emoji, '🧠');
      expect(p.peakStartTime, '07:00');
      expect(p.peakEndTime, '11:00');
      expect(p.strengths, isNotEmpty); // carried from template
      expect(p.idealTasks, isNotEmpty);
    });

    test('applies overrides', () {
      final p = personaFromTemplate(
        PersonaArchetype.artist,
        userId: 'u',
        name: 'Creative Chris',
        emoji: '🖌️',
        peakStart: '20:00',
        peakEnd: '23:00',
        idealWeeklyHours: 8,
      );
      expect(p.name, 'Creative Chris');
      expect(p.emoji, '🖌️');
      expect(p.peakStartTime, '20:00');
      expect(p.peakEndTime, '23:00');
      expect(p.idealWeeklyHours, 8);
      expect(p.archetype, PersonaArchetype.artist);
    });

    test('blank overrides fall back to template', () {
      final p = personaFromTemplate(PersonaArchetype.builder,
          userId: 'u', name: '  ', emoji: '  ');
      expect(p.name, 'The Tinkerer');
      expect(p.emoji, '🛠');
    });
  });

  group('personaCustom', () {
    test('builds a custom persona', () {
      final p = personaCustom(
        userId: 'u',
        name: 'Night Owl',
        emoji: '🦉',
        primaryEnergy: 'Quiet, focused, nocturnal',
        peakStart: '22:00',
        peakEnd: '01:00',
        idealWeeklyHours: 5,
      );
      expect(p.archetype, PersonaArchetype.custom);
      expect(p.name, 'Night Owl');
      expect(p.emoji, '🦉');
      expect(p.peakStartTime, '22:00');
      expect(p.strengths, isEmpty);
      expect(p.idealWeeklyHours, 5);
    });

    test('defaults emoji when blank', () {
      final p = personaCustom(userId: 'u', name: 'X', emoji: '');
      expect(p.emoji, '✨');
    });
  });
}
