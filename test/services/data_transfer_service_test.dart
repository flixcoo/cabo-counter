import 'dart:convert';

import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameSession gameSession1;
  late GameSession gameSession2;
  late GameSession gameSession3;
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );
    gameSession1 = GameSession(
      id: 'test-game-id-1',
      createdAt: DateTime.now(),
      title: 'Test Game',
      players: [
        Player(gameSessionId: 'test-game-id-1', name: 'player1', position: 0),
        Player(gameSessionId: 'test-game-id-1', name: 'player2', position: 1),
      ],
      pointLimit: 100,
      caboPenalty: 5,
    );

    gameSession2 = GameSession(
      id: 'test-game-id-2',
      createdAt: DateTime.now(),
      title: 'Test Game 2',
      players: [
        Player(
          gameSessionId: 'test-game-id',
          name: 'player3',
          position: 0,
          totalScore: 7,
        ),
        Player(
          gameSessionId: 'test-game-id',
          name: 'player4',
          position: 1,
          totalScore: 5,
        ),
      ],
      pointLimit: 100,
      caboPenalty: 5,
      roundList: [
        Round(
          gameSessionId: 'test-game-id',
          caboPlayerIndex: 0,
          scores: [2, 5],
          scoreUpdates: [0, 5],
        ),
        Round(
          gameSessionId: 'test-game-id',
          caboPlayerIndex: 1,
          scores: [7, 6],
          scoreUpdates: [7, 0],
        ),
      ],
      isGameFinished: true,
    );

    gameSession3 = GameSession(
      id: 'test-game-id-2',
      createdAt: DateTime.now(),
      title: 'Test Game 2',
      players: [
        Player(
          gameSessionId: 'test-game-id',
          name: 'player3',
          position: 0,
          totalScore: 5,
        ),
        Player(
          gameSessionId: 'test-game-id',
          name: 'player4',
          position: 1,
          totalScore: 5,
        ),
        Player(
          gameSessionId: 'test-game-id',
          name: 'player5',
          position: 2,
          totalScore: 5,
        ),
      ],
      roundList: [
        Round(
          gameSessionId: 'test-game-id',
          caboPlayerIndex: 0,
          kamikazePlayerIndex: 0,
          scores: [0, 0, 0],
          scoreUpdates: [0, 50, 50],
        ),
      ],
      pointLimit: 100,
      caboPenalty: 5,
      isGameFinished: true,
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('DataTransferService Tests', () {
    test('Validate single GameSession', () async {
      var jsonString = json.encode(gameSession1.toJson());
      var result = await DataTransferService.validateJsonSchema(
        jsonString,
        false,
      );
      expect(result, isTrue);

      jsonString = json.encode(gameSession2.toJson());
      result = await DataTransferService.validateJsonSchema(jsonString, false);
      expect(result, isTrue);

      jsonString = json.encode(gameSession3.toJson());
      result = await DataTransferService.validateJsonSchema(jsonString, false);
      expect(result, isTrue);
    });

    test('Validate GameSession List', () async {
      final jsonString = [
        gameSession1,
        gameSession2,
        gameSession3,
      ].map((session) => session.toJson()).toList();

      var jsonFile = json.encode(jsonString);
      var result = await DataTransferService.validateJsonSchema(jsonFile, true);
      expect(result, isTrue);
    });

    test('Rejects malformed json', () async {
      // Corrupt the 2nd player
      final gameMap = json.decode(
        json.encode(gameSession2.toJson()),
      ) as Map<String, dynamic>;
      (gameMap['players'] as List)[1] = {'name': 'incomplete'};
      var result = await DataTransferService.validateJsonSchema(
        json.encode(gameMap),
        false,
      );
      expect(result, isFalse);

      // Corrupt the 2n round's scores with a non-integer entry.
      final roundMap = json.decode(
        json.encode(gameSession2.toJson()),
      ) as Map<String, dynamic>;
      ((roundMap['roundList'] as List)[1]['scores'] as List)[1] = 'not-an-int';
      result = await DataTransferService.validateJsonSchema(
        json.encode(roundMap),
        false,
      );
      expect(result, isFalse);
    });

    test('Imports all games if no duplicates exist', () async {
      final result = await DataTransferService.importGameSessionsToDb(
        database,
        [gameSession1, gameSession2],
      );

      expect(result.status, ImportStatus.success);
      expect(result.importedAmount, 2);
      expect(result.duplicates, isEmpty);
      expect(await database.gameSessionDao.getAllGameSessionIds(), {
        gameSession1.id,
        gameSession2.id,
      });
    });

    test('Skips games whose ID already exists locally', () async {
      await database.gameSessionDao.addGameSession(gameSession2);

      final result = await DataTransferService.importGameSessionsToDb(
        database,
        [gameSession1, gameSession3],
      );

      expect(result.status, ImportStatus.duplicatesFound);
      expect(result.importedAmount, 1);
      expect(result.duplicates.map((s) => s.id), [gameSession3.id]);

      // The local game is left untouched.
      final localGame = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession2.id,
      );
      expect(localGame!.players.length, gameSession2.players.length);
      expect(await database.gameSessionDao.getAllGameSessionIds(), {
        gameSession1.id,
        gameSession2.id,
      });
    });

    test('Overwrites local games with duplicates', () async {
      await database.gameSessionDao.addGameSession(gameSession2);

      final result = await DataTransferService.importGameSessionsToDb(
        database,
        [gameSession3],
      );
      expect(result.importedAmount, 0);

      await database.gameSessionDao.replaceGameSessions(result.duplicates);

      final localGame = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession2.id,
      );
      expect(localGame!.players.length, gameSession3.players.length);
      expect(localGame.roundList.length, gameSession3.roundList.length);
      expect(await database.gameSessionDao.getAllGameSessionIds(), {
        gameSession2.id,
      });
    });
  });
}
