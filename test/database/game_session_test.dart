import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late GameSession gameSession;
  late GameSession gameSession2;
  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Player player5;
  late Player player6;
  late Round round1;
  late Round round2;
  late Round round3;
  late Round round4;
  late Round round5;
  late Round round6;

  setUp(() {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        // Recommended for widget tests to avoid test errors.
        closeStreamsSynchronously: true,
      ),
    );
    player1 = Player(
      id: 'player1_id',
      gameSessionId: 'test_game_id',
      name: 'Player 1',
      position: 0,
      totalScore: 0,
    );
    player2 = Player(
      id: 'player2_id',
      gameSessionId: 'test_game_id',
      name: 'Player 2',
      position: 1,
      totalScore: 0,
    );
    player3 = Player(
      id: 'player3_id',
      gameSessionId: 'test_game_id',
      name: 'Player 3',
      position: 2,
      totalScore: 0,
    );
    player4 = Player(
      id: 'player4_id',
      gameSessionId: 'test_game_id2',
      name: 'Player 4',
      position: 0,
      totalScore: 0,
    );
    player5 = Player(
      id: 'player5_id',
      gameSessionId: 'test_game_id2',
      name: 'Player 5',
      position: 1,
      totalScore: 0,
    );
    player6 = Player(
      id: 'player6_id',
      gameSessionId: 'test_game_id2',
      name: 'Player 6',
      position: 2,
      totalScore: 0,
    );
    round1 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 0,
      scores: [5, 7, 10],
      scoreUpdates: [0, 7, 10],
    );
    round2 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 1,
      scores: [2, 4, 4],
      scoreUpdates: [0, 9, 4],
    );
    round3 = Round(
      gameSessionId: 'test_game_id',
      caboPlayerIndex: 1,
      kamikazePlayerIndex: 2,
      scores: [5, 2, 50],
      scoreUpdates: [50, 50, 0],
    );
    round4 = Round(
      gameSessionId: 'test_game_id2',
      caboPlayerIndex: 2,
      scores: [3, 6, 8],
      scoreUpdates: [3, 6, 8],
    );
    round5 = Round(
      gameSessionId: 'test_game_id2',
      caboPlayerIndex: 0,
      scores: [2, 7, 5],
      scoreUpdates: [0, 7, 5],
    );
    round6 = Round(
      gameSessionId: 'test_game_id2',
      caboPlayerIndex: 0,
      scores: [2, 7, 5],
      scoreUpdates: [0, 7, 5],
    );
    gameSession = GameSession(
      id: 'test_game_id',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session',
      pointLimit: 100,
      caboPenalty: 5,
      players: [player1, player2, player3],
      roundList: [round1, round2, round3],
    );
    gameSession2 = GameSession(
      id: 'test_game_id2',
      createdAt: DateTime.now(),
      isGameFinished: false,
      title: 'test game session 2',
      pointLimit: 100,
      caboPenalty: 5,
      players: [player4, player5, player6],
      roundList: [round4, round5, round6],
    );
  });
  tearDown(() async {
    await database.close();
  });

  group('GameSession-Tests', () {
    test('Inserting and fetching a game session works correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      final fetchedSessions = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession.id,
      );

      if (fetchedSessions == null) {
        fail('Fetched game session is null');
      } else {
        expect(fetchedSessions.id, gameSession.id);
        expect(fetchedSessions.title, gameSession.title);
        expect(fetchedSessions.pointLimit, gameSession.pointLimit);
        expect(fetchedSessions.caboPenalty, gameSession.caboPenalty);
        expect(
          fetchedSessions.isPointsLimitEnabled,
          gameSession.isPointsLimitEnabled,
        );
        expect(fetchedSessions.isGameFinished, gameSession.isGameFinished);
        expect(fetchedSessions.winner, gameSession.winner);
        expect(fetchedSessions.roundNumber, gameSession.roundNumber);
        expect(fetchedSessions.players.length, gameSession.players.length);
        expect(fetchedSessions.roundList.length, gameSession.roundList.length);
      }
    });

    test(
      'Inserting and fetching multiple game sessions works correctly',
      () async {
        await database.gameSessionDao.addGameSession(gameSession);
        await database.gameSessionDao.addGameSession(gameSession2);
        final fetchedSessions = await database.gameSessionDao
            .getAllGameSessions();

        final expected = {
          gameSession.id: gameSession,
          gameSession2.id: gameSession2,
        };

        expect(fetchedSessions.length, expected.length);

        for (var session in fetchedSessions) {
          final expectedSession = expected[session.id];
          if (expectedSession == null) {
            fail('Unexpected game session ID: ${session.id}');
          } else {
            expect(session.id, expectedSession.id);
            expect(
              session.createdAt
                  .difference(expectedSession.createdAt)
                  .inMilliseconds
                  .abs(),
              lessThan(1000),
            );
            expect(session.title, expectedSession.title);
            expect(session.pointLimit, expectedSession.pointLimit);
            expect(session.caboPenalty, expectedSession.caboPenalty);
            expect(
              session.isPointsLimitEnabled,
              expectedSession.isPointsLimitEnabled,
            );
            expect(session.isGameFinished, expectedSession.isGameFinished);
            expect(session.winner, expectedSession.winner);
            expect(session.roundNumber, expectedSession.roundNumber);
            expect(session.players.length, expectedSession.players.length);
            for (int i = 0; i < session.players.length; i++) {
              expect(session.players[i].id, expectedSession.players[i].id);
              expect(
                session.players[i].gameSessionId,
                expectedSession.players[i].gameSessionId,
              );
              expect(session.players[i].name, expectedSession.players[i].name);
              expect(
                session.players[i].position,
                expectedSession.players[i].position,
              );
              expect(
                session.players[i].totalScore,
                expectedSession.players[i].totalScore,
              );
            }

            expect(session.roundList.length, expectedSession.roundList.length);
            for (int i = 0; i < session.roundList.length; i++) {
              expect(
                session.roundList[i].gameSessionId,
                expectedSession.roundList[i].gameSessionId,
              );
              expect(
                session.roundList[i].caboPlayerIndex,
                expectedSession.roundList[i].caboPlayerIndex,
              );
              expect(
                session.roundList[i].kamikazePlayerIndex,
                expectedSession.roundList[i].kamikazePlayerIndex,
              );
              expect(
                session.roundList[i].scores,
                expectedSession.roundList[i].scores,
              );
              expect(
                session.roundList[i].scoreUpdates,
                expectedSession.roundList[i].scoreUpdates,
              );
            }
          }
        }
      },
    );

    test('Inserting multiple game sessions works correctly', () async {
      final newSessions = [gameSession, gameSession2];

      await database.gameSessionDao.addGameSessionsAsList(newSessions);

      final fetchedSessions = await database.gameSessionDao
          .getAllGameSessions();

      expect(fetchedSessions.length, newSessions.length);

      // getAllGameSessions doesn't guarantee an order, so match by ID.
      final expected = {for (final s in newSessions) s.id: s};

      for (final session in fetchedSessions) {
        final expectedSession = expected[session.id];
        if (expectedSession == null) {
          fail('Unexpected game session ID: ${session.id}');
        }
        expect(session.title, expectedSession.title);
        expect(session.pointLimit, expectedSession.pointLimit);
        expect(session.caboPenalty, expectedSession.caboPenalty);
        expect(session.isGameFinished, expectedSession.isGameFinished);
        expect(session.players.length, expectedSession.players.length);
        expect(session.roundList.length, expectedSession.roundList.length);
      }
    });

    test('Deleting a game session works correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      var session = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession.id,
      );

      expect(session, isNotNull);

      await database.gameSessionDao.deleteGameSession(
        gameSessionId: gameSession.id,
      );
      final fetchedSessions = await database.gameSessionDao
          .getAllGameSessions();

      expect(fetchedSessions, isEmpty);
    });

    test('Deleting multiple game sessions works correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      await database.gameSessionDao.addGameSession(gameSession2);
      var sessions = await database.gameSessionDao.getAllGameSessions();

      expect(sessions, isNotEmpty);
      expect(sessions.length, 2);

      await database.gameSessionDao.deleteAllGames();
      final fetchedSessions = await database.gameSessionDao
          .getAllGameSessions();

      expect(fetchedSessions, isEmpty);
    });

    test('Updating game finish status works correctly', () async {
      await database.gameSessionDao.addGameSession(gameSession);
      await database.gameSessionDao.updateGameFinished(
        gameId: gameSession.id,
        isFinished: true,
      );
      var updatedSession = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession.id,
      );

      expect(updatedSession, isNotNull);
      expect(updatedSession!.isGameFinished, isTrue);

      await database.gameSessionDao.updateGameFinished(
        gameId: gameSession.id,
        isFinished: false,
      );
      updatedSession = await database.gameSessionDao.getGameSessionById(
        gameSessionId: gameSession.id,
      );
      expect(updatedSession, isNotNull);
      expect(updatedSession!.isGameFinished, isFalse);
    });
  });
}
