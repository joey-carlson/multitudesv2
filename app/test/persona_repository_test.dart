/// On-device persistence loop test: survey -> generate -> save -> read back,
/// against an in-memory SQLite database. Proves the local-first storage path.
library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/data/database.dart';
import 'package:multitudes/domain/persona_generator.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  test('generate -> save -> read back preserves personas and energy patterns',
      () async {
    // Arrange
    final personas = generatePersonasFromSurvey('u1', {
      'archetypes_selection': [
        '🧠 The Professional - Responsible, structured, goal-focused',
        '🎨 The Artist - Expressive, introspective, imaginative',
      ],
      'custom_persona_names': 'Executive Emma, Creative Chris',
      'overall_energy_pattern': 'Early morning (7am-9am) - Pre-business hours',
      'energy_dip': 'Yes, I notice a definite slump',
      'energy_dip_time': 'Early afternoon (12pm-2pm)',
      'weekly_time_allocation': 'Work: 40hrs, Creative: 10hrs',
    });

    // Act
    await db.savePersonas(personas);
    final saved = await db.activePersonas('u1');

    // Assert
    expect(saved.length, 2);
    final emma = saved.firstWhere((p) => p.name == 'Executive Emma');
    expect(emma.emoji, '🧠');
    expect(emma.peakStartTime, '07:00'); // fixed mapping, not template default
    expect(emma.peakEndTime, '09:00');
    expect(emma.troughStartTime, '12:00');
    expect(emma.idealWeeklyHours, 40.0);
    expect(emma.strengths, isNotEmpty); // JSON list round-tripped
  });

  test('activePersonas isolates by user', () async {
    await db.savePersonas(generatePersonasFromSurvey('u1', {
      'archetypes_selection': ['🧠 The Professional'],
    }));
    final other = await db.activePersonas('someone-else');
    expect(other, isEmpty);
  });
}
