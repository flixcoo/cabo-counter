import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase database;
  late GameSession session;
  late GameSessionController controller;
  final testPlayers = [
    Player(
      name: 'Alice',
      totalScore: 0,
      id: '0',
      gameSessionId: 'abc',
      position: 0,
    ),
    Player(
      name: 'Bobby',
      totalScore: 0,
      id: '1',
      gameSessionId: 'abc',
      position: 1,
    ),
    Player(
      name: 'Charlie',
      totalScore: 0,
      id: '2',
      gameSessionId: 'abc',
      position: 2,
    ),
  ];
  final testDate = DateTime(2023, 1, 1);
  const testTitle = 'Test Game';

  setUp(() async {
    database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    session = GameSession(
      id: '1',
      createdAt: testDate,
      title: testTitle,
      players: testPlayers,
      pointLimit: 100,
      caboPenalty: 5,
      isGameFinished: false,
    );
    controller = GameSessionController(session: session, db: database);
    // Persist the session and its players so the round writes triggered by the
    // controller satisfy the foreign key constraints.
    await database.gameSessionDao.addGameSession(session);
  });

  tearDown(() async {
    // Wait for the controller's serialized background writes to finish before
    // closing the database to avoid "database is closed" errors.
    await controller.pendingWrites;
    await database.close();
  });

  group('Initialization & JSON', () {
    test('Initialization', () {
      expect(session.title, testTitle);
      expect(session.players, testPlayers);
      expect(session.getScoresList, [0, 0, 0]);
      expect(session.roundNumber, 1);
      expect(session.isGameFinished, isFalse);
      expect(session.winner, isEmpty);
    });

    test('toJson and fromJson', () {
      // Add some rounds to test serialization
      controller.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      controller.addRoundScoresToList(2, [15, 25, 35], [5, 5, 5], 1);

      final jsonFile = session.toJson();
      final fromJsonSession = GameSession.fromJson(jsonFile);

      expect(fromJsonSession.title, testTitle);
      expect(fromJsonSession.players, testPlayers);
      expect(fromJsonSession.roundList.length, 2);
    });

    test('null values in JSON', () {
      expect(
        () => GameSession.fromJson({
          'createdAt': testDate.toIso8601String(),
          'gameTitle': null, // Invalid
          'players': session.players.map((p) => p.toJson()).toList(),
          'pointLimit': 100,
          'caboPenalty': 50,
          'isPointsLimitEnabled': true,
          'isGameFinished': false,
          'winner': '',
          'roundNumber': 1,
          'playerScores': [0, 0, 0],
          'roundList': [],
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('Helper Functions', () {
    test('roundNumber is correct', () {
      expect(session.roundNumber, 1);
      controller.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      expect(session.roundNumber, 2);
    });

    test('getLowestScoreIndex', () {
      List<int> lowestScoreIndex;

      lowestScoreIndex = controller.testingGetLowestScoreIndex([5, 10, 15]);
      expect(lowestScoreIndex, [0]);

      lowestScoreIndex = controller.testingGetLowestScoreIndex([5, 5, 15]);
      expect(lowestScoreIndex, [0, 1]);

      lowestScoreIndex = controller.testingGetLowestScoreIndex([5, 5, 5]);
      expect(lowestScoreIndex, [0, 1, 2]);
    });
  });

  group('Game Functions', () {
    test('applyKamikaze', () {
      controller.applyKamikaze(1, 0); // Alice has kamikaze
      expect(session.roundList[0].scoreUpdates, [0, 50, 50]);
      expect(session.roundList[0].scores, [0, 0, 0]);
      expect(session.roundList[0].kamikazePlayerIndex, 0);
      expect(session.roundList[0].caboPlayerIndex, 0);
    });

    test('calculateScoredPoints - CABO player has lowest', () {
      controller.calculateScoredPoints(1, [3, 5, 8], 0); // Alice has lowest
      expect(session.roundList[0].scoreUpdates, equals([0, 5, 8]));
    });

    test('calculateScoredPoints - CABO player not lowest', () {
      controller.calculateScoredPoints(1, [5, 3, 8], 0); // Bob has lowest
      expect(session.roundList[0].scoreUpdates, [10, 0, 8]);
    });

    test('addRoundScoresToList', () {
      controller.addRoundScoresToList(1, [3, 5, 8], [0, 5, 8], 0);
      expect(session.roundList.length, 1);
      expect(session.roundList[0].scoreUpdates, [0, 5, 8]);
      expect(session.roundList[0].scores, [3, 5, 8]);
      expect(session.roundList[0].kamikazePlayerIndex, isNull);
      expect(session.roundList[0].caboPlayerIndex, 0);
    });

    test('updatePoints - game not finished', () {
      controller.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      controller.updatePoints();
      expect(session.isGameFinished, isFalse);
    });

    test('updatePoints - game finished', () {
      controller.addRoundScoresToList(1, [101, 20, 30], [101, 20, 30], 0);
      controller.updatePoints();
      expect(session.isGameFinished, isTrue);
    });

    test('_assignPoints', () {
      // Alice said Cabo and has the lowest score
      controller.testingAssignPoints(1, [5, 10, 15], 0, [0]);
      expect(session.roundList[0].scoreUpdates, [0, 10, 15]);

      // Alice said Cabo and has not the lowest score
      controller.testingAssignPoints(1, [5, 10, 15], 0, [1], 0);
      expect(session.roundList[0].scoreUpdates, [10, 0, 15]);

      // Bob and Charlie have the lowest score, Alice said Cabo
      controller.testingAssignPoints(1, [15, 5, 5], 0, [1, 2], 0);
      expect(session.roundList[0].scoreUpdates, [20, 0, 0]);
    });

    test('_sumPoints', () async {
      controller.addRoundScoresToList(1, [10, 20, 30], [10, 20, 30], 0);
      controller.addRoundScoresToList(2, [5, 5, 5], [5, 5, 5], 1);
      controller.testingSumPoints();
      expect(session.getScoresList, [15, 25, 35]);
    });

    test('_checkHundredPointsReached via updatePoints', () {
      controller.addRoundScoresToList(1, [50, 5, 15], [50, 0, 15], 1);
      controller.addRoundScoresToList(2, [50, 5, 15], [50, 0, 15], 1);
      controller.updatePoints();
      expect(session.getScoresList, equals([50, 0, 30]));
    });

    test('_setWinner via updatePoints', () {
      controller.addRoundScoresToList(1, [101, 20, 30], [101, 0, 30], 1);
      controller.updatePoints();

      expect(session.winner.length, 1);
      expect(session.winner.first, 'Bobby'); // Bobby has lowest score (20)
    });
  });
}
