import 'package:cabo_counter/core/game_statistics.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:test/test.dart';

void main() {
  final players = [
    Player(name: 'Alice', gameSessionId: 'g', position: 0),
    Player(name: 'Bobby', gameSessionId: 'g', position: 1),
    Player(name: 'Charlie', gameSessionId: 'g', position: 2),
  ];

  /// Creates a regular round. The score updates are not relevant for the
  /// statistics, so the raw scores are used.
  Round round(List<int> scores, {required int cabo}) => Round(
    gameSessionId: 'session-id',
    caboPlayerIndex: cabo,
    scores: scores,
    scoreUpdates: scores,
  );

  /// Creates a kamikaze round like the controller does: all scores are 0 and
  /// the cabo player index is set to 0.
  Round kamikaze(int kamikazePlayer) => Round(
    gameSessionId: 'session-id',
    caboPlayerIndex: 0,
    kamikazePlayerIndex: kamikazePlayer,
    scores: [0, 0, 0],
    scoreUpdates: [for (int i = 0; i < 3; i++) i == kamikazePlayer ? 0 : 50],
  );

  GameStatistics statistics(List<Round> rounds) =>
      GameStatistics(players: players, rounds: rounds);

  /// Returns the indices of all players who won the [round].
  List<int> winners(Round round) => [
    for (int i = 0; i < players.length; i++)
      if (GameStatistics.hasWonRound(round, i)) i,
  ];

  group('hasWonRound', () {
    test('cabo player has the lowest score', () {
      expect(winners(round([3, 5, 8], cabo: 0)), [0]);
    });

    test('cabo player shares the lowest score', () {
      // Only the cabo player wins, the other player gets their points
      expect(winners(round([3, 3, 8], cabo: 0)), [0]);
      expect(winners(round([0, 0, 8], cabo: 0)), [0]);
    });

    test('another player has the lowest score', () {
      expect(winners(round([5, 3, 8], cabo: 0)), [1]);
    });

    test('two other players share the lowest score', () {
      expect(winners(round([8, 3, 3], cabo: 0)), [1, 2]);
    });

    test('kamikaze player wins regardless of the cabo player index', () {
      expect(winners(kamikaze(1)), [1]);
      expect(winners(kamikaze(0)), [0]);
    });
  });

  group('roundsWon', () {
    test('counts the won rounds of every player', () {
      final result = statistics([
        round([3, 5, 8], cabo: 0), // Alice
        round([5, 3, 8], cabo: 0), // Bobby
        round([8, 3, 3], cabo: 0), // Bobby & Charlie
        kamikaze(2), // Charlie
      ]).roundsWon();

      expect(result, [('Bobby', 2), ('Charlie', 2), ('Alice', 1)]);
    });

    test('players with the same value keep their order', () {
      final result = statistics([
        round([5, 3, 8], cabo: 1), // Bobby
        round([3, 5, 8], cabo: 0), // Alice
      ]).roundsWon();

      expect(result, [('Alice', 1), ('Bobby', 1), ('Charlie', 0)]);
    });
  });

  group('caboPenalties', () {
    test('counts rounds where the cabo player did not win', () {
      final result = statistics([
        round([5, 3, 8], cabo: 0), // Alice penalty
        round([9, 3, 8], cabo: 0), // Alice penalty
        round([3, 5, 8], cabo: 0), // Alice won, no penalty
        round([8, 3, 1], cabo: 1), // Bobby penalty
      ]).caboPenalties();

      expect(result, [('Alice', 2), ('Bobby', 1), ('Charlie', 0)]);
    });

    test('no penalty if the cabo player shares the lowest score', () {
      final result = statistics([
        round([3, 3, 8], cabo: 0),
      ]).caboPenalties();

      expect(result.every((value) => value.$2 == 0), isTrue);
    });

    test('kamikaze rounds never count as penalty', () {
      // The cabo player index of kamikaze rounds is always 0
      final result = statistics([kamikaze(1), kamikaze(2)]).caboPenalties();

      expect(result.every((value) => value.$2 == 0), isTrue);
    });
  });

  group('averagePoints', () {
    test('calculates the average card points, lowest first', () {
      final result = statistics([
        round([10, 4, 30], cabo: 1),
        round([20, 6, 0], cabo: 2),
      ]).averagePoints();

      expect(result, [('Bobby', 5.0), ('Alice', 15.0), ('Charlie', 15.0)]);
    });

    test('ignores kamikaze rounds', () {
      final stats = statistics([
        round([10, 4, 30], cabo: 1),
        kamikaze(0),
        round([20, 6, 0], cabo: 2),
      ]);

      // Including the kamikaze round, the averages would be 10, 3.3 and 10
      expect(stats.hasOnlyKamikazeRounds, isFalse);
      expect(stats.averagePoints(), [
        ('Bobby', 5.0),
        ('Alice', 15.0),
        ('Charlie', 15.0),
      ]);
    });

    test('only kamikaze rounds result in 0 for everyone', () {
      final stats = statistics([kamikaze(0), kamikaze(1)]);

      expect(stats.hasOnlyKamikazeRounds, isTrue);
      expect(stats.averagePoints().every((value) => value.$2 == 0), isTrue);
    });
  });

  group('longestWinStreak', () {
    test('finds the longest streak of consecutive wins', () {
      final result = statistics([
        round([3, 5, 8], cabo: 0), // Alice
        round([3, 5, 8], cabo: 0), // Alice
        round([5, 3, 8], cabo: 1), // Bobby
        round([3, 5, 8], cabo: 0), // Alice
        round([3, 5, 8], cabo: 0), // Alice
        round([3, 5, 8], cabo: 0), // Alice
      ]).longestWinStreak();

      expect(result, [('Alice', 3), ('Bobby', 1), ('Charlie', 0)]);
    });

    test('kamikaze and shared wins continue a streak', () {
      final result = statistics([
        round([8, 3, 3], cabo: 0), // Bobby & Charlie
        kamikaze(2), // Charlie
        round([8, 5, 3], cabo: 0), // Charlie
      ]).longestWinStreak();

      expect(result, [('Charlie', 3), ('Bobby', 1), ('Alice', 0)]);
    });

    test('a lost round resets the streak', () {
      final result = statistics([
        round([3, 5, 8], cabo: 0), // Alice
        round([3, 5, 8], cabo: 0), // Alice
        round([5, 3, 8], cabo: 0), // Bobby
        round([3, 5, 8], cabo: 0), // Alice
      ]).longestWinStreak();

      expect(result.first, ('Alice', 2));
    });
  });
}
