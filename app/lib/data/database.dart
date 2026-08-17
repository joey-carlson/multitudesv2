/// On-device SQLite database (Drift) — the local source of truth.
///
/// Mirrors the persona schema from the Python/SQLAlchemy models. Runs entirely
/// on-device; an optional sync server is layered on later (ARCHITECTURE §0.3).
library;

import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../domain/calendar_classification.dart';
import '../domain/energy_reading.dart';
import '../domain/persona.dart';
import '../domain/task.dart';

part 'database.g.dart';

/// Stores a `List<String>` as a JSON text column (portable, mirrors the
/// server-side JSON columns).
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List).cast<String>();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

/// Personas table — mirrors src/shared/database/models.py `Persona`.
/// The generated row class is named `PersonaRow` to avoid colliding with the
/// domain `Persona` type.
@DataClassName('PersonaRow')
class Personas extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get emoji => text().withDefault(const Constant('✨'))();
  TextColumn get archetype => text()();
  TextColumn get primaryEnergy => text().nullable()();
  TextColumn get strengths =>
      text().map(const StringListConverter()).nullable()();
  TextColumn get weaknesses =>
      text().map(const StringListConverter()).nullable()();
  TextColumn get triggerConditions =>
      text().map(const StringListConverter()).nullable()();
  TextColumn get idealTasks =>
      text().map(const StringListConverter()).nullable()();
  TextColumn get peakStartTime => text().nullable()();
  TextColumn get peakEndTime => text().nullable()();
  TextColumn get troughStartTime => text().nullable()();
  TextColumn get troughEndTime => text().nullable()();
  TextColumn get recoveryStartTime => text().nullable()();
  TextColumn get recoveryEndTime => text().nullable()();
  RealColumn get idealWeeklyHours => real().withDefault(const Constant(0.0))();
  RealColumn get actualWeeklyHours => real().withDefault(const Constant(0.0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Energy readings — mirrors src/shared/database/models.py `EnergyReading`.
@DataClassName('EnergyReadingRow')
class EnergyReadings extends Table {
  TextColumn get id => text()();
  TextColumn get personaId =>
      text().references(Personas, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  IntColumn get energyLevel => integer()();
  RealColumn get confidence => real().withDefault(const Constant(0.5))();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tasks — a focused mirror of src/shared/database/models.py `Task`.
@DataClassName('TaskRow')
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get personaId =>
      text().references(Personas, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  IntColumn get energyRequired => integer().withDefault(const Constant(3))();
  IntColumn get priority => integer().withDefault(const Constant(3))();
  IntColumn get estimatedMinutes => integer().withDefault(const Constant(30))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// User's work/personal/ignore tag per calendar id.
@DataClassName('CalendarPrefRow')
class CalendarPrefs extends Table {
  TextColumn get calendarId => text()();
  TextColumn get kind => text()(); // stores CalendarKind.name

  @override
  Set<Column> get primaryKey => {calendarId};
}

/// Individual calendar events the user has excluded from Multitudes.
@DataClassName('HiddenEventRow')
class HiddenEvents extends Table {
  TextColumn get eventId => text()();

  @override
  Set<Column> get primaryKey => {eventId};
}

@DriftDatabase(tables: [Personas, EnergyReadings, Tasks, CalendarPrefs, HiddenEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'multitudes'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Create whichever tables the existing database predates.
          if (from < 2) await m.createTable(energyReadings);
          if (from < 3) await m.createTable(tasks);
          if (from < 4) await m.createTable(calendarPrefs);
          if (from < 5) await m.createTable(hiddenEvents);
        },
      );

  /// Ids of events the user has hidden from consideration.
  Future<Set<String>> hiddenEventIds() async {
    final rows = await select(hiddenEvents).get();
    return rows.map((r) => r.eventId).toSet();
  }

  /// Hide or unhide a single event.
  Future<void> setEventHidden(String eventId, bool hidden) async {
    if (hidden) {
      await into(hiddenEvents)
          .insertOnConflictUpdate(HiddenEventsCompanion.insert(eventId: eventId));
    } else {
      await (delete(hiddenEvents)..where((t) => t.eventId.equals(eventId))).go();
    }
  }

  /// User overrides of calendar classification, by calendar id.
  Future<Map<String, CalendarKind>> calendarKinds() async {
    final rows = await select(calendarPrefs).get();
    return {
      for (final r in rows)
        r.calendarId: CalendarKind.values.firstWhere(
          (k) => k.name == r.kind,
          orElse: () => CalendarKind.unset,
        )
    };
  }

  /// Set (or clear) a calendar's classification.
  Future<void> setCalendarKind(String calendarId, CalendarKind kind) async {
    await into(calendarPrefs).insertOnConflictUpdate(
      CalendarPrefsCompanion.insert(calendarId: calendarId, kind: kind.name),
    );
  }

  /// Persist generated personas. IDs are client-generated (offline-safe).
  Future<void> savePersonas(List<Persona> personas) async {
    await batch((b) {
      for (final p in personas) {
        b.insert(this.personas, _toCompanion(p));
      }
    });
  }

  /// Active personas for a user, oldest first.
  Future<List<Persona>> activePersonas(String userId) async {
    final rows = await (select(personas)
          ..where((t) => t.userId.equals(userId) & t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    return rows.map(_fromRow).toList();
  }

  /// Record an energy check-in.
  Future<void> logEnergyReading(EnergyReading reading) async {
    await into(energyReadings).insert(EnergyReadingsCompanion.insert(
      id: _newId(),
      personaId: reading.personaId,
      energyLevel: reading.energyLevel,
      timestamp: Value(reading.timestamp),
      source: Value(reading.source),
      notes: Value(reading.notes),
    ));
  }

  /// Most recent readings for a persona (newest first).
  Future<List<EnergyReading>> recentReadings(String personaId,
      {int limit = 10}) async {
    final rows = await (select(energyReadings)
          ..where((t) => t.personaId.equals(personaId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(limit))
        .get();
    return [
      for (final r in rows)
        EnergyReading(
          personaId: r.personaId,
          energyLevel: r.energyLevel,
          timestamp: r.timestamp,
          source: r.source,
          notes: r.notes,
        )
    ];
  }

  /// Add a task.
  Future<void> addTask(Task task) async {
    await into(tasks).insert(TasksCompanion.insert(
      id: _newId(),
      userId: task.userId,
      personaId: task.personaId,
      title: task.title,
      energyRequired: Value(task.energyRequired),
      priority: Value(task.priority),
      estimatedMinutes: Value(task.estimatedMinutes),
      completed: Value(task.completed),
      completedAt: Value(task.completedAt),
      createdAt: Value(task.createdAt),
    ));
  }

  /// Tasks for a persona: incomplete first, then most-recently created.
  Future<List<Task>> tasksForPersona(String personaId) async {
    final rows = await (select(tasks)
          ..where((t) => t.personaId.equals(personaId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.completed),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .get();
    return rows.map(_taskFromRow).toList();
  }

  /// Mark a task complete/incomplete, stamping completedAt.
  Future<void> setTaskCompleted(String taskId, bool completed) async {
    await (update(tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        completed: Value(completed),
        completedAt: Value(completed ? DateTime.now() : null),
      ),
    );
  }

  /// Actual weekly hours per persona = sum of estimated minutes of tasks
  /// completed on/after [since] (default: 7 days ago), grouped by persona.
  Future<Map<String, double>> actualWeeklyHours(String userId,
      {DateTime? since}) async {
    final cutoff = since ?? DateTime.now().subtract(const Duration(days: 7));
    final rows = await (select(tasks)
          ..where((t) =>
              t.userId.equals(userId) &
              t.completed.equals(true) &
              t.completedAt.isBiggerOrEqualValue(cutoff)))
        .get();
    final byPersona = <String, double>{};
    for (final r in rows) {
      byPersona[r.personaId] =
          (byPersona[r.personaId] ?? 0) + r.estimatedMinutes / 60.0;
    }
    return byPersona;
  }

  Task _taskFromRow(TaskRow r) => Task(
        id: r.id,
        userId: r.userId,
        personaId: r.personaId,
        title: r.title,
        energyRequired: r.energyRequired,
        priority: r.priority,
        estimatedMinutes: r.estimatedMinutes,
        completed: r.completed,
        completedAt: r.completedAt,
        createdAt: r.createdAt,
      );

  PersonasCompanion _toCompanion(Persona p) => PersonasCompanion.insert(
        id: p.id ?? _newId(),
        userId: p.userId,
        name: p.name,
        emoji: Value(p.emoji),
        archetype: p.archetype.value,
        primaryEnergy: Value(p.primaryEnergy),
        strengths: Value(p.strengths),
        weaknesses: Value(p.weaknesses),
        triggerConditions: Value(p.triggerConditions),
        idealTasks: Value(p.idealTasks),
        peakStartTime: Value(p.peakStartTime),
        peakEndTime: Value(p.peakEndTime),
        troughStartTime: Value(p.troughStartTime),
        troughEndTime: Value(p.troughEndTime),
        recoveryStartTime: Value(p.recoveryStartTime),
        recoveryEndTime: Value(p.recoveryEndTime),
        idealWeeklyHours: Value(p.idealWeeklyHours),
        actualWeeklyHours: Value(p.actualWeeklyHours),
        isActive: Value(p.isActive),
      );

  Persona _fromRow(PersonaRow row) => Persona(
        id: row.id,
        userId: row.userId,
        name: row.name,
        emoji: row.emoji,
        archetype: PersonaArchetype.values.firstWhere(
          (a) => a.value == row.archetype,
          orElse: () => PersonaArchetype.custom,
        ),
        primaryEnergy: row.primaryEnergy ?? '',
        strengths: row.strengths ?? const [],
        weaknesses: row.weaknesses ?? const [],
        triggerConditions: row.triggerConditions ?? const [],
        idealTasks: row.idealTasks ?? const [],
        peakStartTime: row.peakStartTime,
        peakEndTime: row.peakEndTime,
        troughStartTime: row.troughStartTime,
        troughEndTime: row.troughEndTime,
        recoveryStartTime: row.recoveryStartTime,
        recoveryEndTime: row.recoveryEndTime,
        idealWeeklyHours: row.idealWeeklyHours,
        actualWeeklyHours: row.actualWeeklyHours,
        isActive: row.isActive,
      );
}

/// Client-generated 32-char hex id (matches the Python UUID-without-dashes id).
String _newId() {
  final rng = Random.secure();
  final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
