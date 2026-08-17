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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonasTable personas = $PersonasTable(this);
  late final $EnergyReadingsTable energyReadings = $EnergyReadingsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $CalendarPrefsTable calendarPrefs = $CalendarPrefsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    personas,
    energyReadings,
    tasks,
    calendarPrefs,
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
          PrefetchHooks Function({bool energyReadingsRefs, bool tasksRefs})
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
              ({energyReadingsRefs = false, tasksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (energyReadingsRefs) db.energyReadings,
                    if (tasksRefs) db.tasks,
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
      PrefetchHooks Function({bool energyReadingsRefs, bool tasksRefs})
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
}
