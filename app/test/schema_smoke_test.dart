import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multitudes/data/database.dart';
import 'package:multitudes/domain/calendar_classification.dart';
import 'package:multitudes/domain/energy_reading.dart';
import 'package:multitudes/domain/habit.dart';
import 'package:multitudes/domain/persona.dart';
import 'package:multitudes/domain/persona_generator.dart';
import 'package:multitudes/domain/task.dart';

/// Fresh-install schema integrity: a brand-new database (onCreate → createAll)
/// must support one real operation against every table/feature. If any table or
/// column is missing from the fresh schema, one of these calls throws.
void main() {
  late AppDatabase db;
  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() async => db.close());

  test('every feature persists on a fresh database', () async {
    // personas
    await db.savePersonas(generatePersonasFromSurvey('u1', {
      'archetypes_selection': ['🧠 The Professional'],
    }));
    final pid = (await db.activePersonas('u1')).single.id!;

    // tasks + actual hours
    await db.addTask(Task(userId: 'u1', personaId: pid, title: 'T'));
    expect((await db.tasksForPersona(pid)).length, 1);
    await db.actualWeeklyHours('u1');

    // energy readings
    await db.logEnergyReading(
        EnergyReading(personaId: pid, energyLevel: 7, timestamp: DateTime(2026, 1, 1)));
    expect((await db.recentReadings(pid)).length, 1);

    // calendar prefs / hidden / persona override / energy impact / learned
    await db.setCalendarKind('cal-1', CalendarKind.work);
    expect((await db.calendarKinds())['cal-1'], CalendarKind.work);
    await db.setEventHidden('e1', true);
    expect(await db.hiddenEventIds(), {'e1'});
    await db.setEventPersona('e1', pid);
    expect((await db.eventPersonaMap())['e1'], pid);
    await db.setEventEnergyImpact('e1', 2);
    expect((await db.energyImpactMap())['e1'], 2);
    await db.recordAssignmentTokens(pid, {'book'});
    expect((await db.learnedTokensByPersona())[pid], contains('book'));

    // habits + completions
    await db.addHabit(Habit(userId: 'u1', personaId: pid, title: 'H'));
    final hid = (await db.habitsWithCompletions(pid)).single.$1.id!;
    await db.setHabitDone(hid, DateTime(2026, 1, 1), true);
    expect((await db.habitsWithCompletions(pid)).single.$2, isNotEmpty);

    // journal
    await db.addJournalEntry(userId: 'u1', personaId: pid, body: 'entry');
    expect((await db.journalEntriesForPersona(pid)).length, 1);

    // day log
    await db.saveDayLog(DateTime(2026, 1, 1), intention: 'Focus');
    expect((await db.dayLog(DateTime(2026, 1, 1)))!.intention, 'Focus');

    // update persona
    final p = (await db.activePersonas('u1')).single;
    await db.updatePersona(Persona(
      id: p.id,
      userId: p.userId,
      name: 'Renamed',
      emoji: p.emoji,
      archetype: p.archetype,
      primaryEnergy: p.primaryEnergy,
      strengths: p.strengths,
      weaknesses: p.weaknesses,
      triggerConditions: p.triggerConditions,
      idealTasks: p.idealTasks,
      idealWeeklyHours: 10,
    ));
    expect((await db.activePersonas('u1')).single.name, 'Renamed');
  });
}
