// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonasTable extends Personas
    with TableInfo<$PersonasTable, PersonaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('✨'),
  );
  static const VerificationMeta _archetypeMeta = const VerificationMeta(
    'archetype',
  );
  @override
  late final GeneratedColumn<String> archetype = GeneratedColumn<String>(
    'archetype',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryEnergyMeta = const VerificationMeta(
    'primaryEnergy',
  );
  @override
  late final GeneratedColumn<String> primaryEnergy = GeneratedColumn<String>(
    'primary_energy',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> strengths =
      GeneratedColumn<String>(
        'strengths',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($PersonasTable.$converterstrengthsn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  weaknesses = GeneratedColumn<String>(
    'weaknesses',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($PersonasTable.$converterweaknessesn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  triggerConditions = GeneratedColumn<String>(
    'trigger_conditions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($PersonasTable.$convertertriggerConditionsn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String>
  idealTasks = GeneratedColumn<String>(
    'ideal_tasks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<List<String>?>($PersonasTable.$converteridealTasksn);
  static const VerificationMeta _peakStartTimeMeta = const VerificationMeta(
    'peakStartTime',
  );
  @override
  late final GeneratedColumn<String> peakStartTime = GeneratedColumn<String>(
    'peak_start_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _peakEndTimeMeta = const VerificationMeta(
    'peakEndTime',
  );
  @override
  late final GeneratedColumn<String> peakEndTime = GeneratedColumn<String>(
    'peak_end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _troughStartTimeMeta = const VerificationMeta(
    'troughStartTime',
  );
  @override
  late final GeneratedColumn<String> troughStartTime = GeneratedColumn<String>(
    'trough_start_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _troughEndTimeMeta = const VerificationMeta(
    'troughEndTime',
  );
  @override
  late final GeneratedColumn<String> troughEndTime = GeneratedColumn<String>(
    'trough_end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recoveryStartTimeMeta = const VerificationMeta(
    'recoveryStartTime',
  );
  @override
  late final GeneratedColumn<String> recoveryStartTime =
      GeneratedColumn<String>(
        'recovery_start_time',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _recoveryEndTimeMeta = const VerificationMeta(
    'recoveryEndTime',
  );
  @override
  late final GeneratedColumn<String> recoveryEndTime = GeneratedColumn<String>(
    'recovery_end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idealWeeklyHoursMeta = const VerificationMeta(
    'idealWeeklyHours',
  );
  @override
  late final GeneratedColumn<double> idealWeeklyHours = GeneratedColumn<double>(
    'ideal_weekly_hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _actualWeeklyHoursMeta = const VerificationMeta(
    'actualWeeklyHours',
  );
  @override
  late final GeneratedColumn<double> actualWeeklyHours =
      GeneratedColumn<double>(
        'actual_weekly_hours',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    emoji,
    archetype,
    primaryEnergy,
    strengths,
    weaknesses,
    triggerConditions,
    idealTasks,
    peakStartTime,
    peakEndTime,
    troughStartTime,
    troughEndTime,
    recoveryStartTime,
    recoveryEndTime,
    idealWeeklyHours,
    actualWeeklyHours,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personas';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    if (data.containsKey('archetype')) {
      context.handle(
        _archetypeMeta,
        archetype.isAcceptableOrUnknown(data['archetype']!, _archetypeMeta),
      );
    } else if (isInserting) {
      context.missing(_archetypeMeta);
    }
    if (data.containsKey('primary_energy')) {
      context.handle(
        _primaryEnergyMeta,
        primaryEnergy.isAcceptableOrUnknown(
          data['primary_energy']!,
          _primaryEnergyMeta,
        ),
      );
    }
    if (data.containsKey('peak_start_time')) {
      context.handle(
        _peakStartTimeMeta,
        peakStartTime.isAcceptableOrUnknown(
          data['peak_start_time']!,
          _peakStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('peak_end_time')) {
      context.handle(
        _peakEndTimeMeta,
        peakEndTime.isAcceptableOrUnknown(
          data['peak_end_time']!,
          _peakEndTimeMeta,
        ),
      );
    }
    if (data.containsKey('trough_start_time')) {
      context.handle(
        _troughStartTimeMeta,
        troughStartTime.isAcceptableOrUnknown(
          data['trough_start_time']!,
          _troughStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('trough_end_time')) {
      context.handle(
        _troughEndTimeMeta,
        troughEndTime.isAcceptableOrUnknown(
          data['trough_end_time']!,
          _troughEndTimeMeta,
        ),
      );
    }
    if (data.containsKey('recovery_start_time')) {
      context.handle(
        _recoveryStartTimeMeta,
        recoveryStartTime.isAcceptableOrUnknown(
          data['recovery_start_time']!,
          _recoveryStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('recovery_end_time')) {
      context.handle(
        _recoveryEndTimeMeta,
        recoveryEndTime.isAcceptableOrUnknown(
          data['recovery_end_time']!,
          _recoveryEndTimeMeta,
        ),
      );
    }
    if (data.containsKey('ideal_weekly_hours')) {
      context.handle(
        _idealWeeklyHoursMeta,
        idealWeeklyHours.isAcceptableOrUnknown(
          data['ideal_weekly_hours']!,
          _idealWeeklyHoursMeta,
        ),
      );
    }
    if (data.containsKey('actual_weekly_hours')) {
      context.handle(
        _actualWeeklyHoursMeta,
        actualWeeklyHours.isAcceptableOrUnknown(
          data['actual_weekly_hours']!,
          _actualWeeklyHoursMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      archetype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}archetype'],
      )!,
      primaryEnergy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_energy'],
      ),
      strengths: $PersonasTable.$converterstrengthsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}strengths'],
        ),
      ),
      weaknesses: $PersonasTable.$converterweaknessesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}weaknesses'],
        ),
      ),
      triggerConditions: $PersonasTable.$convertertriggerConditionsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}trigger_conditions'],
        ),
      ),
      idealTasks: $PersonasTable.$converteridealTasksn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}ideal_tasks'],
        ),
      ),
      peakStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}peak_start_time'],
      ),
      peakEndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}peak_end_time'],
      ),
      troughStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trough_start_time'],
      ),
      troughEndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trough_end_time'],
      ),
      recoveryStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_start_time'],
      ),
      recoveryEndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recovery_end_time'],
      ),
      idealWeeklyHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ideal_weekly_hours'],
      )!,
      actualWeeklyHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_weekly_hours'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PersonasTable createAlias(String alias) {
    return $PersonasTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterstrengths =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterstrengthsn =
      NullAwareTypeConverter.wrap($converterstrengths);
  static TypeConverter<List<String>, String> $converterweaknesses =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterweaknessesn =
      NullAwareTypeConverter.wrap($converterweaknesses);
  static TypeConverter<List<String>, String> $convertertriggerConditions =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertriggerConditionsn =
      NullAwareTypeConverter.wrap($convertertriggerConditions);
  static TypeConverter<List<String>, String> $converteridealTasks =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converteridealTasksn =
      NullAwareTypeConverter.wrap($converteridealTasks);
}

