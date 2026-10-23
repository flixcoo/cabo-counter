// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GameSessionTableTable extends GameSessionTable
    with TableInfo<$GameSessionTableTable, GameSessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameSessionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameTitleMeta = const VerificationMeta(
    'gameTitle',
  );
  @override
  late final GeneratedColumn<String> gameTitle = GeneratedColumn<String>(
    'game_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointLimitMeta = const VerificationMeta(
    'pointLimit',
  );
  @override
  late final GeneratedColumn<int> pointLimit = GeneratedColumn<int>(
    'point_limit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caboPenaltyMeta = const VerificationMeta(
    'caboPenalty',
  );
  @override
  late final GeneratedColumn<int> caboPenalty = GeneratedColumn<int>(
    'cabo_penalty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isGameFinishedMeta = const VerificationMeta(
    'isGameFinished',
  );
  @override
  late final GeneratedColumn<bool> isGameFinished = GeneratedColumn<bool>(
    'is_game_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_game_finished" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    gameTitle,
    pointLimit,
    caboPenalty,
    isGameFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_session_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameSessionTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('game_title')) {
      context.handle(
        _gameTitleMeta,
        gameTitle.isAcceptableOrUnknown(data['game_title']!, _gameTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_gameTitleMeta);
    }
    if (data.containsKey('point_limit')) {
      context.handle(
        _pointLimitMeta,
        pointLimit.isAcceptableOrUnknown(data['point_limit']!, _pointLimitMeta),
      );
    }
    if (data.containsKey('cabo_penalty')) {
      context.handle(
        _caboPenaltyMeta,
        caboPenalty.isAcceptableOrUnknown(
          data['cabo_penalty']!,
          _caboPenaltyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caboPenaltyMeta);
    }
    if (data.containsKey('is_game_finished')) {
      context.handle(
        _isGameFinishedMeta,
        isGameFinished.isAcceptableOrUnknown(
          data['is_game_finished']!,
          _isGameFinishedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isGameFinishedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameSessionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameSessionTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      gameTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_title'],
      )!,
      pointLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_limit'],
      ),
      caboPenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabo_penalty'],
      )!,
      isGameFinished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_game_finished'],
      )!,
    );
  }

  @override
  $GameSessionTableTable createAlias(String alias) {
    return $GameSessionTableTable(attachedDatabase, alias);
  }
}

class GameSessionTableData extends DataClass
    implements Insertable<GameSessionTableData> {
  final String id;
  final DateTime createdAt;
  final String gameTitle;
  final int? pointLimit;
  final int caboPenalty;
  final bool isGameFinished;
  const GameSessionTableData({
    required this.id,
    required this.createdAt,
    required this.gameTitle,
    this.pointLimit,
    required this.caboPenalty,
    required this.isGameFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['game_title'] = Variable<String>(gameTitle);
    if (!nullToAbsent || pointLimit != null) {
      map['point_limit'] = Variable<int>(pointLimit);
    }
    map['cabo_penalty'] = Variable<int>(caboPenalty);
    map['is_game_finished'] = Variable<bool>(isGameFinished);
    return map;
  }

  GameSessionTableCompanion toCompanion(bool nullToAbsent) {
    return GameSessionTableCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      gameTitle: Value(gameTitle),
      pointLimit: pointLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(pointLimit),
      caboPenalty: Value(caboPenalty),
      isGameFinished: Value(isGameFinished),
    );
  }

  factory GameSessionTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameSessionTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      gameTitle: serializer.fromJson<String>(json['gameTitle']),
      pointLimit: serializer.fromJson<int?>(json['pointLimit']),
      caboPenalty: serializer.fromJson<int>(json['caboPenalty']),
      isGameFinished: serializer.fromJson<bool>(json['isGameFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'gameTitle': serializer.toJson<String>(gameTitle),
      'pointLimit': serializer.toJson<int?>(pointLimit),
      'caboPenalty': serializer.toJson<int>(caboPenalty),
      'isGameFinished': serializer.toJson<bool>(isGameFinished),
    };
  }

  GameSessionTableData copyWith({
    String? id,
    DateTime? createdAt,
    String? gameTitle,
    Value<int?> pointLimit = const Value.absent(),
    int? caboPenalty,
    bool? isGameFinished,
  }) => GameSessionTableData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    gameTitle: gameTitle ?? this.gameTitle,
    pointLimit: pointLimit.present ? pointLimit.value : this.pointLimit,
    caboPenalty: caboPenalty ?? this.caboPenalty,
    isGameFinished: isGameFinished ?? this.isGameFinished,
  );
  GameSessionTableData copyWithCompanion(GameSessionTableCompanion data) {
    return GameSessionTableData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      gameTitle: data.gameTitle.present ? data.gameTitle.value : this.gameTitle,
      pointLimit: data.pointLimit.present
          ? data.pointLimit.value
          : this.pointLimit,
      caboPenalty: data.caboPenalty.present
          ? data.caboPenalty.value
          : this.caboPenalty,
      isGameFinished: data.isGameFinished.present
          ? data.isGameFinished.value
          : this.isGameFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isGameFinished: $isGameFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    gameTitle,
    pointLimit,
    caboPenalty,
    isGameFinished,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameSessionTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.gameTitle == this.gameTitle &&
          other.pointLimit == this.pointLimit &&
          other.caboPenalty == this.caboPenalty &&
          other.isGameFinished == this.isGameFinished);
}

