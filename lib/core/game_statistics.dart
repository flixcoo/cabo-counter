import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:collection/collection.dart';

/// Calculates the statistics of a game from its [players] and [rounds].
class GameStatistics {
  final List<Player> players;
  final List<Round> rounds;

  GameStatistics({required this.players, required this.rounds})
    : assert(
        rounds.every((round) => round.scores.length == players.length),
        'Every round must contain a score for every player',
      );

  /// Whether every round of the game was a kamikaze round.
  bool get hasOnlyKamikazeRounds =>
      rounds.every((round) => round.kamikazePlayerIndex != null);

  /// Calculates the average card points per round for each player.
  /// Kamikaze rounds are ignored because no card points are entered there.
  List<(String, double)> averagePoints() {
    var values = <(String, double)>[];
    final scoredRounds = rounds.where((r) => r.kamikazePlayerIndex == null);

    for (int i = 0; i < players.length; i++) {
      var allPoints = scoredRounds.map((round) => round.scores[i]).toList();
      var average = allPoints.isEmpty ? 0.0 : allPoints.sum / allPoints.length;
      values.add((players[i].name, average));
    }
    return _sorted(values, descending: false);
  }

  /// Calculates the amount of rounds won for each player.
  List<(String, int)> roundsWon() {
    var values = <(String, int)>[];

    for (int i = 0; i < players.length; i++) {
      var roundsWon = rounds.where((round) => hasWonRound(round, i)).length;
      values.add((players[i].name, roundsWon));
    }
    return _sorted(values);
  }

  /// Calculates the amount of times each player got a cabo penalty.
  List<(String, int)> caboPenalties() {
    var values = <(String, int)>[];

    for (int i = 0; i < players.length; i++) {
      var caboPenalties = rounds
          .where(
            (round) =>
                round.kamikazePlayerIndex == null &&
                round.caboPlayerIndex == i &&
                !hasWonRound(round, i),
          )
          .length;
      values.add((players[i].name, caboPenalties));
    }
    return _sorted(values);
  }

  /// Calculates the longest streak of consecutive rounds won for each player.
  List<(String, int)> longestWinStreak() {
    var values = <(String, int)>[];

    for (int i = 0; i < players.length; i++) {
      int longestStreak = 0;
      int currentStreak = 0;
      for (final round in rounds) {
        if (hasWonRound(round, i)) {
          currentStreak++;
          if (currentStreak > longestStreak) longestStreak = currentStreak;
        } else {
          currentStreak = 0;
        }
      }
      values.add((players[i].name, longestStreak));
    }
    return _sorted(values);
  }

  /// Whether the player at index [i] won the given [round].
  static bool hasWonRound(Round round, int i) {
    // Check if round has a kamikaze player
    if (round.kamikazePlayerIndex != null) {
      return round.kamikazePlayerIndex == i;
    }

    final lowestRoundScore = round.scores.min;
    final hasCaboPlayerWon =
        round.scores[round.caboPlayerIndex] == lowestRoundScore;

    // If cabo player has won
    return hasCaboPlayerWon
        // player has won round if player is cabo player
        ? i == round.caboPlayerIndex
        // else if player has lowest score
        : round.scores[i] == lowestRoundScore;
  }

  /// Sorts the [values] by their value. Uses a stable sort so players with
  /// the same value keep their original order.
  List<(String, T)> _sorted<T extends num>(
    List<(String, T)> values, {
    bool descending = true,
  }) {
    mergeSort(
      values,
      compare: (a, b) =>
          descending ? b.$2.compareTo(a.$2) : a.$2.compareTo(b.$2),
    );
    return values;
  }
}
