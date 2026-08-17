/// On-device persistence loop test: survey -> generate -> save -> read back,
/// against an in-memory SQLite database. Proves the local-first storage path.
library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/data/database.dart';
import 'package:multitudes/domain/energy_reading.dart';
import 'package:multitudes/domain/persona_generator.dart';
import 'package:multitudes/domain/task.dart';

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

  test('energy readings: log and read back newest-first for a persona',
      () async {
    // Arrange: persist a persona and grab its stored id
    await db.savePersonas(generatePersonasFromSurvey('u1', {
      'archetypes_selection': ['🧠 The Professional'],
    }));
    final personaId = (await db.activePersonas('u1')).single.id!;

    // Act
    await db.logEnergyReading(EnergyReading(
        personaId: personaId, energyLevel: 4, timestamp: DateTime(2026, 1, 1, 9)));
    await db.logEnergyReading(EnergyReading(
        personaId: personaId, energyLevel: 8, timestamp: DateTime(2026, 1, 1, 15)));
    final readings = await db.recentReadings(personaId);

    // Assert: newest first
    expect(readings.map((r) => r.energyLevel).toList(), [8, 4]);
    expect(readings.first.personaId, personaId);
  });

  test('tasks: add, list incomplete-first, and complete', () async {
    await db.savePersonas(generatePersonasFromSurvey('u1', {
      'archetypes_selection': ['🧠 The Professional'],
    }));
    final pid = (await db.activePersonas('u1')).single.id!;

    await db.addTask(Task(userId: 'u1', personaId: pid, title: 'A'));
    await db.addTask(Task(userId: 'u1', personaId: pid, title: 'B'));
    var tasks = await db.tasksForPersona(pid);
    expect(tasks.length, 2);

    await db.setTaskCompleted(tasks.first.id!, true);
    tasks = await db.tasksForPersona(pid);
    expect(tasks.first.completed, isFalse); // incomplete sorts first
    expect(tasks.where((t) => t.completed).length, 1);
  });

  test('actualWeeklyHours sums completed durations within the window',
      () async {
    await db.savePersonas(generatePersonasFromSurvey('u1', {
      'archetypes_selection': ['🧠 The Professional'],
    }));
    final pid = (await db.activePersonas('u1')).single.id!;
    final since = DateTime(2026, 1, 1);

    // Completed within window: 60 + 30 min = 1.5h
    await db.addTask(Task(
        userId: 'u1',
        personaId: pid,
        title: 'r1',
        estimatedMinutes: 60,
        completed: true,
        completedAt: DateTime(2026, 1, 5)));
    await db.addTask(Task(
        userId: 'u1',
        personaId: pid,
        title: 'r2',
        estimatedMinutes: 30,
        completed: true,
        completedAt: DateTime(2026, 1, 6)));
    // Completed before window -> excluded
    await db.addTask(Task(
        userId: 'u1',
        personaId: pid,
        title: 'old',
        estimatedMinutes: 120,
        completed: true,
        completedAt: DateTime(2025, 12, 1)));
    // Incomplete -> excluded
    await db.addTask(
        Task(userId: 'u1', personaId: pid, title: 'todo', estimatedMinutes: 120));

    final hours = await db.actualWeeklyHours('u1', since: since);
    expect(hours[pid], closeTo(1.5, 1e-9));
  });
}
