import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:test/test.dart';

void main() {
  late GameSession gameSession1;
  late GameSession gameSession2;
  late GameSession gameSession3;

  setUp(() {
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
          scores: [2, 5, 5],
          scoreUpdates: [0, 5, 5],
        ),
        Round(
          gameSessionId: 'test-game-id',
          caboPlayerIndex: 1,
          scores: [7, 6, 6],
          scoreUpdates: [7, 0, 0],
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
      pointLimit: 100,
      caboPenalty: 5,

      isGameFinished: true,
    );
  });

  group('GameSession Test', () {});
  test('toJson()/fromJson() works correctly', () {
    var jsonMap = gameSession2.toJson();
    var copy = GameSession.fromJson(jsonMap);
    expect(copy, gameSession2);
  });

  test('getScoresList works correctly', () {
    var scoresList = gameSession1.getScoresList;
    expect(scoresList, [0, 0]);

    scoresList = gameSession2.getScoresList;
    expect(scoresList, [7, 5]);
  });

  test('getPlayerNamesList works correctly', () {
    var namesList = gameSession1.getPlayerNamesList;
    expect(namesList, ['player1', 'player2']);

    namesList = gameSession2.getPlayerNamesList;
    expect(namesList, ['player3', 'player4']);

    namesList = gameSession3.getPlayerNamesList;
    expect(namesList, ['player3', 'player4', 'player5']);
  });

  test('winner works correctly', () {
    var winner = gameSession1.winner;
    expect(winner, isEmpty);

    winner = gameSession2.winner;
    expect(winner.length, 1);
    expect(winner.first, 'player4');
    expect(gameSession2.winnerAsString, 'player4');

    winner = gameSession3.winner;
    expect(winner.length, 3);
    expect(winner, containsAll(['player3', 'player4', 'player5']));
    expect(gameSession3.winnerAsString, 'player3, player4 & player5');
  });
}
