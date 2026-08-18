/// On-device persistence loop test: survey -> generate -> save -> read back,
/// against an in-memory SQLite database. Proves the local-first storage path.
library;

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/data/database.dart';
import 'package:multitudes/domain/calendar_classification.dart';
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

  test('calendar kinds: set, read back, and update', () async {
    expect(await db.calendarKinds(), isEmpty);

    await db.setCalendarKind('cal-1', CalendarKind.work);
    await db.setCalendarKind('cal-2', CalendarKind.personal);
    var kinds = await db.calendarKinds();
    expect(kinds['cal-1'], CalendarKind.work);
    expect(kinds['cal-2'], CalendarKind.personal);

    // Overwrite existing (upsert on primary key)
    await db.setCalendarKind('cal-1', CalendarKind.ignore);
    kinds = await db.calendarKinds();
    expect(kinds['cal-1'], CalendarKind.ignore);
  });

  test('hidden events: hide, read back, and unhide', () async {
    expect(await db.hiddenEventIds(), isEmpty);

    await db.setEventHidden('evt-1', true);
    await db.setEventHidden('evt-2', true);
    expect(await db.hiddenEventIds(), {'evt-1', 'evt-2'});

    await db.setEventHidden('evt-1', false);
    expect(await db.hiddenEventIds(), {'evt-2'});
  });

  test('event persona overrides: set, read back, update, and clear', () async {
    expect(await db.eventPersonaMap(), isEmpty);

    await db.setEventPersona('evt-1', 'persona-a');
    expect((await db.eventPersonaMap())['evt-1'], 'persona-a');

    // Reassign (upsert)
    await db.setEventPersona('evt-1', 'persona-b');
    expect((await db.eventPersonaMap())['evt-1'], 'persona-b');

    // Clear
    await db.setEventPersona('evt-1', null);
    expect(await db.eventPersonaMap(), isEmpty);
  });

  test('energy impacts: set, read back, update, and clear', () async {
    expect(await db.energyImpactMap(), isEmpty);

    await db.setEventEnergyImpact('evt-1', 2);
    await db.setEventEnergyImpact('evt-2', -2);
    expect(await db.energyImpactMap(), {'evt-1': 2, 'evt-2': -2});

    await db.setEventEnergyImpact('evt-1', -1); // upsert
    expect((await db.energyImpactMap())['evt-1'], -1);

    await db.setEventEnergyImpact('evt-1', null); // clear
    expect((await db.energyImpactMap()).containsKey('evt-1'), isFalse);
  });
}