class PersonaRow extends DataClass implements Insertable<PersonaRow> {
  final String id;
  final String userId;
  final String name;
  final String emoji;
  final String archetype;
  final String? primaryEnergy;
  final List<String>? strengths;
  final List<String>? weaknesses;
  final List<String>? triggerConditions;
  final List<String>? idealTasks;
  final String? peakStartTime;
  final String? peakEndTime;
  final String? troughStartTime;
  final String? troughEndTime;
  final String? recoveryStartTime;
  final String? recoveryEndTime;
  final double idealWeeklyHours;
  final double actualWeeklyHours;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PersonaRow({
    required this.id,
    required this.userId,
    required this.name,
    required this.emoji,
    required this.archetype,
    this.primaryEnergy,
    this.strengths,
    this.weaknesses,
    this.triggerConditions,
    this.idealTasks,
    this.peakStartTime,
    this.peakEndTime,
    this.troughStartTime,
    this.troughEndTime,
    this.recoveryStartTime,
    this.recoveryEndTime,
    required this.idealWeeklyHours,
    required this.actualWeeklyHours,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['emoji'] = Variable<String>(emoji);
    map['archetype'] = Variable<String>(archetype);
    if (!nullToAbsent || primaryEnergy != null) {
      map['primary_energy'] = Variable<String>(primaryEnergy);
    }
    if (!nullToAbsent || strengths != null) {
      map['strengths'] = Variable<String>(
        $PersonasTable.$converterstrengthsn.toSql(strengths),
      );
    }
    if (!nullToAbsent || weaknesses != null) {
      map['weaknesses'] = Variable<String>(
        $PersonasTable.$converterweaknessesn.toSql(weaknesses),
      );
    }
    if (!nullToAbsent || triggerConditions != null) {
      map['trigger_conditions'] = Variable<String>(
        $PersonasTable.$convertertriggerConditionsn.toSql(triggerConditions),
      );
    }
    if (!nullToAbsent || idealTasks != null) {
      map['ideal_tasks'] = Variable<String>(
        $PersonasTable.$converteridealTasksn.toSql(idealTasks),
      );
    }
    if (!nullToAbsent || peakStartTime != null) {
      map['peak_start_time'] = Variable<String>(peakStartTime);
    }
    if (!nullToAbsent || peakEndTime != null) {
      map['peak_end_time'] = Variable<String>(peakEndTime);
    }
    if (!nullToAbsent || troughStartTime != null) {
      map['trough_start_time'] = Variable<String>(troughStartTime);
    }
    if (!nullToAbsent || troughEndTime != null) {
      map['trough_end_time'] = Variable<String>(troughEndTime);
    }
    if (!nullToAbsent || recoveryStartTime != null) {
      map['recovery_start_time'] = Variable<String>(recoveryStartTime);
    }
    if (!nullToAbsent || recoveryEndTime != null) {
      map['recovery_end_time'] = Variable<String>(recoveryEndTime);
    }
    map['ideal_weekly_hours'] = Variable<double>(idealWeeklyHours);
    map['actual_weekly_hours'] = Variable<double>(actualWeeklyHours);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersonasCompanion toCompanion(bool nullToAbsent) {
    return PersonasCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      emoji: Value(emoji),
      archetype: Value(archetype),
      primaryEnergy: primaryEnergy == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryEnergy),
      strengths: strengths == null && nullToAbsent
          ? const Value.absent()
          : Value(strengths),
      weaknesses: weaknesses == null && nullToAbsent
          ? const Value.absent()
          : Value(weaknesses),
      triggerConditions: triggerConditions == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerConditions),
      idealTasks: idealTasks == null && nullToAbsent
          ? const Value.absent()
          : Value(idealTasks),
      peakStartTime: peakStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(peakStartTime),
      peakEndTime: peakEndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(peakEndTime),
      troughStartTime: troughStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(troughStartTime),
      troughEndTime: troughEndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(troughEndTime),
      recoveryStartTime: recoveryStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryStartTime),
      recoveryEndTime: recoveryEndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveryEndTime),
      idealWeeklyHours: Value(idealWeeklyHours),
      actualWeeklyHours: Value(actualWeeklyHours),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersonaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonaRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String>(json['emoji']),
      archetype: serializer.fromJson<String>(json['archetype']),
      primaryEnergy: serializer.fromJson<String?>(json['primaryEnergy']),
      strengths: serializer.fromJson<List<String>?>(json['strengths']),
      weaknesses: serializer.fromJson<List<String>?>(json['weaknesses']),
      triggerConditions: serializer.fromJson<List<String>?>(
        json['triggerConditions'],
      ),
      idealTasks: serializer.fromJson<List<String>?>(json['idealTasks']),
      peakStartTime: serializer.fromJson<String?>(json['peakStartTime']),
      peakEndTime: serializer.fromJson<String?>(json['peakEndTime']),
      troughStartTime: serializer.fromJson<String?>(json['troughStartTime']),
      troughEndTime: serializer.fromJson<String?>(json['troughEndTime']),
      recoveryStartTime: serializer.fromJson<String?>(
        json['recoveryStartTime'],
      ),
      recoveryEndTime: serializer.fromJson<String?>(json['recoveryEndTime']),
      idealWeeklyHours: serializer.fromJson<double>(json['idealWeeklyHours']),
      actualWeeklyHours: serializer.fromJson<double>(json['actualWeeklyHours']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String>(emoji),
      'archetype': serializer.toJson<String>(archetype),
      'primaryEnergy': serializer.toJson<String?>(primaryEnergy),
      'strengths': serializer.toJson<List<String>?>(strengths),
      'weaknesses': serializer.toJson<List<String>?>(weaknesses),
      'triggerConditions': serializer.toJson<List<String>?>(triggerConditions),
      'idealTasks': serializer.toJson<List<String>?>(idealTasks),
      'peakStartTime': serializer.toJson<String?>(peakStartTime),
      'peakEndTime': serializer.toJson<String?>(peakEndTime),
      'troughStartTime': serializer.toJson<String?>(troughStartTime),
      'troughEndTime': serializer.toJson<String?>(troughEndTime),
      'recoveryStartTime': serializer.toJson<String?>(recoveryStartTime),
      'recoveryEndTime': serializer.toJson<String?>(recoveryEndTime),
      'idealWeeklyHours': serializer.toJson<double>(idealWeeklyHours),
      'actualWeeklyHours': serializer.toJson<double>(actualWeeklyHours),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PersonaRow copyWith({
    String? id,
    String? userId,
    String? name,
    String? emoji,
    String? archetype,
    Value<String?> primaryEnergy = const Value.absent(),
    Value<List<String>?> strengths = const Value.absent(),
    Value<List<String>?> weaknesses = const Value.absent(),
    Value<List<String>?> triggerConditions = const Value.absent(),
    Value<List<String>?> idealTasks = const Value.absent(),
    Value<String?> peakStartTime = const Value.absent(),
    Value<String?> peakEndTime = const Value.absent(),
    Value<String?> troughStartTime = const Value.absent(),
    Value<String?> troughEndTime = const Value.absent(),
    Value<String?> recoveryStartTime = const Value.absent(),
    Value<String?> recoveryEndTime = const Value.absent(),
    double? idealWeeklyHours,
    double? actualWeeklyHours,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PersonaRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    emoji: emoji ?? this.emoji,
    archetype: archetype ?? this.archetype,
    primaryEnergy: primaryEnergy.present
        ? primaryEnergy.value
        : this.primaryEnergy,
    strengths: strengths.present ? strengths.value : this.strengths,
    weaknesses: weaknesses.present ? weaknesses.value : this.weaknesses,
    triggerConditions: triggerConditions.present
        ? triggerConditions.value
        : this.triggerConditions,
    idealTasks: idealTasks.present ? idealTasks.value : this.idealTasks,
    peakStartTime: peakStartTime.present
        ? peakStartTime.value
        : this.peakStartTime,
    peakEndTime: peakEndTime.present ? peakEndTime.value : this.peakEndTime,
    troughStartTime: troughStartTime.present
        ? troughStartTime.value
        : this.troughStartTime,
    troughEndTime: troughEndTime.present
        ? troughEndTime.value
        : this.troughEndTime,
    recoveryStartTime: recoveryStartTime.present
        ? recoveryStartTime.value
        : this.recoveryStartTime,
    recoveryEndTime: recoveryEndTime.present
        ? recoveryEndTime.value
        : this.recoveryEndTime,
    idealWeeklyHours: idealWeeklyHours ?? this.idealWeeklyHours,
    actualWeeklyHours: actualWeeklyHours ?? this.actualWeeklyHours,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PersonaRow copyWithCompanion(PersonasCompanion data) {
    return PersonaRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      archetype: data.archetype.present ? data.archetype.value : this.archetype,
      primaryEnergy: data.primaryEnergy.present
          ? data.primaryEnergy.value
          : this.primaryEnergy,
      strengths: data.strengths.present ? data.strengths.value : this.strengths,
      weaknesses: data.weaknesses.present
          ? data.weaknesses.value
          : this.weaknesses,
      triggerConditions: data.triggerConditions.present
          ? data.triggerConditions.value
          : this.triggerConditions,
      idealTasks: data.idealTasks.present
          ? data.idealTasks.value
          : this.idealTasks,
      peakStartTime: data.peakStartTime.present
          ? data.peakStartTime.value
          : this.peakStartTime,
      peakEndTime: data.peakEndTime.present
          ? data.peakEndTime.value
          : this.peakEndTime,
      troughStartTime: data.troughStartTime.present
          ? data.troughStartTime.value
          : this.troughStartTime,
      troughEndTime: data.troughEndTime.present
          ? data.troughEndTime.value
          : this.troughEndTime,
      recoveryStartTime: data.recoveryStartTime.present
          ? data.recoveryStartTime.value
          : this.recoveryStartTime,
      recoveryEndTime: data.recoveryEndTime.present
          ? data.recoveryEndTime.value
          : this.recoveryEndTime,
      idealWeeklyHours: data.idealWeeklyHours.present
          ? data.idealWeeklyHours.value
          : this.idealWeeklyHours,
      actualWeeklyHours: data.actualWeeklyHours.present
          ? data.actualWeeklyHours.value
          : this.actualWeeklyHours,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonaRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('archetype: $archetype, ')
          ..write('primaryEnergy: $primaryEnergy, ')
          ..write('strengths: $strengths, ')
          ..write('weaknesses: $weaknesses, ')
          ..write('triggerConditions: $triggerConditions, ')
          ..write('idealTasks: $idealTasks, ')
          ..write('peakStartTime: $peakStartTime, ')
          ..write('peakEndTime: $peakEndTime, ')
          ..write('troughStartTime: $troughStartTime, ')
          ..write('troughEndTime: $troughEndTime, ')
          ..write('recoveryStartTime: $recoveryStartTime, ')
          ..write('recoveryEndTime: $recoveryEndTime, ')
          ..write('idealWeeklyHours: $idealWeeklyHours, ')
          ..write('actualWeeklyHours: $actualWeeklyHours, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    name,
    emoji,
    archetype,
    primaryEnergy,
    strengths,
    weaknesses,
    triggerConditions,
    idealTasks,
    peakStartTime,
    peakEndTime,
    troughStartTime,
    troughEndTime,
    recoveryStartTime,
    recoveryEndTime,
    idealWeeklyHours,
    actualWeeklyHours,
    isActive,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonaRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.emoji == this.emoji &&
          other.archetype == this.archetype &&
          other.primaryEnergy == this.primaryEnergy &&
          other.strengths == this.strengths &&
          other.weaknesses == this.weaknesses &&
          other.triggerConditions == this.triggerConditions &&
          other.idealTasks == this.idealTasks &&
          other.peakStartTime == this.peakStartTime &&
          other.peakEndTime == this.peakEndTime &&
          other.troughStartTime == this.troughStartTime &&
          other.troughEndTime == this.troughEndTime &&
          other.recoveryStartTime == this.recoveryStartTime &&
          other.recoveryEndTime == this.recoveryEndTime &&
          other.idealWeeklyHours == this.idealWeeklyHours &&
          other.actualWeeklyHours == this.actualWeeklyHours &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonasCompanion extends UpdateCompanion<PersonaRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> emoji;
  final Value<String> archetype;
  final Value<String?> primaryEnergy;
  final Value<List<String>?> strengths;
  final Value<List<String>?> weaknesses;
  final Value<List<String>?> triggerConditions;
  final Value<List<String>?> idealTasks;
  final Value<String?> peakStartTime;
  final Value<String?> peakEndTime;
  final Value<String?> troughStartTime;
  final Value<String?> troughEndTime;
  final Value<String?> recoveryStartTime;
  final Value<String?> recoveryEndTime;
  final Value<double> idealWeeklyHours;
  final Value<double> actualWeeklyHours;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PersonasCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
    this.archetype = const Value.absent(),
    this.primaryEnergy = const Value.absent(),
    this.strengths = const Value.absent(),
    this.weaknesses = const Value.absent(),
    this.triggerConditions = const Value.absent(),
    this.idealTasks = const Value.absent(),
    this.peakStartTime = const Value.absent(),
    this.peakEndTime = const Value.absent(),
    this.troughStartTime = const Value.absent(),
    this.troughEndTime = const Value.absent(),
    this.recoveryStartTime = const Value.absent(),
    this.recoveryEndTime = const Value.absent(),
    this.idealWeeklyHours = const Value.absent(),
    this.actualWeeklyHours = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonasCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.emoji = const Value.absent(),
    required String archetype,
    this.primaryEnergy = const Value.absent(),
    this.strengths = const Value.absent(),
    this.weaknesses = const Value.absent(),
    this.triggerConditions = const Value.absent(),
    this.idealTasks = const Value.absent(),
    this.peakStartTime = const Value.absent(),
    this.peakEndTime = const Value.absent(),
    this.troughStartTime = const Value.absent(),
    this.troughEndTime = const Value.absent(),
    this.recoveryStartTime = const Value.absent(),
    this.recoveryEndTime = const Value.absent(),
    this.idealWeeklyHours = const Value.absent(),
    this.actualWeeklyHours = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       archetype = Value(archetype);
  static Insertable<PersonaRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? emoji,
    Expression<String>? archetype,
    Expression<String>? primaryEnergy,
    Expression<String>? strengths,
    Expression<String>? weaknesses,
    Expression<String>? triggerConditions,
    Expression<String>? idealTasks,
    Expression<String>? peakStartTime,
    Expression<String>? peakEndTime,
    Expression<String>? troughStartTime,
    Expression<String>? troughEndTime,
    Expression<String>? recoveryStartTime,
    Expression<String>? recoveryEndTime,
    Expression<double>? idealWeeklyHours,
    Expression<double>? actualWeeklyHours,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
      if (archetype != null) 'archetype': archetype,
      if (primaryEnergy != null) 'primary_energy': primaryEnergy,
      if (strengths != null) 'strengths': strengths,
      if (weaknesses != null) 'weaknesses': weaknesses,
      if (triggerConditions != null) 'trigger_conditions': triggerConditions,
      if (idealTasks != null) 'ideal_tasks': idealTasks,
      if (peakStartTime != null) 'peak_start_time': peakStartTime,
      if (peakEndTime != null) 'peak_end_time': peakEndTime,
      if (troughStartTime != null) 'trough_start_time': troughStartTime,
      if (troughEndTime != null) 'trough_end_time': troughEndTime,
      if (recoveryStartTime != null) 'recovery_start_time': recoveryStartTime,
      if (recoveryEndTime != null) 'recovery_end_time': recoveryEndTime,
      if (idealWeeklyHours != null) 'ideal_weekly_hours': idealWeeklyHours,
      if (actualWeeklyHours != null) 'actual_weekly_hours': actualWeeklyHours,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonasCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String>? emoji,
    Value<String>? archetype,
    Value<String?>? primaryEnergy,
    Value<List<String>?>? strengths,
    Value<List<String>?>? weaknesses,
    Value<List<String>?>? triggerConditions,
    Value<List<String>?>? idealTasks,
    Value<String?>? peakStartTime,
    Value<String?>? peakEndTime,
    Value<String?>? troughStartTime,
    Value<String?>? troughEndTime,
    Value<String?>? recoveryStartTime,
    Value<String?>? recoveryEndTime,
    Value<double>? idealWeeklyHours,
    Value<double>? actualWeeklyHours,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PersonasCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      archetype: archetype ?? this.archetype,
      primaryEnergy: primaryEnergy ?? this.primaryEnergy,
      strengths: strengths ?? this.strengths,
      weaknesses: weaknesses ?? this.weaknesses,
      triggerConditions: triggerConditions ?? this.triggerConditions,
      idealTasks: idealTasks ?? this.idealTasks,
      peakStartTime: peakStartTime ?? this.peakStartTime,
      peakEndTime: peakEndTime ?? this.peakEndTime,
      troughStartTime: troughStartTime ?? this.troughStartTime,
      troughEndTime: troughEndTime ?? this.troughEndTime,
      recoveryStartTime: recoveryStartTime ?? this.recoveryStartTime,
      recoveryEndTime: recoveryEndTime ?? this.recoveryEndTime,
      idealWeeklyHours: idealWeeklyHours ?? this.idealWeeklyHours,
      actualWeeklyHours: actualWeeklyHours ?? this.actualWeeklyHours,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (archetype.present) {
      map['archetype'] = Variable<String>(archetype.value);
    }
    if (primaryEnergy.present) {
      map['primary_energy'] = Variable<String>(primaryEnergy.value);
    }
    if (strengths.present) {
      map['strengths'] = Variable<String>(
        $PersonasTable.$converterstrengthsn.toSql(strengths.value),
      );
    }
    if (weaknesses.present) {
      map['weaknesses'] = Variable<String>(
        $PersonasTable.$converterweaknessesn.toSql(weaknesses.value),
      );
    }
    if (triggerConditions.present) {
      map['trigger_conditions'] = Variable<String>(
        $PersonasTable.$convertertriggerConditionsn.toSql(
          triggerConditions.value,
        ),
      );
    }
    if (idealTasks.present) {
      map['ideal_tasks'] = Variable<String>(
        $PersonasTable.$converteridealTasksn.toSql(idealTasks.value),
      );
    }
    if (peakStartTime.present) {
      map['peak_start_time'] = Variable<String>(peakStartTime.value);
    }
    if (peakEndTime.present) {
      map['peak_end_time'] = Variable<String>(peakEndTime.value);
    }
    if (troughStartTime.present) {
      map['trough_start_time'] = Variable<String>(troughStartTime.value);
    }
    if (troughEndTime.present) {
      map['trough_end_time'] = Variable<String>(troughEndTime.value);
    }
    if (recoveryStartTime.present) {
      map['recovery_start_time'] = Variable<String>(recoveryStartTime.value);
    }
    if (recoveryEndTime.present) {
      map['recovery_end_time'] = Variable<String>(recoveryEndTime.value);
    }
    if (idealWeeklyHours.present) {
      map['ideal_weekly_hours'] = Variable<double>(idealWeeklyHours.value);
    }
    if (actualWeeklyHours.present) {
      map['actual_weekly_hours'] = Variable<double>(actualWeeklyHours.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonasCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('archetype: $archetype, ')
          ..write('primaryEnergy: $primaryEnergy, ')
          ..write('strengths: $strengths, ')
          ..write('weaknesses: $weaknesses, ')
          ..write('triggerConditions: $triggerConditions, ')
          ..write('idealTasks: $idealTasks, ')
          ..write('peakStartTime: $peakStartTime, ')
          ..write('peakEndTime: $peakEndTime, ')
          ..write('troughStartTime: $troughStartTime, ')
          ..write('troughEndTime: $troughEndTime, ')
          ..write('recoveryStartTime: $recoveryStartTime, ')
          ..write('recoveryEndTime: $recoveryEndTime, ')
          ..write('idealWeeklyHours: $idealWeeklyHours, ')
          ..write('actualWeeklyHours: $actualWeeklyHours, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EnergyReadingsTable extends EnergyReadings
    with TableInfo<$EnergyReadingsTable, EnergyReadingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnergyReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    personaId,
    timestamp,
    energyLevel,
    confidence,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'energy_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnergyReadingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnergyReadingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnergyReadingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $EnergyReadingsTable createAlias(String alias) {
    return $EnergyReadingsTable(attachedDatabase, alias);
  }
}

class EnergyReadingRow extends DataClass
    implements Insertable<EnergyReadingRow> {
  final String id;
  final String personaId;
  final DateTime timestamp;
  final int energyLevel;
  final double confidence;
  final String source;
  final String? notes;
  const EnergyReadingRow({
    required this.id,
    required this.personaId,
    required this.timestamp,
    required this.energyLevel,
    required this.confidence,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['persona_id'] = Variable<String>(personaId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['energy_level'] = Variable<int>(energyLevel);
    map['confidence'] = Variable<double>(confidence);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  EnergyReadingsCompanion toCompanion(bool nullToAbsent) {
    return EnergyReadingsCompanion(
      id: Value(id),
      personaId: Value(personaId),
      timestamp: Value(timestamp),
      energyLevel: Value(energyLevel),
      confidence: Value(confidence),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory EnergyReadingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnergyReadingRow(
      id: serializer.fromJson<String>(json['id']),
      personaId: serializer.fromJson<String>(json['personaId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      energyLevel: serializer.fromJson<int>(json['energyLevel']),
      confidence: serializer.fromJson<double>(json['confidence']),
      source: serializer.fromJson<String>(json['source']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'personaId': serializer.toJson<String>(personaId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'energyLevel': serializer.toJson<int>(energyLevel),
      'confidence': serializer.toJson<double>(confidence),
      'source': serializer.toJson<String>(source),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  EnergyReadingRow copyWith({
    String? id,
    String? personaId,
    DateTime? timestamp,
    int? energyLevel,
    double? confidence,
    String? source,
    Value<String?> notes = const Value.absent(),
  }) => EnergyReadingRow(
    id: id ?? this.id,
    personaId: personaId ?? this.personaId,
    timestamp: timestamp ?? this.timestamp,
    energyLevel: energyLevel ?? this.energyLevel,
    confidence: confidence ?? this.confidence,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  EnergyReadingRow copyWithCompanion(EnergyReadingsCompanion data) {
    return EnergyReadingRow(
      id: data.id.present ? data.id.value : this.id,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnergyReadingRow(')
          ..write('id: $id, ')
          ..write('personaId: $personaId, ')
          ..write('timestamp: $timestamp, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('confidence: $confidence, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    personaId,
    timestamp,
    energyLevel,
    confidence,
    source,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnergyReadingRow &&
          other.id == this.id &&
          other.personaId == this.personaId &&
          other.timestamp == this.timestamp &&
          other.energyLevel == this.energyLevel &&
          other.confidence == this.confidence &&
          other.source == this.source &&
          other.notes == this.notes);
}

class EnergyReadingsCompanion extends UpdateCompanion<EnergyReadingRow> {
  final Value<String> id;
  final Value<String> personaId;
  final Value<DateTime> timestamp;
  final Value<int> energyLevel;
  final Value<double> confidence;
  final Value<String> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const EnergyReadingsCompanion({
    this.id = const Value.absent(),
    this.personaId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.confidence = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EnergyReadingsCompanion.insert({
    required String id,
    required String personaId,
    this.timestamp = const Value.absent(),
    required int energyLevel,
    this.confidence = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       personaId = Value(personaId),
       energyLevel = Value(energyLevel);
  static Insertable<EnergyReadingRow> custom({
    Expression<String>? id,
    Expression<String>? personaId,
    Expression<DateTime>? timestamp,
    Expression<int>? energyLevel,
    Expression<double>? confidence,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personaId != null) 'persona_id': personaId,
      if (timestamp != null) 'timestamp': timestamp,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (confidence != null) 'confidence': confidence,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EnergyReadingsCompanion copyWith({
    Value<String>? id,
    Value<String>? personaId,
    Value<DateTime>? timestamp,
    Value<int>? energyLevel,
    Value<double>? confidence,
    Value<String>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return EnergyReadingsCompanion(
      id: id ?? this.id,
      personaId: personaId ?? this.personaId,
      timestamp: timestamp ?? this.timestamp,
      energyLevel: energyLevel ?? this.energyLevel,
      confidence: confidence ?? this.confidence,
      source: source ?? this.source,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnergyReadingsCompanion(')
          ..write('id: $id, ')
          ..write('personaId: $personaId, ')
          ..write('timestamp: $timestamp, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('confidence: $confidence, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyRequiredMeta = const VerificationMeta(
    'energyRequired',
  );
  @override
  late final GeneratedColumn<int> energyRequired = GeneratedColumn<int>(
    'energy_required',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    personaId,
    title,
    energyRequired,
    priority,
    estimatedMinutes,
    completed,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('energy_required')) {
      context.handle(
        _energyRequiredMeta,
        energyRequired.isAcceptableOrUnknown(
          data['energy_required']!,
          _energyRequiredMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      energyRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_required'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskRow extends DataClass implements Insertable<TaskRow> {
  final String id;
  final String userId;
  final String personaId;
  final String title;
  final int energyRequired;
  final int priority;
  final int estimatedMinutes;
  final bool completed;
  final DateTime? completedAt;
  final DateTime createdAt;
  const TaskRow({
    required this.id,
    required this.userId,
    required this.personaId,
    required this.title,
    required this.energyRequired,
    required this.priority,
    required this.estimatedMinutes,
    required this.completed,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['persona_id'] = Variable<String>(personaId);
    map['title'] = Variable<String>(title);
    map['energy_required'] = Variable<int>(energyRequired);
    map['priority'] = Variable<int>(priority);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      userId: Value(userId),
      personaId: Value(personaId),
      title: Value(title),
      energyRequired: Value(energyRequired),
      priority: Value(priority),
      estimatedMinutes: Value(estimatedMinutes),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory TaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      personaId: serializer.fromJson<String>(json['personaId']),
      title: serializer.fromJson<String>(json['title']),
      energyRequired: serializer.fromJson<int>(json['energyRequired']),
      priority: serializer.fromJson<int>(json['priority']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'personaId': serializer.toJson<String>(personaId),
      'title': serializer.toJson<String>(title),
      'energyRequired': serializer.toJson<int>(energyRequired),
      'priority': serializer.toJson<int>(priority),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TaskRow copyWith({
    String? id,
    String? userId,
    String? personaId,
    String? title,
    int? energyRequired,
    int? priority,
    int? estimatedMinutes,
    bool? completed,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => TaskRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    personaId: personaId ?? this.personaId,
    title: title ?? this.title,
    energyRequired: energyRequired ?? this.energyRequired,
    priority: priority ?? this.priority,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    completed: completed ?? this.completed,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  TaskRow copyWithCompanion(TasksCompanion data) {
    return TaskRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
      title: data.title.present ? data.title.value : this.title,
      energyRequired: data.energyRequired.present
          ? data.energyRequired.value
          : this.energyRequired,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('title: $title, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('priority: $priority, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    personaId,
    title,
    energyRequired,
    priority,
    estimatedMinutes,
    completed,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.personaId == this.personaId &&
          other.title == this.title &&
          other.energyRequired == this.energyRequired &&
          other.priority == this.priority &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<TaskRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> personaId;
  final Value<String> title;
  final Value<int> energyRequired;
  final Value<int> priority;
  final Value<int> estimatedMinutes;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.personaId = const Value.absent(),
    this.title = const Value.absent(),
    this.energyRequired = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String userId,
    required String personaId,
    required String title,
    this.energyRequired = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       personaId = Value(personaId),
       title = Value(title);
  static Insertable<TaskRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? personaId,
    Expression<String>? title,
    Expression<int>? energyRequired,
    Expression<int>? priority,
    Expression<int>? estimatedMinutes,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (personaId != null) 'persona_id': personaId,
      if (title != null) 'title': title,
      if (energyRequired != null) 'energy_required': energyRequired,
      if (priority != null) 'priority': priority,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? personaId,
    Value<String>? title,
    Value<int>? energyRequired,
    Value<int>? priority,
    Value<int>? estimatedMinutes,
    Value<bool>? completed,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personaId: personaId ?? this.personaId,
      title: title ?? this.title,
      energyRequired: energyRequired ?? this.energyRequired,
      priority: priority ?? this.priority,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (energyRequired.present) {
      map['energy_required'] = Variable<int>(energyRequired.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('title: $title, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('priority: $priority, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalendarPrefsTable extends CalendarPrefs
    with TableInfo<$CalendarPrefsTable, CalendarPrefRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _calendarIdMeta = const VerificationMeta(
    'calendarId',
  );
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
    'calendar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [calendarId, kind];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendar_prefs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarPrefRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('calendar_id')) {
      context.handle(
        _calendarIdMeta,
        calendarId.isAcceptableOrUnknown(data['calendar_id']!, _calendarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {calendarId};
  @override
  CalendarPrefRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarPrefRow(
      calendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $CalendarPrefsTable createAlias(String alias) {
    return $CalendarPrefsTable(attachedDatabase, alias);
  }
}

class CalendarPrefRow extends DataClass implements Insertable<CalendarPrefRow> {
  final String calendarId;
  final String kind;
  const CalendarPrefRow({required this.calendarId, required this.kind});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['calendar_id'] = Variable<String>(calendarId);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  CalendarPrefsCompanion toCompanion(bool nullToAbsent) {
    return CalendarPrefsCompanion(
      calendarId: Value(calendarId),
      kind: Value(kind),
    );
  }

  factory CalendarPrefRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarPrefRow(
      calendarId: serializer.fromJson<String>(json['calendarId']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'calendarId': serializer.toJson<String>(calendarId),
      'kind': serializer.toJson<String>(kind),
    };
  }

  CalendarPrefRow copyWith({String? calendarId, String? kind}) =>
      CalendarPrefRow(
        calendarId: calendarId ?? this.calendarId,
        kind: kind ?? this.kind,
      );
  CalendarPrefRow copyWithCompanion(CalendarPrefsCompanion data) {
    return CalendarPrefRow(
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarPrefRow(')
          ..write('calendarId: $calendarId, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(calendarId, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarPrefRow &&
          other.calendarId == this.calendarId &&
          other.kind == this.kind);
}

class CalendarPrefsCompanion extends UpdateCompanion<CalendarPrefRow> {
  final Value<String> calendarId;
  final Value<String> kind;
  final Value<int> rowid;
  const CalendarPrefsCompanion({
    this.calendarId = const Value.absent(),
    this.kind = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarPrefsCompanion.insert({
    required String calendarId,
    required String kind,
    this.rowid = const Value.absent(),
  }) : calendarId = Value(calendarId),
       kind = Value(kind);
  static Insertable<CalendarPrefRow> custom({
    Expression<String>? calendarId,
    Expression<String>? kind,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (calendarId != null) 'calendar_id': calendarId,
      if (kind != null) 'kind': kind,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarPrefsCompanion copyWith({
    Value<String>? calendarId,
    Value<String>? kind,
    Value<int>? rowid,
  }) {
    return CalendarPrefsCompanion(
      calendarId: calendarId ?? this.calendarId,
      kind: kind ?? this.kind,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarPrefsCompanion(')
          ..write('calendarId: $calendarId, ')
          ..write('kind: $kind, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HiddenEventsTable extends HiddenEvents
    with TableInfo<$HiddenEventsTable, HiddenEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HiddenEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [eventId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hidden_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<HiddenEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  HiddenEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HiddenEventRow(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
    );
  }

  @override
  $HiddenEventsTable createAlias(String alias) {
    return $HiddenEventsTable(attachedDatabase, alias);
  }
}

class HiddenEventRow extends DataClass implements Insertable<HiddenEventRow> {
  final String eventId;
  const HiddenEventRow({required this.eventId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    return map;
  }

  HiddenEventsCompanion toCompanion(bool nullToAbsent) {
    return HiddenEventsCompanion(eventId: Value(eventId));
  }

  factory HiddenEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HiddenEventRow(
      eventId: serializer.fromJson<String>(json['eventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'eventId': serializer.toJson<String>(eventId)};
  }

  HiddenEventRow copyWith({String? eventId}) =>
      HiddenEventRow(eventId: eventId ?? this.eventId);
  HiddenEventRow copyWithCompanion(HiddenEventsCompanion data) {
    return HiddenEventRow(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HiddenEventRow(')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => eventId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HiddenEventRow && other.eventId == this.eventId);
}

class HiddenEventsCompanion extends UpdateCompanion<HiddenEventRow> {
  final Value<String> eventId;
  final Value<int> rowid;
  const HiddenEventsCompanion({
    this.eventId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HiddenEventsCompanion.insert({
    required String eventId,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId);
  static Insertable<HiddenEventRow> custom({
    Expression<String>? eventId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HiddenEventsCompanion copyWith({Value<String>? eventId, Value<int>? rowid}) {
    return HiddenEventsCompanion(
      eventId: eventId ?? this.eventId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HiddenEventsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventPersonaOverridesTable extends EventPersonaOverrides
    with TableInfo<$EventPersonaOverridesTable, EventPersonaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventPersonaOverridesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [eventId, personaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_persona_overrides';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventPersonaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  EventPersonaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventPersonaRow(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
    );
  }

  @override
  $EventPersonaOverridesTable createAlias(String alias) {
    return $EventPersonaOverridesTable(attachedDatabase, alias);
  }
}

class EventPersonaRow extends DataClass implements Insertable<EventPersonaRow> {
  final String eventId;
  final String personaId;
  const EventPersonaRow({required this.eventId, required this.personaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['persona_id'] = Variable<String>(personaId);
    return map;
  }

  EventPersonaOverridesCompanion toCompanion(bool nullToAbsent) {
    return EventPersonaOverridesCompanion(
      eventId: Value(eventId),
      personaId: Value(personaId),
    );
  }

  factory EventPersonaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventPersonaRow(
      eventId: serializer.fromJson<String>(json['eventId']),
      personaId: serializer.fromJson<String>(json['personaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'personaId': serializer.toJson<String>(personaId),
    };
  }

  EventPersonaRow copyWith({String? eventId, String? personaId}) =>
      EventPersonaRow(
        eventId: eventId ?? this.eventId,
        personaId: personaId ?? this.personaId,
      );
  EventPersonaRow copyWithCompanion(EventPersonaOverridesCompanion data) {
    return EventPersonaRow(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventPersonaRow(')
          ..write('eventId: $eventId, ')
          ..write('personaId: $personaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, personaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventPersonaRow &&
          other.eventId == this.eventId &&
          other.personaId == this.personaId);
}

class EventPersonaOverridesCompanion extends UpdateCompanion<EventPersonaRow> {
  final Value<String> eventId;
  final Value<String> personaId;
  final Value<int> rowid;
  const EventPersonaOverridesCompanion({
    this.eventId = const Value.absent(),
    this.personaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventPersonaOverridesCompanion.insert({
    required String eventId,
    required String personaId,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       personaId = Value(personaId);
  static Insertable<EventPersonaRow> custom({
    Expression<String>? eventId,
    Expression<String>? personaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (personaId != null) 'persona_id': personaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventPersonaOverridesCompanion copyWith({
    Value<String>? eventId,
    Value<String>? personaId,
    Value<int>? rowid,
  }) {
    return EventPersonaOverridesCompanion(
      eventId: eventId ?? this.eventId,
      personaId: personaId ?? this.personaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventPersonaOverridesCompanion(')
          ..write('eventId: $eventId, ')
          ..write('personaId: $personaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventEnergyImpactsTable extends EventEnergyImpacts
    with TableInfo<$EventEnergyImpactsTable, EventEnergyImpactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventEnergyImpactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _impactMeta = const VerificationMeta('impact');
  @override
  late final GeneratedColumn<int> impact = GeneratedColumn<int>(
    'impact',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [eventId, impact];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_energy_impacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventEnergyImpactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('impact')) {
      context.handle(
        _impactMeta,
        impact.isAcceptableOrUnknown(data['impact']!, _impactMeta),
      );
    } else if (isInserting) {
      context.missing(_impactMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  EventEnergyImpactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventEnergyImpactRow(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      impact: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}impact'],
      )!,
    );
  }

  @override
  $EventEnergyImpactsTable createAlias(String alias) {
    return $EventEnergyImpactsTable(attachedDatabase, alias);
  }
}

class EventEnergyImpactRow extends DataClass
    implements Insertable<EventEnergyImpactRow> {
  final String eventId;
  final int impact;
  const EventEnergyImpactRow({required this.eventId, required this.impact});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['impact'] = Variable<int>(impact);
    return map;
  }

  EventEnergyImpactsCompanion toCompanion(bool nullToAbsent) {
    return EventEnergyImpactsCompanion(
      eventId: Value(eventId),
      impact: Value(impact),
    );
  }

  factory EventEnergyImpactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventEnergyImpactRow(
      eventId: serializer.fromJson<String>(json['eventId']),
      impact: serializer.fromJson<int>(json['impact']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'impact': serializer.toJson<int>(impact),
    };
  }

  EventEnergyImpactRow copyWith({String? eventId, int? impact}) =>
      EventEnergyImpactRow(
        eventId: eventId ?? this.eventId,
        impact: impact ?? this.impact,
      );
  EventEnergyImpactRow copyWithCompanion(EventEnergyImpactsCompanion data) {
    return EventEnergyImpactRow(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      impact: data.impact.present ? data.impact.value : this.impact,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventEnergyImpactRow(')
          ..write('eventId: $eventId, ')
          ..write('impact: $impact')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, impact);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventEnergyImpactRow &&
          other.eventId == this.eventId &&
          other.impact == this.impact);
}

class EventEnergyImpactsCompanion
    extends UpdateCompanion<EventEnergyImpactRow> {
  final Value<String> eventId;
  final Value<int> impact;
  final Value<int> rowid;
  const EventEnergyImpactsCompanion({
    this.eventId = const Value.absent(),
    this.impact = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventEnergyImpactsCompanion.insert({
    required String eventId,
    required int impact,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       impact = Value(impact);
  static Insertable<EventEnergyImpactRow> custom({
    Expression<String>? eventId,
    Expression<int>? impact,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (impact != null) 'impact': impact,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventEnergyImpactsCompanion copyWith({
    Value<String>? eventId,
    Value<int>? impact,
    Value<int>? rowid,
  }) {
    return EventEnergyImpactsCompanion(
      eventId: eventId ?? this.eventId,
      impact: impact ?? this.impact,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (impact.present) {
      map['impact'] = Variable<int>(impact.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventEnergyImpactsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('impact: $impact, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearnedAssociationsTable extends LearnedAssociations
    with TableInfo<$LearnedAssociationsTable, LearnedAssociationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearnedAssociationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [token, personaId, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learned_associations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearnedAssociationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {token, personaId};
  @override
  LearnedAssociationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearnedAssociationRow(
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
    );
  }

  @override
  $LearnedAssociationsTable createAlias(String alias) {
    return $LearnedAssociationsTable(attachedDatabase, alias);
  }
}

class LearnedAssociationRow extends DataClass
    implements Insertable<LearnedAssociationRow> {
  final String token;
  final String personaId;
  final int weight;
  const LearnedAssociationRow({
    required this.token,
    required this.personaId,
    required this.weight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['token'] = Variable<String>(token);
    map['persona_id'] = Variable<String>(personaId);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  LearnedAssociationsCompanion toCompanion(bool nullToAbsent) {
    return LearnedAssociationsCompanion(
      token: Value(token),
      personaId: Value(personaId),
      weight: Value(weight),
    );
  }

  factory LearnedAssociationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearnedAssociationRow(
      token: serializer.fromJson<String>(json['token']),
      personaId: serializer.fromJson<String>(json['personaId']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'token': serializer.toJson<String>(token),
      'personaId': serializer.toJson<String>(personaId),
      'weight': serializer.toJson<int>(weight),
    };
  }

  LearnedAssociationRow copyWith({
    String? token,
    String? personaId,
    int? weight,
  }) => LearnedAssociationRow(
    token: token ?? this.token,
    personaId: personaId ?? this.personaId,
    weight: weight ?? this.weight,
  );
  LearnedAssociationRow copyWithCompanion(LearnedAssociationsCompanion data) {
    return LearnedAssociationRow(
      token: data.token.present ? data.token.value : this.token,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearnedAssociationRow(')
          ..write('token: $token, ')
          ..write('personaId: $personaId, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(token, personaId, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearnedAssociationRow &&
          other.token == this.token &&
          other.personaId == this.personaId &&
          other.weight == this.weight);
}

class LearnedAssociationsCompanion
    extends UpdateCompanion<LearnedAssociationRow> {
  final Value<String> token;
  final Value<String> personaId;
  final Value<int> weight;
  final Value<int> rowid;
  const LearnedAssociationsCompanion({
    this.token = const Value.absent(),
    this.personaId = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearnedAssociationsCompanion.insert({
    required String token,
    required String personaId,
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : token = Value(token),
       personaId = Value(personaId);
  static Insertable<LearnedAssociationRow> custom({
    Expression<String>? token,
    Expression<String>? personaId,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (token != null) 'token': token,
      if (personaId != null) 'persona_id': personaId,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearnedAssociationsCompanion copyWith({
    Value<String>? token,
    Value<String>? personaId,
    Value<int>? weight,
    Value<int>? rowid,
  }) {
    return LearnedAssociationsCompanion(
      token: token ?? this.token,
      personaId: personaId ?? this.personaId,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearnedAssociationsCompanion(')
          ..write('token: $token, ')
          ..write('personaId: $personaId, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    personaId,
    title,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final String id;
  final String userId;
  final String personaId;
  final String title;
  final DateTime createdAt;
  const HabitRow({
    required this.id,
    required this.userId,
    required this.personaId,
    required this.title,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['persona_id'] = Variable<String>(personaId);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      userId: Value(userId),
      personaId: Value(personaId),
      title: Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      personaId: serializer.fromJson<String>(json['personaId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'personaId': serializer.toJson<String>(personaId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitRow copyWith({
    String? id,
    String? userId,
    String? personaId,
    String? title,
    DateTime? createdAt,
  }) => HabitRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    personaId: personaId ?? this.personaId,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, personaId, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.personaId == this.personaId &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> personaId;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.personaId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String userId,
    required String personaId,
    required String title,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       personaId = Value(personaId),
       title = Value(title);
  static Insertable<HabitRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? personaId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (personaId != null) 'persona_id': personaId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? personaId,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personaId: personaId ?? this.personaId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitCompletionsTable extends HabitCompletions
    with TableInfo<$HabitCompletionsTable, HabitCompletionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [habitId, day];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitCompletionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, day};
  @override
  HabitCompletionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCompletionRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
    );
  }

  @override
  $HabitCompletionsTable createAlias(String alias) {
    return $HabitCompletionsTable(attachedDatabase, alias);
  }
}

class HabitCompletionRow extends DataClass
    implements Insertable<HabitCompletionRow> {
  final String habitId;
  final DateTime day;
  const HabitCompletionRow({required this.habitId, required this.day});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['day'] = Variable<DateTime>(day);
    return map;
  }

  HabitCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HabitCompletionsCompanion(habitId: Value(habitId), day: Value(day));
  }

  factory HabitCompletionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCompletionRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      day: serializer.fromJson<DateTime>(json['day']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'day': serializer.toJson<DateTime>(day),
    };
  }

  HabitCompletionRow copyWith({String? habitId, DateTime? day}) =>
      HabitCompletionRow(
        habitId: habitId ?? this.habitId,
        day: day ?? this.day,
      );
  HabitCompletionRow copyWithCompanion(HabitCompletionsCompanion data) {
    return HabitCompletionRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      day: data.day.present ? data.day.value : this.day,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionRow(')
          ..write('habitId: $habitId, ')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, day);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCompletionRow &&
          other.habitId == this.habitId &&
          other.day == this.day);
}

class HabitCompletionsCompanion extends UpdateCompanion<HabitCompletionRow> {
  final Value<String> habitId;
  final Value<DateTime> day;
  final Value<int> rowid;
  const HabitCompletionsCompanion({
    this.habitId = const Value.absent(),
    this.day = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitCompletionsCompanion.insert({
    required String habitId,
    required DateTime day,
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       day = Value(day);
  static Insertable<HabitCompletionRow> custom({
    Expression<String>? habitId,
    Expression<DateTime>? day,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (day != null) 'day': day,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitCompletionsCompanion copyWith({
    Value<String>? habitId,
    Value<DateTime>? day,
    Value<int>? rowid,
  }) {
    return HabitCompletionsCompanion(
      habitId: habitId ?? this.habitId,
      day: day ?? this.day,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personaIdMeta = const VerificationMeta(
    'personaId',
  );
  @override
  late final GeneratedColumn<String> personaId = GeneratedColumn<String>(
    'persona_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES personas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    personaId,
    prompt,
    body,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('persona_id')) {
      context.handle(
        _personaIdMeta,
        personaId.isAcceptableOrUnknown(data['persona_id']!, _personaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personaIdMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      personaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}persona_id'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntryRow extends DataClass implements Insertable<JournalEntryRow> {
  final String id;
  final String userId;
  final String personaId;
  final String? prompt;
  final String body;
  final DateTime createdAt;
  const JournalEntryRow({
    required this.id,
    required this.userId,
    required this.personaId,
    this.prompt,
    required this.body,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['persona_id'] = Variable<String>(personaId);
    if (!nullToAbsent || prompt != null) {
      map['prompt'] = Variable<String>(prompt);
    }
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      personaId: Value(personaId),
      prompt: prompt == null && nullToAbsent
          ? const Value.absent()
          : Value(prompt),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory JournalEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntryRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      personaId: serializer.fromJson<String>(json['personaId']),
      prompt: serializer.fromJson<String?>(json['prompt']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'personaId': serializer.toJson<String>(personaId),
      'prompt': serializer.toJson<String?>(prompt),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JournalEntryRow copyWith({
    String? id,
    String? userId,
    String? personaId,
    Value<String?> prompt = const Value.absent(),
    String? body,
    DateTime? createdAt,
  }) => JournalEntryRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    personaId: personaId ?? this.personaId,
    prompt: prompt.present ? prompt.value : this.prompt,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  JournalEntryRow copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntryRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      personaId: data.personaId.present ? data.personaId.value : this.personaId,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntryRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('prompt: $prompt, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, personaId, prompt, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntryRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.personaId == this.personaId &&
          other.prompt == this.prompt &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntryRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> personaId;
  final Value<String?> prompt;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.personaId = const Value.absent(),
    this.prompt = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String userId,
    required String personaId,
    this.prompt = const Value.absent(),
    required String body,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       personaId = Value(personaId),
       body = Value(body);
  static Insertable<JournalEntryRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? personaId,
    Expression<String>? prompt,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (personaId != null) 'persona_id': personaId,
      if (prompt != null) 'prompt': prompt,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? personaId,
    Value<String?>? prompt,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personaId: personaId ?? this.personaId,
      prompt: prompt ?? this.prompt,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (personaId.present) {
      map['persona_id'] = Variable<String>(personaId.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('personaId: $personaId, ')
          ..write('prompt: $prompt, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DayLogsTable extends DayLogs with TableInfo<$DayLogsTable, DayLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<DateTime> day = GeneratedColumn<DateTime>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intentionMeta = const VerificationMeta(
    'intention',
  );
  @override
  late final GeneratedColumn<String> intention = GeneratedColumn<String>(
    'intention',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reflectionMeta = const VerificationMeta(
    'reflection',
  );
  @override
  late final GeneratedColumn<String> reflection = GeneratedColumn<String>(
    'reflection',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intendedPersonaIdsMeta =
      const VerificationMeta('intendedPersonaIds');
  @override
  late final GeneratedColumn<String> intendedPersonaIds =
      GeneratedColumn<String>(
        'intended_persona_ids',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    day,
    intention,
    reflection,
    intendedPersonaIds,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('intention')) {
      context.handle(
        _intentionMeta,
        intention.isAcceptableOrUnknown(data['intention']!, _intentionMeta),
      );
    }
    if (data.containsKey('reflection')) {
      context.handle(
        _reflectionMeta,
        reflection.isAcceptableOrUnknown(data['reflection']!, _reflectionMeta),
      );
    }
    if (data.containsKey('intended_persona_ids')) {
      context.handle(
        _intendedPersonaIdsMeta,
        intendedPersonaIds.isAcceptableOrUnknown(
          data['intended_persona_ids']!,
          _intendedPersonaIdsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day};
  @override
  DayLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayLogRow(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}day'],
      )!,
      intention: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intention'],
      ),
      reflection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reflection'],
      ),
      intendedPersonaIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intended_persona_ids'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DayLogsTable createAlias(String alias) {
    return $DayLogsTable(attachedDatabase, alias);
  }
}

class DayLogRow extends DataClass implements Insertable<DayLogRow> {
  final DateTime day;
  final String? intention;
  final String? reflection;
  final String? intendedPersonaIds;
  final DateTime updatedAt;
  const DayLogRow({
    required this.day,
    this.intention,
    this.reflection,
    this.intendedPersonaIds,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<DateTime>(day);
    if (!nullToAbsent || intention != null) {
      map['intention'] = Variable<String>(intention);
    }
    if (!nullToAbsent || reflection != null) {
      map['reflection'] = Variable<String>(reflection);
    }
    if (!nullToAbsent || intendedPersonaIds != null) {
      map['intended_persona_ids'] = Variable<String>(intendedPersonaIds);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DayLogsCompanion toCompanion(bool nullToAbsent) {
    return DayLogsCompanion(
      day: Value(day),
      intention: intention == null && nullToAbsent
          ? const Value.absent()
          : Value(intention),
      reflection: reflection == null && nullToAbsent
          ? const Value.absent()
          : Value(reflection),
      intendedPersonaIds: intendedPersonaIds == null && nullToAbsent
          ? const Value.absent()
          : Value(intendedPersonaIds),
      updatedAt: Value(updatedAt),
    );
  }

  factory DayLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayLogRow(
      day: serializer.fromJson<DateTime>(json['day']),
      intention: serializer.fromJson<String?>(json['intention']),
      reflection: serializer.fromJson<String?>(json['reflection']),
      intendedPersonaIds: serializer.fromJson<String?>(
        json['intendedPersonaIds'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day': serializer.toJson<DateTime>(day),
      'intention': serializer.toJson<String?>(intention),
      'reflection': serializer.toJson<String?>(reflection),
      'intendedPersonaIds': serializer.toJson<String?>(intendedPersonaIds),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DayLogRow copyWith({
    DateTime? day,
    Value<String?> intention = const Value.absent(),
    Value<String?> reflection = const Value.absent(),
    Value<String?> intendedPersonaIds = const Value.absent(),
    DateTime? updatedAt,
  }) => DayLogRow(
    day: day ?? this.day,
    intention: intention.present ? intention.value : this.intention,
    reflection: reflection.present ? reflection.value : this.reflection,
    intendedPersonaIds: intendedPersonaIds.present
        ? intendedPersonaIds.value
        : this.intendedPersonaIds,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DayLogRow copyWithCompanion(DayLogsCompanion data) {
    return DayLogRow(
      day: data.day.present ? data.day.value : this.day,
      intention: data.intention.present ? data.intention.value : this.intention,
      reflection: data.reflection.present
          ? data.reflection.value
          : this.reflection,
      intendedPersonaIds: data.intendedPersonaIds.present
          ? data.intendedPersonaIds.value
          : this.intendedPersonaIds,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayLogRow(')
          ..write('day: $day, ')
          ..write('intention: $intention, ')
          ..write('reflection: $reflection, ')
          ..write('intendedPersonaIds: $intendedPersonaIds, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(day, intention, reflection, intendedPersonaIds, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayLogRow &&
          other.day == this.day &&
          other.intention == this.intention &&
          other.reflection == this.reflection &&
          other.intendedPersonaIds == this.intendedPersonaIds &&
          other.updatedAt == this.updatedAt);
}

class DayLogsCompanion extends UpdateCompanion<DayLogRow> {
  final Value<DateTime> day;
  final Value<String?> intention;
  final Value<String?> reflection;
  final Value<String?> intendedPersonaIds;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DayLogsCompanion({
    this.day = const Value.absent(),
    this.intention = const Value.absent(),
    this.reflection = const Value.absent(),
    this.intendedPersonaIds = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayLogsCompanion.insert({
    required DateTime day,
    this.intention = const Value.absent(),
    this.reflection = const Value.absent(),
    this.intendedPersonaIds = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : day = Value(day);
  static Insertable<DayLogRow> custom({
    Expression<DateTime>? day,
    Expression<String>? intention,
    Expression<String>? reflection,
    Expression<String>? intendedPersonaIds,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (intention != null) 'intention': intention,
      if (reflection != null) 'reflection': reflection,
      if (intendedPersonaIds != null)
        'intended_persona_ids': intendedPersonaIds,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayLogsCompanion copyWith({
    Value<DateTime>? day,
    Value<String?>? intention,
    Value<String?>? reflection,
    Value<String?>? intendedPersonaIds,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DayLogsCompanion(
      day: day ?? this.day,
      intention: intention ?? this.intention,
      reflection: reflection ?? this.reflection,
      intendedPersonaIds: intendedPersonaIds ?? this.intendedPersonaIds,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<DateTime>(day.value);
    }
    if (intention.present) {
      map['intention'] = Variable<String>(intention.value);
    }
    if (reflection.present) {
      map['reflection'] = Variable<String>(reflection.value);
    }
    if (intendedPersonaIds.present) {
      map['intended_persona_ids'] = Variable<String>(intendedPersonaIds.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayLogsCompanion(')
          ..write('day: $day, ')
          ..write('intention: $intention, ')
          ..write('reflection: $reflection, ')
          ..write('intendedPersonaIds: $intendedPersonaIds, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonasTable personas = $PersonasTable(this);
  late final $EnergyReadingsTable energyReadings = $EnergyReadingsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $CalendarPrefsTable calendarPrefs = $CalendarPrefsTable(this);
  late final $HiddenEventsTable hiddenEvents = $HiddenEventsTable(this);
  late final $EventPersonaOverridesTable eventPersonaOverrides =
      $EventPersonaOverridesTable(this);
  late final $EventEnergyImpactsTable eventEnergyImpacts =
      $EventEnergyImpactsTable(this);
  late final $LearnedAssociationsTable learnedAssociations =
      $LearnedAssociationsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitCompletionsTable habitCompletions = $HabitCompletionsTable(
    this,
  );
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $DayLogsTable dayLogs = $DayLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    personas,
    energyReadings,
    tasks,
    calendarPrefs,
    hiddenEvents,
    eventPersonaOverrides,
    eventEnergyImpacts,
    learnedAssociations,
    habits,
    habitCompletions,
    journalEntries,
    dayLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'personas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('energy_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'personas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'personas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habits', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_completions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'personas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('journal_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PersonasTableCreateCompanionBuilder = PersonasCompanion Function({
  required String id,
  required String userId,
  required String name,
  Value<String> emoji,
  required String archetype,
  Value<String?> primaryEnergy,
  Value<List<String>?> strengths,
  Value<List<String>?> weaknesses,
  Value<List<String>?> triggerConditions,
  Value<List<String>?> idealTasks,
  Value<String?> peakStartTime,
  Value<String?> peakEndTime,
  Value<String?> troughStartTime,
  Value<String?> troughEndTime,
  Value<String?> recoveryStartTime,
  Value<String?> recoveryEndTime,
  Value<double> idealWeeklyHours,
  Value<double> actualWeeklyHours,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PersonasTableUpdateCompanionBuilder = PersonasCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> emoji,
  Value<String> archetype,
  Value<String?> primaryEnergy,
  Value<List<String>?> strengths,
  Value<List<String>?> weaknesses,
  Value<List<String>?> triggerConditions,
  Value<List<String>?> idealTasks,
  Value<String?> peakStartTime,
  Value<String?> peakEndTime,
  Value<String?> troughStartTime,
  Value<String?> troughEndTime,
  Value<String?> recoveryStartTime,
  Value<String?> recoveryEndTime,
  Value<double> idealWeeklyHours,
  Value<double> actualWeeklyHours,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PersonasTableReferences
    extends BaseReferences<_$AppDatabase, $PersonasTable, PersonaRow> {
  $$PersonasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EnergyReadingsTable, List<EnergyReadingRow>>
  _energyReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.energyReadings,
    aliasName: 'personas__id__energy_readings__persona_id',
  );

  $$EnergyReadingsTableProcessedTableManager get energyReadingsRefs {
    final manager = $$EnergyReadingsTableTableManager(
      $_db,
      $_db.energyReadings,
    ).filter((f) => f.personaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_energyReadingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<TaskRow>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'personas__id__tasks__persona_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.personaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitsTable, List<HabitRow>> _habitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.habits,
    aliasName: 'personas__id__habits__persona_id',
  );

  $$HabitsTableProcessedTableManager get habitsRefs {
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.personaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntryRow>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: 'personas__id__journal_entries__persona_id',
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.personaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PersonasTableFilterComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get archetype => $composableBuilder(
    column: $table.archetype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryEnergy => $composableBuilder(
    column: $table.primaryEnergy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get strengths => $composableBuilder(
    column: $table.strengths,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get weaknesses => $composableBuilder(
    column: $table.weaknesses,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get triggerConditions => $composableBuilder(
    column: $table.triggerConditions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get idealTasks => $composableBuilder(
    column: $table.idealTasks,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get peakStartTime => $composableBuilder(
    column: $table.peakStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get peakEndTime => $composableBuilder(
    column: $table.peakEndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get troughStartTime => $composableBuilder(
    column: $table.troughStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get troughEndTime => $composableBuilder(
    column: $table.troughEndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryStartTime => $composableBuilder(
    column: $table.recoveryStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recoveryEndTime => $composableBuilder(
    column: $table.recoveryEndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get idealWeeklyHours => $composableBuilder(
    column: $table.idealWeeklyHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualWeeklyHours => $composableBuilder(
    column: $table.actualWeeklyHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> energyReadingsRefs(
    Expression<bool> Function($$EnergyReadingsTableFilterComposer f) f,
  ) {
    final $$EnergyReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyReadings,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyReadingsTableFilterComposer(
            $db: $db,
            $table: $db.energyReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitsRefs(
    Expression<bool> Function($$HabitsTableFilterComposer f) f,
  ) {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonasTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get archetype => $composableBuilder(
    column: $table.archetype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryEnergy => $composableBuilder(
    column: $table.primaryEnergy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strengths => $composableBuilder(
    column: $table.strengths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weaknesses => $composableBuilder(
    column: $table.weaknesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerConditions => $composableBuilder(
    column: $table.triggerConditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idealTasks => $composableBuilder(
    column: $table.idealTasks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get peakStartTime => $composableBuilder(
    column: $table.peakStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get peakEndTime => $composableBuilder(
    column: $table.peakEndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get troughStartTime => $composableBuilder(
    column: $table.troughStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get troughEndTime => $composableBuilder(
    column: $table.troughEndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryStartTime => $composableBuilder(
    column: $table.recoveryStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recoveryEndTime => $composableBuilder(
    column: $table.recoveryEndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get idealWeeklyHours => $composableBuilder(
    column: $table.idealWeeklyHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualWeeklyHours => $composableBuilder(
    column: $table.actualWeeklyHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<String> get archetype =>
      $composableBuilder(column: $table.archetype, builder: (column) => column);

  GeneratedColumn<String> get primaryEnergy => $composableBuilder(
    column: $table.primaryEnergy,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get strengths =>
      $composableBuilder(column: $table.strengths, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get weaknesses =>
      $composableBuilder(
        column: $table.weaknesses,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>?, String>
  get triggerConditions => $composableBuilder(
    column: $table.triggerConditions,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get idealTasks =>
      $composableBuilder(
        column: $table.idealTasks,
        builder: (column) => column,
      );

  GeneratedColumn<String> get peakStartTime => $composableBuilder(
    column: $table.peakStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get peakEndTime => $composableBuilder(
    column: $table.peakEndTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get troughStartTime => $composableBuilder(
    column: $table.troughStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get troughEndTime => $composableBuilder(
    column: $table.troughEndTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoveryStartTime => $composableBuilder(
    column: $table.recoveryStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recoveryEndTime => $composableBuilder(
    column: $table.recoveryEndTime,
    builder: (column) => column,
  );

  GeneratedColumn<double> get idealWeeklyHours => $composableBuilder(
    column: $table.idealWeeklyHours,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualWeeklyHours => $composableBuilder(
    column: $table.actualWeeklyHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> energyReadingsRefs<T extends Object>(
    Expression<T> Function($$EnergyReadingsTableAnnotationComposer a) f,
  ) {
    final $$EnergyReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.energyReadings,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EnergyReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.energyReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitsRefs<T extends Object>(
    Expression<T> Function($$HabitsTableAnnotationComposer a) f,
  ) {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.personaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonasTable,
          PersonaRow,
          $$PersonasTableFilterComposer,
          $$PersonasTableOrderingComposer,
          $$PersonasTableAnnotationComposer,
          $$PersonasTableCreateCompanionBuilder,
          $$PersonasTableUpdateCompanionBuilder,
          (PersonaRow, $$PersonasTableReferences),
          PersonaRow,
          PrefetchHooks Function({
            bool energyReadingsRefs,
            bool tasksRefs,
            bool habitsRefs,
            bool journalEntriesRefs,
          })
        > {
  $$PersonasTableTableManager(_$AppDatabase db, $PersonasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<String> archetype = const Value.absent(),
                Value<String?> primaryEnergy = const Value.absent(),
                Value<List<String>?> strengths = const Value.absent(),
                Value<List<String>?> weaknesses = const Value.absent(),
                Value<List<String>?> triggerConditions = const Value.absent(),
                Value<List<String>?> idealTasks = const Value.absent(),
                Value<String?> peakStartTime = const Value.absent(),
                Value<String?> peakEndTime = const Value.absent(),
                Value<String?> troughStartTime = const Value.absent(),
                Value<String?> troughEndTime = const Value.absent(),
                Value<String?> recoveryStartTime = const Value.absent(),
                Value<String?> recoveryEndTime = const Value.absent(),
                Value<double> idealWeeklyHours = const Value.absent(),
                Value<double> actualWeeklyHours = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonasCompanion(
                id: id,
                userId: userId,
                name: name,
                emoji: emoji,
                archetype: archetype,
                primaryEnergy: primaryEnergy,
                strengths: strengths,
                weaknesses: weaknesses,
                triggerConditions: triggerConditions,
                idealTasks: idealTasks,
                peakStartTime: peakStartTime,
                peakEndTime: peakEndTime,
                troughStartTime: troughStartTime,
                troughEndTime: troughEndTime,
                recoveryStartTime: recoveryStartTime,
                recoveryEndTime: recoveryEndTime,
                idealWeeklyHours: idealWeeklyHours,
                actualWeeklyHours: actualWeeklyHours,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                Value<String> emoji = const Value.absent(),
                required String archetype,
                Value<String?> primaryEnergy = const Value.absent(),
                Value<List<String>?> strengths = const Value.absent(),
                Value<List<String>?> weaknesses = const Value.absent(),
                Value<List<String>?> triggerConditions = const Value.absent(),
                Value<List<String>?> idealTasks = const Value.absent(),
                Value<String?> peakStartTime = const Value.absent(),
                Value<String?> peakEndTime = const Value.absent(),
                Value<String?> troughStartTime = const Value.absent(),
                Value<String?> troughEndTime = const Value.absent(),
                Value<String?> recoveryStartTime = const Value.absent(),
                Value<String?> recoveryEndTime = const Value.absent(),
                Value<double> idealWeeklyHours = const Value.absent(),
                Value<double> actualWeeklyHours = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonasCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                emoji: emoji,
                archetype: archetype,
                primaryEnergy: primaryEnergy,
                strengths: strengths,
                weaknesses: weaknesses,
                triggerConditions: triggerConditions,
                idealTasks: idealTasks,
                peakStartTime: peakStartTime,
                peakEndTime: peakEndTime,
                troughStartTime: troughStartTime,
                troughEndTime: troughEndTime,
                recoveryStartTime: recoveryStartTime,
                recoveryEndTime: recoveryEndTime,
                idealWeeklyHours: idealWeeklyHours,
                actualWeeklyHours: actualWeeklyHours,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                energyReadingsRefs = false,
                tasksRefs = false,
                habitsRefs = false,
                journalEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (energyReadingsRefs) db.energyReadings,
                    if (tasksRefs) db.tasks,
                    if (habitsRefs) db.habits,
                    if (journalEntriesRefs) db.journalEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (energyReadingsRefs)
                        await $_getPrefetchedData<
                          PersonaRow,
                          $PersonasTable,
                          EnergyReadingRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonasTableReferences
                              ._energyReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).energyReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<
                          PersonaRow,
                          $PersonasTable,
                          TaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonasTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (habitsRefs)
                        await $_getPrefetchedData<
                          PersonaRow,
                          $PersonasTable,
                          HabitRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonasTableReferences
                              ._habitsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).habitsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (journalEntriesRefs)
                        await $_getPrefetchedData<
                          PersonaRow,
                          $PersonasTable,
                          JournalEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$PersonasTableReferences
                              ._journalEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonasTableReferences(
                                db,
                                table,
                                p0,
                              ).journalEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PersonasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonasTable,
      PersonaRow,
      $$PersonasTableFilterComposer,
      $$PersonasTableOrderingComposer,
      $$PersonasTableAnnotationComposer,
      $$PersonasTableCreateCompanionBuilder,
      $$PersonasTableUpdateCompanionBuilder,
      (PersonaRow, $$PersonasTableReferences),
      PersonaRow,
      PrefetchHooks Function({
        bool energyReadingsRefs,
        bool tasksRefs,
        bool habitsRefs,
        bool journalEntriesRefs,
      })
    >;
typedef $$EnergyReadingsTableCreateCompanionBuilder =
    EnergyReadingsCompanion Function({
      required String id,
      required String personaId,
      Value<DateTime> timestamp,
      required int energyLevel,
      Value<double> confidence,
      Value<String> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$EnergyReadingsTableUpdateCompanionBuilder =
    EnergyReadingsCompanion Function({
      Value<String> id,
      Value<String> personaId,
      Value<DateTime> timestamp,
      Value<int> energyLevel,
      Value<double> confidence,
      Value<String> source,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$EnergyReadingsTableReferences
    extends
        BaseReferences<_$AppDatabase, $EnergyReadingsTable, EnergyReadingRow> {
  $$EnergyReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PersonasTable _personaIdTable(_$AppDatabase db) =>
      db.personas.createAlias('energy_readings__persona_id__personas__id');

  $$PersonasTableProcessedTableManager get personaId {
    final $_column = $_itemColumn<String>('persona_id')!;

    final manager = $$PersonasTableTableManager(
      $_db,
      $_db.personas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EnergyReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $EnergyReadingsTable> {
  $$EnergyReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonasTableFilterComposer get personaId {
    final $$PersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableFilterComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnergyReadingsTable> {
  $$EnergyReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonasTableOrderingComposer get personaId {
    final $$PersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableOrderingComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnergyReadingsTable> {
  $$EnergyReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PersonasTableAnnotationComposer get personaId {
    final $$PersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EnergyReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnergyReadingsTable,
          EnergyReadingRow,
          $$EnergyReadingsTableFilterComposer,
          $$EnergyReadingsTableOrderingComposer,
          $$EnergyReadingsTableAnnotationComposer,
          $$EnergyReadingsTableCreateCompanionBuilder,
          $$EnergyReadingsTableUpdateCompanionBuilder,
          (EnergyReadingRow, $$EnergyReadingsTableReferences),
          EnergyReadingRow,
          PrefetchHooks Function({bool personaId})
        > {
  $$EnergyReadingsTableTableManager(
    _$AppDatabase db,
    $EnergyReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnergyReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnergyReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnergyReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> energyLevel = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnergyReadingsCompanion(
                id: id,
                personaId: personaId,
                timestamp: timestamp,
                energyLevel: energyLevel,
                confidence: confidence,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String personaId,
                Value<DateTime> timestamp = const Value.absent(),
                required int energyLevel,
                Value<double> confidence = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnergyReadingsCompanion.insert(
                id: id,
                personaId: personaId,
                timestamp: timestamp,
                energyLevel: energyLevel,
                confidence: confidence,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EnergyReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({personaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (personaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.personaId,
                        referencedTable: $$EnergyReadingsTableReferences
                            ._personaIdTable(db),
                        referencedColumn: $$EnergyReadingsTableReferences
                            ._personaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EnergyReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnergyReadingsTable,
      EnergyReadingRow,
      $$EnergyReadingsTableFilterComposer,
      $$EnergyReadingsTableOrderingComposer,
      $$EnergyReadingsTableAnnotationComposer,
      $$EnergyReadingsTableCreateCompanionBuilder,
      $$EnergyReadingsTableUpdateCompanionBuilder,
      (EnergyReadingRow, $$EnergyReadingsTableReferences),
      EnergyReadingRow,
      PrefetchHooks Function({bool personaId})
    >;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String userId,
  required String personaId,
  required String title,
  Value<int> energyRequired,
  Value<int> priority,
  Value<int> estimatedMinutes,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> personaId,
  Value<String> title,
  Value<int> energyRequired,
  Value<int> priority,
  Value<int> estimatedMinutes,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, TaskRow> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonasTable _personaIdTable(_$AppDatabase db) =>
      db.personas.createAlias('tasks__persona_id__personas__id');

  $$PersonasTableProcessedTableManager get personaId {
    final $_column = $_itemColumn<String>('persona_id')!;

    final manager = $$PersonasTableTableManager(
      $_db,
      $_db.personas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonasTableFilterComposer get personaId {
    final $$PersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableFilterComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonasTableOrderingComposer get personaId {
    final $$PersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableOrderingComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PersonasTableAnnotationComposer get personaId {
    final $$PersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          TaskRow,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (TaskRow, $$TasksTableReferences),
          TaskRow,
          PrefetchHooks Function({bool personaId})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> energyRequired = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                userId: userId,
                personaId: personaId,
                title: title,
                energyRequired: energyRequired,
                priority: priority,
                estimatedMinutes: estimatedMinutes,
                completed: completed,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String personaId,
                required String title,
                Value<int> energyRequired = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                userId: userId,
                personaId: personaId,
                title: title,
                energyRequired: energyRequired,
                priority: priority,
                estimatedMinutes: estimatedMinutes,
                completed: completed,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({personaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (personaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.personaId,
                        referencedTable: $$TasksTableReferences._personaIdTable(
                          db,
                        ),
                        referencedColumn: $$TasksTableReferences
                            ._personaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      TaskRow,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (TaskRow, $$TasksTableReferences),
      TaskRow,
      PrefetchHooks Function({bool personaId})
    >;
typedef $$CalendarPrefsTableCreateCompanionBuilder =
    CalendarPrefsCompanion Function({
      required String calendarId,
      required String kind,
      Value<int> rowid,
    });
typedef $$CalendarPrefsTableUpdateCompanionBuilder =
    CalendarPrefsCompanion Function({
      Value<String> calendarId,
      Value<String> kind,
      Value<int> rowid,
    });

class $$CalendarPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarPrefsTable> {
  $$CalendarPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalendarPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarPrefsTable> {
  $$CalendarPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarPrefsTable> {
  $$CalendarPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);
}

class $$CalendarPrefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarPrefsTable,
          CalendarPrefRow,
          $$CalendarPrefsTableFilterComposer,
          $$CalendarPrefsTableOrderingComposer,
          $$CalendarPrefsTableAnnotationComposer,
          $$CalendarPrefsTableCreateCompanionBuilder,
          $$CalendarPrefsTableUpdateCompanionBuilder,
          (
            CalendarPrefRow,
            BaseReferences<_$AppDatabase, $CalendarPrefsTable, CalendarPrefRow>,
          ),
          CalendarPrefRow,
          PrefetchHooks Function()
        > {
  $$CalendarPrefsTableTableManager(_$AppDatabase db, $CalendarPrefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> calendarId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarPrefsCompanion(
                calendarId: calendarId,
                kind: kind,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String calendarId,
                required String kind,
                Value<int> rowid = const Value.absent(),
              }) => CalendarPrefsCompanion.insert(
                calendarId: calendarId,
                kind: kind,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalendarPrefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarPrefsTable,
      CalendarPrefRow,
      $$CalendarPrefsTableFilterComposer,
      $$CalendarPrefsTableOrderingComposer,
      $$CalendarPrefsTableAnnotationComposer,
      $$CalendarPrefsTableCreateCompanionBuilder,
      $$CalendarPrefsTableUpdateCompanionBuilder,
      (
        CalendarPrefRow,
        BaseReferences<_$AppDatabase, $CalendarPrefsTable, CalendarPrefRow>,
      ),
      CalendarPrefRow,
      PrefetchHooks Function()
    >;
typedef $$HiddenEventsTableCreateCompanionBuilder =
    HiddenEventsCompanion Function({required String eventId, Value<int> rowid});
typedef $$HiddenEventsTableUpdateCompanionBuilder =
    HiddenEventsCompanion Function({Value<String> eventId, Value<int> rowid});

class $$HiddenEventsTableFilterComposer
    extends Composer<_$AppDatabase, $HiddenEventsTable> {
  $$HiddenEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HiddenEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $HiddenEventsTable> {
  $$HiddenEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HiddenEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HiddenEventsTable> {
  $$HiddenEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);
}

class $$HiddenEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HiddenEventsTable,
          HiddenEventRow,
          $$HiddenEventsTableFilterComposer,
          $$HiddenEventsTableOrderingComposer,
          $$HiddenEventsTableAnnotationComposer,
          $$HiddenEventsTableCreateCompanionBuilder,
          $$HiddenEventsTableUpdateCompanionBuilder,
          (
            HiddenEventRow,
            BaseReferences<_$AppDatabase, $HiddenEventsTable, HiddenEventRow>,
          ),
          HiddenEventRow,
          PrefetchHooks Function()
        > {
  $$HiddenEventsTableTableManager(_$AppDatabase db, $HiddenEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HiddenEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HiddenEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HiddenEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> eventId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => HiddenEventsCompanion(eventId: eventId, rowid: rowid),
          createCompanionCallback: ({
            required String eventId,
            Value<int> rowid = const Value.absent(),
          }) => HiddenEventsCompanion.insert(eventId: eventId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HiddenEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HiddenEventsTable,
      HiddenEventRow,
      $$HiddenEventsTableFilterComposer,
      $$HiddenEventsTableOrderingComposer,
      $$HiddenEventsTableAnnotationComposer,
      $$HiddenEventsTableCreateCompanionBuilder,
      $$HiddenEventsTableUpdateCompanionBuilder,
      (
        HiddenEventRow,
        BaseReferences<_$AppDatabase, $HiddenEventsTable, HiddenEventRow>,
      ),
      HiddenEventRow,
      PrefetchHooks Function()
    >;
typedef $$EventPersonaOverridesTableCreateCompanionBuilder =
    EventPersonaOverridesCompanion Function({
      required String eventId,
      required String personaId,
      Value<int> rowid,
    });
typedef $$EventPersonaOverridesTableUpdateCompanionBuilder =
    EventPersonaOverridesCompanion Function({
      Value<String> eventId,
      Value<String> personaId,
      Value<int> rowid,
    });

class $$EventPersonaOverridesTableFilterComposer
    extends Composer<_$AppDatabase, $EventPersonaOverridesTable> {
  $$EventPersonaOverridesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personaId => $composableBuilder(
    column: $table.personaId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventPersonaOverridesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventPersonaOverridesTable> {
  $$EventPersonaOverridesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personaId => $composableBuilder(
    column: $table.personaId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventPersonaOverridesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventPersonaOverridesTable> {
  $$EventPersonaOverridesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get personaId =>
      $composableBuilder(column: $table.personaId, builder: (column) => column);
}

class $$EventPersonaOverridesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventPersonaOverridesTable,
          EventPersonaRow,
          $$EventPersonaOverridesTableFilterComposer,
          $$EventPersonaOverridesTableOrderingComposer,
          $$EventPersonaOverridesTableAnnotationComposer,
          $$EventPersonaOverridesTableCreateCompanionBuilder,
          $$EventPersonaOverridesTableUpdateCompanionBuilder,
          (
            EventPersonaRow,
            BaseReferences<
              _$AppDatabase,
              $EventPersonaOverridesTable,
              EventPersonaRow
            >,
          ),
          EventPersonaRow,
          PrefetchHooks Function()
        > {
  $$EventPersonaOverridesTableTableManager(
    _$AppDatabase db,
    $EventPersonaOverridesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventPersonaOverridesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$EventPersonaOverridesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EventPersonaOverridesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventPersonaOverridesCompanion(
                eventId: eventId,
                personaId: personaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String personaId,
                Value<int> rowid = const Value.absent(),
              }) => EventPersonaOverridesCompanion.insert(
                eventId: eventId,
                personaId: personaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventPersonaOverridesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventPersonaOverridesTable,
      EventPersonaRow,
      $$EventPersonaOverridesTableFilterComposer,
      $$EventPersonaOverridesTableOrderingComposer,
      $$EventPersonaOverridesTableAnnotationComposer,
      $$EventPersonaOverridesTableCreateCompanionBuilder,
      $$EventPersonaOverridesTableUpdateCompanionBuilder,
      (
        EventPersonaRow,
        BaseReferences<
          _$AppDatabase,
          $EventPersonaOverridesTable,
          EventPersonaRow
        >,
      ),
      EventPersonaRow,
      PrefetchHooks Function()
    >;
typedef $$EventEnergyImpactsTableCreateCompanionBuilder =
    EventEnergyImpactsCompanion Function({
      required String eventId,
      required int impact,
      Value<int> rowid,
    });
typedef $$EventEnergyImpactsTableUpdateCompanionBuilder =
    EventEnergyImpactsCompanion Function({
      Value<String> eventId,
      Value<int> impact,
      Value<int> rowid,
    });

class $$EventEnergyImpactsTableFilterComposer
    extends Composer<_$AppDatabase, $EventEnergyImpactsTable> {
  $$EventEnergyImpactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get impact => $composableBuilder(
    column: $table.impact,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventEnergyImpactsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventEnergyImpactsTable> {
  $$EventEnergyImpactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get impact => $composableBuilder(
    column: $table.impact,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventEnergyImpactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventEnergyImpactsTable> {
  $$EventEnergyImpactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<int> get impact =>
      $composableBuilder(column: $table.impact, builder: (column) => column);
}

class $$EventEnergyImpactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventEnergyImpactsTable,
          EventEnergyImpactRow,
          $$EventEnergyImpactsTableFilterComposer,
          $$EventEnergyImpactsTableOrderingComposer,
          $$EventEnergyImpactsTableAnnotationComposer,
          $$EventEnergyImpactsTableCreateCompanionBuilder,
          $$EventEnergyImpactsTableUpdateCompanionBuilder,
          (
            EventEnergyImpactRow,
            BaseReferences<
              _$AppDatabase,
              $EventEnergyImpactsTable,
              EventEnergyImpactRow
            >,
          ),
          EventEnergyImpactRow,
          PrefetchHooks Function()
        > {
  $$EventEnergyImpactsTableTableManager(
    _$AppDatabase db,
    $EventEnergyImpactsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventEnergyImpactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventEnergyImpactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventEnergyImpactsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<int> impact = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventEnergyImpactsCompanion(
                eventId: eventId,
                impact: impact,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required int impact,
                Value<int> rowid = const Value.absent(),
              }) => EventEnergyImpactsCompanion.insert(
                eventId: eventId,
                impact: impact,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventEnergyImpactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventEnergyImpactsTable,
      EventEnergyImpactRow,
      $$EventEnergyImpactsTableFilterComposer,
      $$EventEnergyImpactsTableOrderingComposer,
      $$EventEnergyImpactsTableAnnotationComposer,
      $$EventEnergyImpactsTableCreateCompanionBuilder,
      $$EventEnergyImpactsTableUpdateCompanionBuilder,
      (
        EventEnergyImpactRow,
        BaseReferences<
          _$AppDatabase,
          $EventEnergyImpactsTable,
          EventEnergyImpactRow
        >,
      ),
      EventEnergyImpactRow,
      PrefetchHooks Function()
    >;
typedef $$LearnedAssociationsTableCreateCompanionBuilder =
    LearnedAssociationsCompanion Function({
      required String token,
      required String personaId,
      Value<int> weight,
      Value<int> rowid,
    });
typedef $$LearnedAssociationsTableUpdateCompanionBuilder =
    LearnedAssociationsCompanion Function({
      Value<String> token,
      Value<String> personaId,
      Value<int> weight,
      Value<int> rowid,
    });

class $$LearnedAssociationsTableFilterComposer
    extends Composer<_$AppDatabase, $LearnedAssociationsTable> {
  $$LearnedAssociationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personaId => $composableBuilder(
    column: $table.personaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearnedAssociationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearnedAssociationsTable> {
  $$LearnedAssociationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personaId => $composableBuilder(
    column: $table.personaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearnedAssociationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearnedAssociationsTable> {
  $$LearnedAssociationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get personaId =>
      $composableBuilder(column: $table.personaId, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);
}

class $$LearnedAssociationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearnedAssociationsTable,
          LearnedAssociationRow,
          $$LearnedAssociationsTableFilterComposer,
          $$LearnedAssociationsTableOrderingComposer,
          $$LearnedAssociationsTableAnnotationComposer,
          $$LearnedAssociationsTableCreateCompanionBuilder,
          $$LearnedAssociationsTableUpdateCompanionBuilder,
          (
            LearnedAssociationRow,
            BaseReferences<
              _$AppDatabase,
              $LearnedAssociationsTable,
              LearnedAssociationRow
            >,
          ),
          LearnedAssociationRow,
          PrefetchHooks Function()
        > {
  $$LearnedAssociationsTableTableManager(
    _$AppDatabase db,
    $LearnedAssociationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearnedAssociationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearnedAssociationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LearnedAssociationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> token = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearnedAssociationsCompanion(
                token: token,
                personaId: personaId,
                weight: weight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String token,
                required String personaId,
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearnedAssociationsCompanion.insert(
                token: token,
                personaId: personaId,
                weight: weight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearnedAssociationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearnedAssociationsTable,
      LearnedAssociationRow,
      $$LearnedAssociationsTableFilterComposer,
      $$LearnedAssociationsTableOrderingComposer,
      $$LearnedAssociationsTableAnnotationComposer,
      $$LearnedAssociationsTableCreateCompanionBuilder,
      $$LearnedAssociationsTableUpdateCompanionBuilder,
      (
        LearnedAssociationRow,
        BaseReferences<
          _$AppDatabase,
          $LearnedAssociationsTable,
          LearnedAssociationRow
        >,
      ),
      LearnedAssociationRow,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String userId,
  required String personaId,
  required String title,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> personaId,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonasTable _personaIdTable(_$AppDatabase db) =>
      db.personas.createAlias('habits__persona_id__personas__id');

  $$PersonasTableProcessedTableManager get personaId {
    final $_column = $_itemColumn<String>('persona_id')!;

    final manager = $$PersonasTableTableManager(
      $_db,
      $_db.personas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HabitCompletionsTable, List<HabitCompletionRow>>
  _habitCompletionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitCompletions,
    aliasName: 'habits__id__habit_completions__habit_id',
  );

  $$HabitCompletionsTableProcessedTableManager get habitCompletionsRefs {
    final manager = $$HabitCompletionsTableTableManager(
      $_db,
      $_db.habitCompletions,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonasTableFilterComposer get personaId {
    final $$PersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableFilterComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> habitCompletionsRefs(
    Expression<bool> Function($$HabitCompletionsTableFilterComposer f) f,
  ) {
    final $$HabitCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonasTableOrderingComposer get personaId {
    final $$PersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableOrderingComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PersonasTableAnnotationComposer get personaId {
    final $$PersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> habitCompletionsRefs<T extends Object>(
    Expression<T> Function($$HabitCompletionsTableAnnotationComposer a) f,
  ) {
    final $$HabitCompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool personaId, bool habitCompletionsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                userId: userId,
                personaId: personaId,
                title: title,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String personaId,
                required String title,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                userId: userId,
                personaId: personaId,
                title: title,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({personaId = false, habitCompletionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitCompletionsRefs) db.habitCompletions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (personaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.personaId,
                            referencedTable: $$HabitsTableReferences
                                ._personaIdTable(db),
                            referencedColumn: $$HabitsTableReferences
                                ._personaIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitCompletionsRefs)
                        await $_getPrefetchedData<
                          HabitRow,
                          $HabitsTable,
                          HabitCompletionRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitCompletionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitCompletionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool personaId, bool habitCompletionsRefs})
    >;
typedef $$HabitCompletionsTableCreateCompanionBuilder =
    HabitCompletionsCompanion Function({
      required String habitId,
      required DateTime day,
      Value<int> rowid,
    });
typedef $$HabitCompletionsTableUpdateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<String> habitId,
      Value<DateTime> day,
      Value<int> rowid,
    });

final class $$HabitCompletionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletionRow
        > {
  $$HabitCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_completions__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletionRow,
          $$HabitCompletionsTableFilterComposer,
          $$HabitCompletionsTableOrderingComposer,
          $$HabitCompletionsTableAnnotationComposer,
          $$HabitCompletionsTableCreateCompanionBuilder,
          $$HabitCompletionsTableUpdateCompanionBuilder,
          (HabitCompletionRow, $$HabitCompletionsTableReferences),
          HabitCompletionRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitCompletionsTableTableManager(
    _$AppDatabase db,
    $HabitCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<DateTime> day = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitCompletionsCompanion(
                habitId: habitId,
                day: day,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required DateTime day,
                Value<int> rowid = const Value.absent(),
              }) => HabitCompletionsCompanion.insert(
                habitId: habitId,
                day: day,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$HabitCompletionsTableReferences
                            ._habitIdTable(db),
                        referencedColumn: $$HabitCompletionsTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitCompletionsTable,
      HabitCompletionRow,
      $$HabitCompletionsTableFilterComposer,
      $$HabitCompletionsTableOrderingComposer,
      $$HabitCompletionsTableAnnotationComposer,
      $$HabitCompletionsTableCreateCompanionBuilder,
      $$HabitCompletionsTableUpdateCompanionBuilder,
      (HabitCompletionRow, $$HabitCompletionsTableReferences),
      HabitCompletionRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      required String id,
      required String userId,
      required String personaId,
      Value<String?> prompt,
      required String body,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> personaId,
      Value<String?> prompt,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$JournalEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntryRow> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PersonasTable _personaIdTable(_$AppDatabase db) =>
      db.personas.createAlias('journal_entries__persona_id__personas__id');

  $$PersonasTableProcessedTableManager get personaId {
    final $_column = $_itemColumn<String>('persona_id')!;

    final manager = $$PersonasTableTableManager(
      $_db,
      $_db.personas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonasTableFilterComposer get personaId {
    final $$PersonasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableFilterComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonasTableOrderingComposer get personaId {
    final $$PersonasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableOrderingComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PersonasTableAnnotationComposer get personaId {
    final $$PersonasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personaId,
      referencedTable: $db.personas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonasTableAnnotationComposer(
            $db: $db,
            $table: $db.personas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntryRow,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntryRow, $$JournalEntriesTableReferences),
          JournalEntryRow,
          PrefetchHooks Function({bool personaId})
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> personaId = const Value.absent(),
                Value<String?> prompt = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                userId: userId,
                personaId: personaId,
                prompt: prompt,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String personaId,
                Value<String?> prompt = const Value.absent(),
                required String body,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                userId: userId,
                personaId: personaId,
                prompt: prompt,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({personaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (personaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.personaId,
                        referencedTable: $$JournalEntriesTableReferences
                            ._personaIdTable(db),
                        referencedColumn: $$JournalEntriesTableReferences
                            ._personaIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntryRow,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntryRow, $$JournalEntriesTableReferences),
      JournalEntryRow,
      PrefetchHooks Function({bool personaId})
    >;
typedef $$DayLogsTableCreateCompanionBuilder = DayLogsCompanion Function({
  required DateTime day,
  Value<String?> intention,
  Value<String?> reflection,
  Value<String?> intendedPersonaIds,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$DayLogsTableUpdateCompanionBuilder = DayLogsCompanion Function({
  Value<DateTime> day,
  Value<String?> intention,
  Value<String?> reflection,
  Value<String?> intendedPersonaIds,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DayLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intendedPersonaIds => $composableBuilder(
    column: $table.intendedPersonaIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intendedPersonaIds => $composableBuilder(
    column: $table.intendedPersonaIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get intention =>
      $composableBuilder(column: $table.intention, builder: (column) => column);

  GeneratedColumn<String> get reflection => $composableBuilder(
    column: $table.reflection,
    builder: (column) => column,
  );

  GeneratedColumn<String> get intendedPersonaIds => $composableBuilder(
    column: $table.intendedPersonaIds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DayLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayLogsTable,
          DayLogRow,
          $$DayLogsTableFilterComposer,
          $$DayLogsTableOrderingComposer,
          $$DayLogsTableAnnotationComposer,
          $$DayLogsTableCreateCompanionBuilder,
          $$DayLogsTableUpdateCompanionBuilder,
          (DayLogRow, BaseReferences<_$AppDatabase, $DayLogsTable, DayLogRow>),
          DayLogRow,
          PrefetchHooks Function()
        > {
  $$DayLogsTableTableManager(_$AppDatabase db, $DayLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> day = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<String?> intendedPersonaIds = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayLogsCompanion(
                day: day,
                intention: intention,
                reflection: reflection,
                intendedPersonaIds: intendedPersonaIds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime day,
                Value<String?> intention = const Value.absent(),
                Value<String?> reflection = const Value.absent(),
                Value<String?> intendedPersonaIds = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayLogsCompanion.insert(
                day: day,
                intention: intention,
                reflection: reflection,
                intendedPersonaIds: intendedPersonaIds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayLogsTable,
      DayLogRow,
      $$DayLogsTableFilterComposer,
      $$DayLogsTableOrderingComposer,
      $$DayLogsTableAnnotationComposer,
      $$DayLogsTableCreateCompanionBuilder,
      $$DayLogsTableUpdateCompanionBuilder,
      (DayLogRow, BaseReferences<_$AppDatabase, $DayLogsTable, DayLogRow>),
      DayLogRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonasTableTableManager get personas =>
      $$PersonasTableTableManager(_db, _db.personas);
  $$EnergyReadingsTableTableManager get energyReadings =>
      $$EnergyReadingsTableTableManager(_db, _db.energyReadings);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$CalendarPrefsTableTableManager get calendarPrefs =>
      $$CalendarPrefsTableTableManager(_db, _db.calendarPrefs);
  $$HiddenEventsTableTableManager get hiddenEvents =>
      $$HiddenEventsTableTableManager(_db, _db.hiddenEvents);
  $$EventPersonaOverridesTableTableManager get eventPersonaOverrides =>
      $$EventPersonaOverridesTableTableManager(_db, _db.eventPersonaOverrides);
  $$EventEnergyImpactsTableTableManager get eventEnergyImpacts =>
      $$EventEnergyImpactsTableTableManager(_db, _db.eventEnergyImpacts);
  $$LearnedAssociationsTableTableManager get learnedAssociations =>
      $$LearnedAssociationsTableTableManager(_db, _db.learnedAssociations);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(_db, _db.habitCompletions);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$DayLogsTableTableManager get dayLogs =>
      $$DayLogsTableTableManager(_db, _db.dayLogs);
}