class GameSessionTableCompanion extends UpdateCompanion<GameSessionTableData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> gameTitle;
  final Value<int?> pointLimit;
  final Value<int> caboPenalty;
  final Value<bool> isGameFinished;
  final Value<int> rowid;
  const GameSessionTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.gameTitle = const Value.absent(),
    this.pointLimit = const Value.absent(),
    this.caboPenalty = const Value.absent(),
    this.isGameFinished = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameSessionTableCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String gameTitle,
    this.pointLimit = const Value.absent(),
    required int caboPenalty,
    required bool isGameFinished,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       gameTitle = Value(gameTitle),
       caboPenalty = Value(caboPenalty),
       isGameFinished = Value(isGameFinished);
  static Insertable<GameSessionTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? gameTitle,
    Expression<int>? pointLimit,
    Expression<int>? caboPenalty,
    Expression<bool>? isGameFinished,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (gameTitle != null) 'game_title': gameTitle,
      if (pointLimit != null) 'point_limit': pointLimit,
      if (caboPenalty != null) 'cabo_penalty': caboPenalty,
      if (isGameFinished != null) 'is_game_finished': isGameFinished,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameSessionTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? gameTitle,
    Value<int?>? pointLimit,
    Value<int>? caboPenalty,
    Value<bool>? isGameFinished,
    Value<int>? rowid,
  }) {
    return GameSessionTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      gameTitle: gameTitle ?? this.gameTitle,
      pointLimit: pointLimit ?? this.pointLimit,
      caboPenalty: caboPenalty ?? this.caboPenalty,
      isGameFinished: isGameFinished ?? this.isGameFinished,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (gameTitle.present) {
      map['game_title'] = Variable<String>(gameTitle.value);
    }
    if (pointLimit.present) {
      map['point_limit'] = Variable<int>(pointLimit.value);
    }
    if (caboPenalty.present) {
      map['cabo_penalty'] = Variable<int>(caboPenalty.value);
    }
    if (isGameFinished.present) {
      map['is_game_finished'] = Variable<bool>(isGameFinished.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameSessionTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('gameTitle: $gameTitle, ')
          ..write('pointLimit: $pointLimit, ')
          ..write('caboPenalty: $caboPenalty, ')
          ..write('isGameFinished: $isGameFinished, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerTableTable extends PlayerTable
    with TableInfo<$PlayerTableTable, PlayerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameSessionIdMeta = const VerificationMeta(
    'gameSessionId',
  );
  @override
  late final GeneratedColumn<String> gameSessionId = GeneratedColumn<String>(
    'game_session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_session_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _totalScoreMeta = const VerificationMeta(
    'totalScore',
  );
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
    'total_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gameSessionId,
    totalScore,
    position,
    name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_session_id')) {
      context.handle(
        _gameSessionIdMeta,
        gameSessionId.isAcceptableOrUnknown(
          data['game_session_id']!,
          _gameSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gameSessionIdMeta);
    }
    if (data.containsKey('total_score')) {
      context.handle(
        _totalScoreMeta,
        totalScore.isAcceptableOrUnknown(data['total_score']!, _totalScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_totalScoreMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_session_id'],
      )!,
      totalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_score'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PlayerTableTable createAlias(String alias) {
    return $PlayerTableTable(attachedDatabase, alias);
  }
}

class PlayerTableData extends DataClass implements Insertable<PlayerTableData> {
  final String id;
  final String gameSessionId;
  final int totalScore;
  final int position;
  final String name;
  const PlayerTableData({
    required this.id,
    required this.gameSessionId,
    required this.totalScore,
    required this.position,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_session_id'] = Variable<String>(gameSessionId);
    map['total_score'] = Variable<int>(totalScore);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlayerTableCompanion toCompanion(bool nullToAbsent) {
    return PlayerTableCompanion(
      id: Value(id),
      gameSessionId: Value(gameSessionId),
      totalScore: Value(totalScore),
      position: Value(position),
      name: Value(name),
    );
  }

  factory PlayerTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerTableData(
      id: serializer.fromJson<String>(json['id']),
      gameSessionId: serializer.fromJson<String>(json['gameSessionId']),
      totalScore: serializer.fromJson<int>(json['totalScore']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameSessionId': serializer.toJson<String>(gameSessionId),
      'totalScore': serializer.toJson<int>(totalScore),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
    };
  }

  PlayerTableData copyWith({
    String? id,
    String? gameSessionId,
    int? totalScore,
    int? position,
    String? name,
  }) => PlayerTableData(
    id: id ?? this.id,
    gameSessionId: gameSessionId ?? this.gameSessionId,
    totalScore: totalScore ?? this.totalScore,
    position: position ?? this.position,
    name: name ?? this.name,
  );
  PlayerTableData copyWithCompanion(PlayerTableCompanion data) {
    return PlayerTableData(
      id: data.id.present ? data.id.value : this.id,
      gameSessionId: data.gameSessionId.present
          ? data.gameSessionId.value
          : this.gameSessionId,
      totalScore: data.totalScore.present
          ? data.totalScore.value
          : this.totalScore,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableData(')
          ..write('id: $id, ')
          ..write('gameSessionId: $gameSessionId, ')
          ..write('totalScore: $totalScore, ')
          ..write('position: $position, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gameSessionId, totalScore, position, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerTableData &&
          other.id == this.id &&
          other.gameSessionId == this.gameSessionId &&
          other.totalScore == this.totalScore &&
          other.position == this.position &&
          other.name == this.name);
}

class PlayerTableCompanion extends UpdateCompanion<PlayerTableData> {
  final Value<String> id;
  final Value<String> gameSessionId;
  final Value<int> totalScore;
  final Value<int> position;
  final Value<String> name;
  final Value<int> rowid;
  const PlayerTableCompanion({
    this.id = const Value.absent(),
    this.gameSessionId = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerTableCompanion.insert({
    required String id,
    required String gameSessionId,
    required int totalScore,
    required int position,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameSessionId = Value(gameSessionId),
       totalScore = Value(totalScore),
       position = Value(position),
       name = Value(name);
  static Insertable<PlayerTableData> custom({
    Expression<String>? id,
    Expression<String>? gameSessionId,
    Expression<int>? totalScore,
    Expression<int>? position,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameSessionId != null) 'game_session_id': gameSessionId,
      if (totalScore != null) 'total_score': totalScore,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerTableCompanion copyWith({
    Value<String>? id,
    Value<String>? gameSessionId,
    Value<int>? totalScore,
    Value<int>? position,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return PlayerTableCompanion(
      id: id ?? this.id,
      gameSessionId: gameSessionId ?? this.gameSessionId,
      totalScore: totalScore ?? this.totalScore,
      position: position ?? this.position,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameSessionId.present) {
      map['game_session_id'] = Variable<String>(gameSessionId.value);
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerTableCompanion(')
          ..write('id: $id, ')
          ..write('gameSessionId: $gameSessionId, ')
          ..write('totalScore: $totalScore, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundTableTable extends RoundTable
    with TableInfo<$RoundTableTable, RoundTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameSessionIdMeta = const VerificationMeta(
    'gameSessionId',
  );
  @override
  late final GeneratedColumn<String> gameSessionId = GeneratedColumn<String>(
    'game_session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_session_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roundNumberMeta = const VerificationMeta(
    'roundNumber',
  );
  @override
  late final GeneratedColumn<int> roundNumber = GeneratedColumn<int>(
    'round_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caboPlayerIndexMeta = const VerificationMeta(
    'caboPlayerIndex',
  );
  @override
  late final GeneratedColumn<int> caboPlayerIndex = GeneratedColumn<int>(
    'cabo_player_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kamikazePlayerIndexMeta =
      const VerificationMeta('kamikazePlayerIndex');
  @override
  late final GeneratedColumn<int> kamikazePlayerIndex = GeneratedColumn<int>(
    'kamikaze_player_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gameSessionId,
    roundNumber,
    caboPlayerIndex,
    kamikazePlayerIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'round_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoundTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_session_id')) {
      context.handle(
        _gameSessionIdMeta,
        gameSessionId.isAcceptableOrUnknown(
          data['game_session_id']!,
          _gameSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gameSessionIdMeta);
    }
    if (data.containsKey('round_number')) {
      context.handle(
        _roundNumberMeta,
        roundNumber.isAcceptableOrUnknown(
          data['round_number']!,
          _roundNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundNumberMeta);
    }
    if (data.containsKey('cabo_player_index')) {
      context.handle(
        _caboPlayerIndexMeta,
        caboPlayerIndex.isAcceptableOrUnknown(
          data['cabo_player_index']!,
          _caboPlayerIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caboPlayerIndexMeta);
    }
    if (data.containsKey('kamikaze_player_index')) {
      context.handle(
        _kamikazePlayerIndexMeta,
        kamikazePlayerIndex.isAcceptableOrUnknown(
          data['kamikaze_player_index']!,
          _kamikazePlayerIndexMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoundTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_session_id'],
      )!,
      roundNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_number'],
      )!,
      caboPlayerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cabo_player_index'],
      )!,
      kamikazePlayerIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kamikaze_player_index'],
      ),
    );
  }

  @override
  $RoundTableTable createAlias(String alias) {
    return $RoundTableTable(attachedDatabase, alias);
  }
}

class RoundTableData extends DataClass implements Insertable<RoundTableData> {
  final String id;
  final String gameSessionId;
  final int roundNumber;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  const RoundTableData({
    required this.id,
    required this.gameSessionId,
    required this.roundNumber,
    required this.caboPlayerIndex,
    this.kamikazePlayerIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_session_id'] = Variable<String>(gameSessionId);
    map['round_number'] = Variable<int>(roundNumber);
    map['cabo_player_index'] = Variable<int>(caboPlayerIndex);
    if (!nullToAbsent || kamikazePlayerIndex != null) {
      map['kamikaze_player_index'] = Variable<int>(kamikazePlayerIndex);
    }
    return map;
  }

  RoundTableCompanion toCompanion(bool nullToAbsent) {
    return RoundTableCompanion(
      id: Value(id),
      gameSessionId: Value(gameSessionId),
      roundNumber: Value(roundNumber),
      caboPlayerIndex: Value(caboPlayerIndex),
      kamikazePlayerIndex: kamikazePlayerIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(kamikazePlayerIndex),
    );
  }

  factory RoundTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundTableData(
      id: serializer.fromJson<String>(json['id']),
      gameSessionId: serializer.fromJson<String>(json['gameSessionId']),
      roundNumber: serializer.fromJson<int>(json['roundNumber']),
      caboPlayerIndex: serializer.fromJson<int>(json['caboPlayerIndex']),
      kamikazePlayerIndex: serializer.fromJson<int?>(
        json['kamikazePlayerIndex'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameSessionId': serializer.toJson<String>(gameSessionId),
      'roundNumber': serializer.toJson<int>(roundNumber),
      'caboPlayerIndex': serializer.toJson<int>(caboPlayerIndex),
      'kamikazePlayerIndex': serializer.toJson<int?>(kamikazePlayerIndex),
    };
  }

  RoundTableData copyWith({
    String? id,
    String? gameSessionId,
    int? roundNumber,
    int? caboPlayerIndex,
    Value<int?> kamikazePlayerIndex = const Value.absent(),
  }) => RoundTableData(
    id: id ?? this.id,
    gameSessionId: gameSessionId ?? this.gameSessionId,
    roundNumber: roundNumber ?? this.roundNumber,
    caboPlayerIndex: caboPlayerIndex ?? this.caboPlayerIndex,
    kamikazePlayerIndex: kamikazePlayerIndex.present
        ? kamikazePlayerIndex.value
        : this.kamikazePlayerIndex,
  );
  RoundTableData copyWithCompanion(RoundTableCompanion data) {
    return RoundTableData(
      id: data.id.present ? data.id.value : this.id,
      gameSessionId: data.gameSessionId.present
          ? data.gameSessionId.value
          : this.gameSessionId,
      roundNumber: data.roundNumber.present
          ? data.roundNumber.value
          : this.roundNumber,
      caboPlayerIndex: data.caboPlayerIndex.present
          ? data.caboPlayerIndex.value
          : this.caboPlayerIndex,
      kamikazePlayerIndex: data.kamikazePlayerIndex.present
          ? data.kamikazePlayerIndex.value
          : this.kamikazePlayerIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundTableData(')
          ..write('id: $id, ')
          ..write('gameSessionId: $gameSessionId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('caboPlayerIndex: $caboPlayerIndex, ')
          ..write('kamikazePlayerIndex: $kamikazePlayerIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gameSessionId,
    roundNumber,
    caboPlayerIndex,
    kamikazePlayerIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundTableData &&
          other.id == this.id &&
          other.gameSessionId == this.gameSessionId &&
          other.roundNumber == this.roundNumber &&
          other.caboPlayerIndex == this.caboPlayerIndex &&
          other.kamikazePlayerIndex == this.kamikazePlayerIndex);
}

class RoundTableCompanion extends UpdateCompanion<RoundTableData> {
  final Value<String> id;
  final Value<String> gameSessionId;
  final Value<int> roundNumber;
  final Value<int> caboPlayerIndex;
  final Value<int?> kamikazePlayerIndex;
  final Value<int> rowid;
  const RoundTableCompanion({
    this.id = const Value.absent(),
    this.gameSessionId = const Value.absent(),
    this.roundNumber = const Value.absent(),
    this.caboPlayerIndex = const Value.absent(),
    this.kamikazePlayerIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundTableCompanion.insert({
    required String id,
    required String gameSessionId,
    required int roundNumber,
    required int caboPlayerIndex,
    this.kamikazePlayerIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameSessionId = Value(gameSessionId),
       roundNumber = Value(roundNumber),
       caboPlayerIndex = Value(caboPlayerIndex);
  static Insertable<RoundTableData> custom({
    Expression<String>? id,
    Expression<String>? gameSessionId,
    Expression<int>? roundNumber,
    Expression<int>? caboPlayerIndex,
    Expression<int>? kamikazePlayerIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameSessionId != null) 'game_session_id': gameSessionId,
      if (roundNumber != null) 'round_number': roundNumber,
      if (caboPlayerIndex != null) 'cabo_player_index': caboPlayerIndex,
      if (kamikazePlayerIndex != null)
        'kamikaze_player_index': kamikazePlayerIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundTableCompanion copyWith({
    Value<String>? id,
    Value<String>? gameSessionId,
    Value<int>? roundNumber,
    Value<int>? caboPlayerIndex,
    Value<int?>? kamikazePlayerIndex,
    Value<int>? rowid,
  }) {
    return RoundTableCompanion(
      id: id ?? this.id,
      gameSessionId: gameSessionId ?? this.gameSessionId,
      roundNumber: roundNumber ?? this.roundNumber,
      caboPlayerIndex: caboPlayerIndex ?? this.caboPlayerIndex,
      kamikazePlayerIndex: kamikazePlayerIndex ?? this.kamikazePlayerIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameSessionId.present) {
      map['game_session_id'] = Variable<String>(gameSessionId.value);
    }
    if (roundNumber.present) {
      map['round_number'] = Variable<int>(roundNumber.value);
    }
    if (caboPlayerIndex.present) {
      map['cabo_player_index'] = Variable<int>(caboPlayerIndex.value);
    }
    if (kamikazePlayerIndex.present) {
      map['kamikaze_player_index'] = Variable<int>(kamikazePlayerIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundTableCompanion(')
          ..write('id: $id, ')
          ..write('gameSessionId: $gameSessionId, ')
          ..write('roundNumber: $roundNumber, ')
          ..write('caboPlayerIndex: $caboPlayerIndex, ')
          ..write('kamikazePlayerIndex: $kamikazePlayerIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoundScoreTableTable extends RoundScoreTable
    with TableInfo<$RoundScoreTableTable, RoundScoreTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoundScoreTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roundIdMeta = const VerificationMeta(
    'roundId',
  );
  @override
  late final GeneratedColumn<String> roundId = GeneratedColumn<String>(
    'round_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES round_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreUpdateMeta = const VerificationMeta(
    'scoreUpdate',
  );
  @override
  late final GeneratedColumn<int> scoreUpdate = GeneratedColumn<int>(
    'score_update',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [roundId, playerId, score, scoreUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'round_score_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoundScoreTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('round_id')) {
      context.handle(
        _roundIdMeta,
        roundId.isAcceptableOrUnknown(data['round_id']!, _roundIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roundIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('score_update')) {
      context.handle(
        _scoreUpdateMeta,
        scoreUpdate.isAcceptableOrUnknown(
          data['score_update']!,
          _scoreUpdateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scoreUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roundId, playerId};
  @override
  RoundScoreTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoundScoreTableData(
      roundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}round_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      scoreUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_update'],
      )!,
    );
  }

  @override
  $RoundScoreTableTable createAlias(String alias) {
    return $RoundScoreTableTable(attachedDatabase, alias);
  }
}

class RoundScoreTableData extends DataClass
    implements Insertable<RoundScoreTableData> {
  final String roundId;
  final String playerId;
  final int score;
  final int scoreUpdate;
  const RoundScoreTableData({
    required this.roundId,
    required this.playerId,
    required this.score,
    required this.scoreUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['round_id'] = Variable<String>(roundId);
    map['player_id'] = Variable<String>(playerId);
    map['score'] = Variable<int>(score);
    map['score_update'] = Variable<int>(scoreUpdate);
    return map;
  }

  RoundScoreTableCompanion toCompanion(bool nullToAbsent) {
    return RoundScoreTableCompanion(
      roundId: Value(roundId),
      playerId: Value(playerId),
      score: Value(score),
      scoreUpdate: Value(scoreUpdate),
    );
  }

  factory RoundScoreTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoundScoreTableData(
      roundId: serializer.fromJson<String>(json['roundId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      score: serializer.fromJson<int>(json['score']),
      scoreUpdate: serializer.fromJson<int>(json['scoreUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roundId': serializer.toJson<String>(roundId),
      'playerId': serializer.toJson<String>(playerId),
      'score': serializer.toJson<int>(score),
      'scoreUpdate': serializer.toJson<int>(scoreUpdate),
    };
  }

  RoundScoreTableData copyWith({
    String? roundId,
    String? playerId,
    int? score,
    int? scoreUpdate,
  }) => RoundScoreTableData(
    roundId: roundId ?? this.roundId,
    playerId: playerId ?? this.playerId,
    score: score ?? this.score,
    scoreUpdate: scoreUpdate ?? this.scoreUpdate,
  );
  RoundScoreTableData copyWithCompanion(RoundScoreTableCompanion data) {
    return RoundScoreTableData(
      roundId: data.roundId.present ? data.roundId.value : this.roundId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      score: data.score.present ? data.score.value : this.score,
      scoreUpdate: data.scoreUpdate.present
          ? data.scoreUpdate.value
          : this.scoreUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoundScoreTableData(')
          ..write('roundId: $roundId, ')
          ..write('playerId: $playerId, ')
          ..write('score: $score, ')
          ..write('scoreUpdate: $scoreUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roundId, playerId, score, scoreUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoundScoreTableData &&
          other.roundId == this.roundId &&
          other.playerId == this.playerId &&
          other.score == this.score &&
          other.scoreUpdate == this.scoreUpdate);
}

class RoundScoreTableCompanion extends UpdateCompanion<RoundScoreTableData> {
  final Value<String> roundId;
  final Value<String> playerId;
  final Value<int> score;
  final Value<int> scoreUpdate;
  final Value<int> rowid;
  const RoundScoreTableCompanion({
    this.roundId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.score = const Value.absent(),
    this.scoreUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoundScoreTableCompanion.insert({
    required String roundId,
    required String playerId,
    required int score,
    required int scoreUpdate,
    this.rowid = const Value.absent(),
  }) : roundId = Value(roundId),
       playerId = Value(playerId),
       score = Value(score),
       scoreUpdate = Value(scoreUpdate);
  static Insertable<RoundScoreTableData> custom({
    Expression<String>? roundId,
    Expression<String>? playerId,
    Expression<int>? score,
    Expression<int>? scoreUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roundId != null) 'round_id': roundId,
      if (playerId != null) 'player_id': playerId,
      if (score != null) 'score': score,
      if (scoreUpdate != null) 'score_update': scoreUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoundScoreTableCompanion copyWith({
    Value<String>? roundId,
    Value<String>? playerId,
    Value<int>? score,
    Value<int>? scoreUpdate,
    Value<int>? rowid,
  }) {
    return RoundScoreTableCompanion(
      roundId: roundId ?? this.roundId,
      playerId: playerId ?? this.playerId,
      score: score ?? this.score,
      scoreUpdate: scoreUpdate ?? this.scoreUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roundId.present) {
      map['round_id'] = Variable<String>(roundId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (scoreUpdate.present) {
      map['score_update'] = Variable<int>(scoreUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoundScoreTableCompanion(')
          ..write('roundId: $roundId, ')
          ..write('playerId: $playerId, ')
          ..write('score: $score, ')
          ..write('scoreUpdate: $scoreUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GameSessionTableTable gameSessionTable = $GameSessionTableTable(
    this,
  );
  late final $PlayerTableTable playerTable = $PlayerTableTable(this);
  late final $RoundTableTable roundTable = $RoundTableTable(this);
  late final $RoundScoreTableTable roundScoreTable = $RoundScoreTableTable(
    this,
  );
  late final GameSessionDao gameSessionDao = GameSessionDao(
    this as AppDatabase,
  );
  late final PlayerDao playerDao = PlayerDao(this as AppDatabase);
  late final RoundDao roundDao = RoundDao(this as AppDatabase);
  late final RoundScoresDao roundScoresDao = RoundScoresDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gameSessionTable,
    playerTable,
    roundTable,
    roundScoreTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_session_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_session_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('round_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'round_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('round_score_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'player_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('round_score_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GameSessionTableTableCreateCompanionBuilder =
    GameSessionTableCompanion Function({
      required String id,
      required DateTime createdAt,
      required String gameTitle,
      Value<int?> pointLimit,
      required int caboPenalty,
      required bool isGameFinished,
      Value<int> rowid,
    });
typedef $$GameSessionTableTableUpdateCompanionBuilder =
    GameSessionTableCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> gameTitle,
      Value<int?> pointLimit,
      Value<int> caboPenalty,
      Value<bool> isGameFinished,
      Value<int> rowid,
    });

final class $$GameSessionTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GameSessionTableTable,
          GameSessionTableData
        > {
  $$GameSessionTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PlayerTableTable, List<PlayerTableData>>
  _playerTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerTable,
    aliasName: 'game_session_table__id__player_table__game_session_id',
  );

  $$PlayerTableTableProcessedTableManager get playerTableRefs {
    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.gameSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_playerTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoundTableTable, List<RoundTableData>>
  _roundTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundTable,
    aliasName: 'game_session_table__id__round_table__game_session_id',
  );

  $$RoundTableTableProcessedTableManager get roundTableRefs {
    final manager = $$RoundTableTableTableManager(
      $_db,
      $_db.roundTable,
    ).filter((f) => f.gameSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roundTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GameSessionTableTableFilterComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameTitle => $composableBuilder(
    column: $table.gameTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playerTableRefs(
    Expression<bool> Function($$PlayerTableTableFilterComposer f) f,
  ) {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.gameSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roundTableRefs(
    Expression<bool> Function($$RoundTableTableFilterComposer f) f,
  ) {
    final $$RoundTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundTable,
      getReferencedColumn: (t) => t.gameSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundTableTableFilterComposer(
            $db: $db,
            $table: $db.roundTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameSessionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameTitle => $composableBuilder(
    column: $table.gameTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GameSessionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameSessionTableTable> {
  $$GameSessionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get gameTitle =>
      $composableBuilder(column: $table.gameTitle, builder: (column) => column);

  GeneratedColumn<int> get pointLimit => $composableBuilder(
    column: $table.pointLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caboPenalty => $composableBuilder(
    column: $table.caboPenalty,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGameFinished => $composableBuilder(
    column: $table.isGameFinished,
    builder: (column) => column,
  );

  Expression<T> playerTableRefs<T extends Object>(
    Expression<T> Function($$PlayerTableTableAnnotationComposer a) f,
  ) {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.gameSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roundTableRefs<T extends Object>(
    Expression<T> Function($$RoundTableTableAnnotationComposer a) f,
  ) {
    final $$RoundTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundTable,
      getReferencedColumn: (t) => t.gameSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GameSessionTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameSessionTableTable,
          GameSessionTableData,
          $$GameSessionTableTableFilterComposer,
          $$GameSessionTableTableOrderingComposer,
          $$GameSessionTableTableAnnotationComposer,
          $$GameSessionTableTableCreateCompanionBuilder,
          $$GameSessionTableTableUpdateCompanionBuilder,
          (GameSessionTableData, $$GameSessionTableTableReferences),
          GameSessionTableData,
          PrefetchHooks Function({bool playerTableRefs, bool roundTableRefs})
        > {
  $$GameSessionTableTableTableManager(
    _$AppDatabase db,
    $GameSessionTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameSessionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameSessionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameSessionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> gameTitle = const Value.absent(),
                Value<int?> pointLimit = const Value.absent(),
                Value<int> caboPenalty = const Value.absent(),
                Value<bool> isGameFinished = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameSessionTableCompanion(
                id: id,
                createdAt: createdAt,
                gameTitle: gameTitle,
                pointLimit: pointLimit,
                caboPenalty: caboPenalty,
                isGameFinished: isGameFinished,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String gameTitle,
                Value<int?> pointLimit = const Value.absent(),
                required int caboPenalty,
                required bool isGameFinished,
                Value<int> rowid = const Value.absent(),
              }) => GameSessionTableCompanion.insert(
                id: id,
                createdAt: createdAt,
                gameTitle: gameTitle,
                pointLimit: pointLimit,
                caboPenalty: caboPenalty,
                isGameFinished: isGameFinished,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GameSessionTableTable, GameSessionTableData>(
                    table,
                  ),
                  $$GameSessionTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({playerTableRefs = false, roundTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playerTableRefs) db.playerTable,
                    if (roundTableRefs) db.roundTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playerTableRefs)
                        await $_getPrefetchedDataByColumns<
                          GameSessionTableData,
                          $GameSessionTableTable,
                          PlayerTableData,
                          $PlayerTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$GameSessionTableTableReferences
                              ._playerTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameSessionTableTableReferences(
                                db,
                                table,
                                p0,
                              ).playerTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'game_session_id',
                          typedResults: items,
                        ),
                      if (roundTableRefs)
                        await $_getPrefetchedDataByColumns<
                          GameSessionTableData,
                          $GameSessionTableTable,
                          RoundTableData,
                          $RoundTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$GameSessionTableTableReferences
                              ._roundTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameSessionTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'game_session_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GameSessionTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameSessionTableTable,
      GameSessionTableData,
      $$GameSessionTableTableFilterComposer,
      $$GameSessionTableTableOrderingComposer,
      $$GameSessionTableTableAnnotationComposer,
      $$GameSessionTableTableCreateCompanionBuilder,
      $$GameSessionTableTableUpdateCompanionBuilder,
      (GameSessionTableData, $$GameSessionTableTableReferences),
      GameSessionTableData,
      PrefetchHooks Function({bool playerTableRefs, bool roundTableRefs})
    >;
typedef $$PlayerTableTableCreateCompanionBuilder =
    PlayerTableCompanion Function({
      required String id,
      required String gameSessionId,
      required int totalScore,
      required int position,
      required String name,
      Value<int> rowid,
    });
typedef $$PlayerTableTableUpdateCompanionBuilder =
    PlayerTableCompanion Function({
      Value<String> id,
      Value<String> gameSessionId,
      Value<int> totalScore,
      Value<int> position,
      Value<String> name,
      Value<int> rowid,
    });

final class $$PlayerTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerTableTable, PlayerTableData> {
  $$PlayerTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _gameSessionIdTable(_$AppDatabase db) => db
      .gameSessionTable
      .createAlias('player_table__game_session_id__game_session_table__id');

  $$GameSessionTableTableProcessedTableManager get gameSessionId {
    final $_column = $_itemColumn<String>('game_session_id')!;

    final manager = $$GameSessionTableTableTableManager(
      $_db,
      $_db.gameSessionTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoundScoreTableTable, List<RoundScoreTableData>>
  _roundScoreTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundScoreTable,
    aliasName: 'player_table__id__round_score_table__player_id',
  );

  $$RoundScoreTableTableProcessedTableManager get roundScoreTableRefs {
    final manager = $$RoundScoreTableTableTableManager(
      $_db,
      $_db.roundScoreTable,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _roundScoreTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayerTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableFilterComposer({
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

  ColumnFilters<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$GameSessionTableTableFilterComposer get gameSessionId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableFilterComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roundScoreTableRefs(
    Expression<bool> Function($$RoundScoreTableTableFilterComposer f) f,
  ) {
    final $$RoundScoreTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundScoreTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoreTableTableFilterComposer(
            $db: $db,
            $table: $db.roundScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableOrderingComposer({
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

  ColumnOrderings<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameSessionTableTableOrderingComposer get gameSessionId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerTableTable> {
  $$PlayerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$GameSessionTableTableAnnotationComposer get gameSessionId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roundScoreTableRefs<T extends Object>(
    Expression<T> Function($$RoundScoreTableTableAnnotationComposer a) f,
  ) {
    final $$RoundScoreTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundScoreTable,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoreTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerTableTable,
          PlayerTableData,
          $$PlayerTableTableFilterComposer,
          $$PlayerTableTableOrderingComposer,
          $$PlayerTableTableAnnotationComposer,
          $$PlayerTableTableCreateCompanionBuilder,
          $$PlayerTableTableUpdateCompanionBuilder,
          (PlayerTableData, $$PlayerTableTableReferences),
          PlayerTableData,
          PrefetchHooks Function({bool gameSessionId, bool roundScoreTableRefs})
        > {
  $$PlayerTableTableTableManager(_$AppDatabase db, $PlayerTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gameSessionId = const Value.absent(),
                Value<int> totalScore = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerTableCompanion(
                id: id,
                gameSessionId: gameSessionId,
                totalScore: totalScore,
                position: position,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gameSessionId,
                required int totalScore,
                required int position,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => PlayerTableCompanion.insert(
                id: id,
                gameSessionId: gameSessionId,
                totalScore: totalScore,
                position: position,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlayerTableTable, PlayerTableData>(table),
                  $$PlayerTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gameSessionId = false, roundScoreTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roundScoreTableRefs) db.roundScoreTable,
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
                        if (gameSessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameSessionId,
                            referencedTable: $$PlayerTableTableReferences
                                ._gameSessionIdTable(db),
                            referencedColumn: $$PlayerTableTableReferences
                                ._gameSessionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roundScoreTableRefs)
                        await $_getPrefetchedDataByColumns<
                          PlayerTableData,
                          $PlayerTableTable,
                          RoundScoreTableData,
                          $RoundScoreTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerTableTableReferences
                              ._roundScoreTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundScoreTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'player_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayerTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerTableTable,
      PlayerTableData,
      $$PlayerTableTableFilterComposer,
      $$PlayerTableTableOrderingComposer,
      $$PlayerTableTableAnnotationComposer,
      $$PlayerTableTableCreateCompanionBuilder,
      $$PlayerTableTableUpdateCompanionBuilder,
      (PlayerTableData, $$PlayerTableTableReferences),
      PlayerTableData,
      PrefetchHooks Function({bool gameSessionId, bool roundScoreTableRefs})
    >;
typedef $$RoundTableTableCreateCompanionBuilder = RoundTableCompanion Function({
  required String id,
  required String gameSessionId,
  required int roundNumber,
  required int caboPlayerIndex,
  Value<int?> kamikazePlayerIndex,
  Value<int> rowid,
});
typedef $$RoundTableTableUpdateCompanionBuilder = RoundTableCompanion Function({
  Value<String> id,
  Value<String> gameSessionId,
  Value<int> roundNumber,
  Value<int> caboPlayerIndex,
  Value<int?> kamikazePlayerIndex,
  Value<int> rowid,
});

final class $$RoundTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoundTableTable, RoundTableData> {
  $$RoundTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameSessionTableTable _gameSessionIdTable(_$AppDatabase db) => db
      .gameSessionTable
      .createAlias('round_table__game_session_id__game_session_table__id');

  $$GameSessionTableTableProcessedTableManager get gameSessionId {
    final $_column = $_itemColumn<String>('game_session_id')!;

    final manager = $$GameSessionTableTableTableManager(
      $_db,
      $_db.gameSessionTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoundScoreTableTable, List<RoundScoreTableData>>
  _roundScoreTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roundScoreTable,
    aliasName: 'round_table__id__round_score_table__round_id',
  );

  $$RoundScoreTableTableProcessedTableManager get roundScoreTableRefs {
    final manager = $$RoundScoreTableTableTableManager(
      $_db,
      $_db.roundScoreTable,
    ).filter((f) => f.roundId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _roundScoreTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoundTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoundTableTable> {
  $$RoundTableTableFilterComposer({
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

  ColumnFilters<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$GameSessionTableTableFilterComposer get gameSessionId {
    final $$GameSessionTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableFilterComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roundScoreTableRefs(
    Expression<bool> Function($$RoundScoreTableTableFilterComposer f) f,
  ) {
    final $$RoundScoreTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundScoreTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoreTableTableFilterComposer(
            $db: $db,
            $table: $db.roundScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundTableTable> {
  $$RoundTableTableOrderingComposer({
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

  ColumnOrderings<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameSessionTableTableOrderingComposer get gameSessionId {
    final $$GameSessionTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableOrderingComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundTableTable> {
  $$RoundTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get roundNumber => $composableBuilder(
    column: $table.roundNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caboPlayerIndex => $composableBuilder(
    column: $table.caboPlayerIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kamikazePlayerIndex => $composableBuilder(
    column: $table.kamikazePlayerIndex,
    builder: (column) => column,
  );

  $$GameSessionTableTableAnnotationComposer get gameSessionId {
    final $$GameSessionTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameSessionId,
      referencedTable: $db.gameSessionTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameSessionTableTableAnnotationComposer(
            $db: $db,
            $table: $db.gameSessionTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roundScoreTableRefs<T extends Object>(
    Expression<T> Function($$RoundScoreTableTableAnnotationComposer a) f,
  ) {
    final $$RoundScoreTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roundScoreTable,
      getReferencedColumn: (t) => t.roundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundScoreTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundScoreTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoundTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundTableTable,
          RoundTableData,
          $$RoundTableTableFilterComposer,
          $$RoundTableTableOrderingComposer,
          $$RoundTableTableAnnotationComposer,
          $$RoundTableTableCreateCompanionBuilder,
          $$RoundTableTableUpdateCompanionBuilder,
          (RoundTableData, $$RoundTableTableReferences),
          RoundTableData,
          PrefetchHooks Function({bool gameSessionId, bool roundScoreTableRefs})
        > {
  $$RoundTableTableTableManager(_$AppDatabase db, $RoundTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gameSessionId = const Value.absent(),
                Value<int> roundNumber = const Value.absent(),
                Value<int> caboPlayerIndex = const Value.absent(),
                Value<int?> kamikazePlayerIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundTableCompanion(
                id: id,
                gameSessionId: gameSessionId,
                roundNumber: roundNumber,
                caboPlayerIndex: caboPlayerIndex,
                kamikazePlayerIndex: kamikazePlayerIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gameSessionId,
                required int roundNumber,
                required int caboPlayerIndex,
                Value<int?> kamikazePlayerIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundTableCompanion.insert(
                id: id,
                gameSessionId: gameSessionId,
                roundNumber: roundNumber,
                caboPlayerIndex: caboPlayerIndex,
                kamikazePlayerIndex: kamikazePlayerIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoundTableTable, RoundTableData>(table),
                  $$RoundTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gameSessionId = false, roundScoreTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roundScoreTableRefs) db.roundScoreTable,
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
                        if (gameSessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameSessionId,
                            referencedTable: $$RoundTableTableReferences
                                ._gameSessionIdTable(db),
                            referencedColumn: $$RoundTableTableReferences
                                ._gameSessionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roundScoreTableRefs)
                        await $_getPrefetchedDataByColumns<
                          RoundTableData,
                          $RoundTableTable,
                          RoundScoreTableData,
                          $RoundScoreTableTable
                        >(
                          currentTable: table,
                          referencedTable: $$RoundTableTableReferences
                              ._roundScoreTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoundTableTableReferences(
                                db,
                                table,
                                p0,
                              ).roundScoreTableRefs,
                          currentColumn: 'id',
                          referencedColumn: 'round_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoundTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundTableTable,
      RoundTableData,
      $$RoundTableTableFilterComposer,
      $$RoundTableTableOrderingComposer,
      $$RoundTableTableAnnotationComposer,
      $$RoundTableTableCreateCompanionBuilder,
      $$RoundTableTableUpdateCompanionBuilder,
      (RoundTableData, $$RoundTableTableReferences),
      RoundTableData,
      PrefetchHooks Function({bool gameSessionId, bool roundScoreTableRefs})
    >;
typedef $$RoundScoreTableTableCreateCompanionBuilder =
    RoundScoreTableCompanion Function({
      required String roundId,
      required String playerId,
      required int score,
      required int scoreUpdate,
      Value<int> rowid,
    });
typedef $$RoundScoreTableTableUpdateCompanionBuilder =
    RoundScoreTableCompanion Function({
      Value<String> roundId,
      Value<String> playerId,
      Value<int> score,
      Value<int> scoreUpdate,
      Value<int> rowid,
    });

final class $$RoundScoreTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RoundScoreTableTable,
          RoundScoreTableData
        > {
  $$RoundScoreTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoundTableTable _roundIdTable(_$AppDatabase db) =>
      db.roundTable.createAlias('round_score_table__round_id__round_table__id');

  $$RoundTableTableProcessedTableManager get roundId {
    final $_column = $_itemColumn<String>('round_id')!;

    final manager = $$RoundTableTableTableManager(
      $_db,
      $_db.roundTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayerTableTable _playerIdTable(_$AppDatabase db) => db.playerTable
      .createAlias('round_score_table__player_id__player_table__id');

  $$PlayerTableTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerTableTableTableManager(
      $_db,
      $_db.playerTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoundScoreTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoundScoreTableTable> {
  $$RoundScoreTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => ColumnFilters(column),
  );

  $$RoundTableTableFilterComposer get roundId {
    final $$RoundTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundTableTableFilterComposer(
            $db: $db,
            $table: $db.roundTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableFilterComposer get playerId {
    final $$PlayerTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableFilterComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoreTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoundScoreTableTable> {
  $$RoundScoreTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoundTableTableOrderingComposer get roundId {
    final $$RoundTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundTableTableOrderingComposer(
            $db: $db,
            $table: $db.roundTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableOrderingComposer get playerId {
    final $$PlayerTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableOrderingComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoreTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoundScoreTableTable> {
  $$RoundScoreTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get scoreUpdate => $composableBuilder(
    column: $table.scoreUpdate,
    builder: (column) => column,
  );

  $$RoundTableTableAnnotationComposer get roundId {
    final $$RoundTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roundId,
      referencedTable: $db.roundTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoundTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roundTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableTableAnnotationComposer get playerId {
    final $$PlayerTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableTableAnnotationComposer(
            $db: $db,
            $table: $db.playerTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoundScoreTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoundScoreTableTable,
          RoundScoreTableData,
          $$RoundScoreTableTableFilterComposer,
          $$RoundScoreTableTableOrderingComposer,
          $$RoundScoreTableTableAnnotationComposer,
          $$RoundScoreTableTableCreateCompanionBuilder,
          $$RoundScoreTableTableUpdateCompanionBuilder,
          (RoundScoreTableData, $$RoundScoreTableTableReferences),
          RoundScoreTableData,
          PrefetchHooks Function({bool roundId, bool playerId})
        > {
  $$RoundScoreTableTableTableManager(
    _$AppDatabase db,
    $RoundScoreTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoundScoreTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoundScoreTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoundScoreTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> roundId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> scoreUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoundScoreTableCompanion(
                roundId: roundId,
                playerId: playerId,
                score: score,
                scoreUpdate: scoreUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String roundId,
                required String playerId,
                required int score,
                required int scoreUpdate,
                Value<int> rowid = const Value.absent(),
              }) => RoundScoreTableCompanion.insert(
                roundId: roundId,
                playerId: playerId,
                score: score,
                scoreUpdate: scoreUpdate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoundScoreTableTable, RoundScoreTableData>(
                    table,
                  ),
                  $$RoundScoreTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roundId = false, playerId = false}) {
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
                    if (roundId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.roundId,
                        referencedTable: $$RoundScoreTableTableReferences
                            ._roundIdTable(db),
                        referencedColumn: $$RoundScoreTableTableReferences
                            ._roundIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (playerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.playerId,
                        referencedTable: $$RoundScoreTableTableReferences
                            ._playerIdTable(db),
                        referencedColumn: $$RoundScoreTableTableReferences
                            ._playerIdTable(db)
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

typedef $$RoundScoreTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoundScoreTableTable,
      RoundScoreTableData,
      $$RoundScoreTableTableFilterComposer,
      $$RoundScoreTableTableOrderingComposer,
      $$RoundScoreTableTableAnnotationComposer,
      $$RoundScoreTableTableCreateCompanionBuilder,
      $$RoundScoreTableTableUpdateCompanionBuilder,
      (RoundScoreTableData, $$RoundScoreTableTableReferences),
      RoundScoreTableData,
      PrefetchHooks Function({bool roundId, bool playerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GameSessionTableTableTableManager get gameSessionTable =>
      $$GameSessionTableTableTableManager(_db, _db.gameSessionTable);
  $$PlayerTableTableTableManager get playerTable =>
      $$PlayerTableTableTableManager(_db, _db.playerTable);
  $$RoundTableTableTableManager get roundTable =>
      $$RoundTableTableTableManager(_db, _db.roundTable);
  $$RoundScoreTableTableTableManager get roundScoreTable =>
      $$RoundScoreTableTableTableManager(_db, _db.roundScoreTable);
}
