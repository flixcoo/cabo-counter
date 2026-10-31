import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

/// Controller for a single [GameSession].
class GameSessionController extends ChangeNotifier {
  final GameSession session;
  final AppDatabase db;

  GameSessionController({required this.session, required this.db});

  /// Serializes all fire-and-forget database writes so operations that touch
  /// the same round (e.g. an insert immediately followed by a replace) cannot
  /// interleave and violate foreign key constraints.
  Future<void> _writeQueue = Future<void>.value();

  /// Completes once all queued database writes have finished. Mainly useful for
  /// tests that need to await the controller's background persistence.
  Future<void> get pendingWrites => _writeQueue;

  void _enqueueWrite(Future<void> Function() operation) {
    _writeQueue = _writeQueue.then((_) => operation()).catchError((
      Object error,
      StackTrace stackTrace,
    ) {
      debugPrint('GameSessionController database write failed: $error');
    });
  }

  /* Read-only delegation to the session */

  String get id => session.id;

  DateTime get createdAt => session.createdAt;

  String get title => session.title;

  List<Player> get players => session.players;

  int? get pointLimit => session.pointLimit;

  int get caboPenalty => session.caboPenalty;

  bool get isPointsLimitEnabled => session.isPointsLimitEnabled;

  bool get isGameFinished => session.isGameFinished;

  List<String> get winner => session.winner;

  int get roundNumber => session.roundNumber;

  List<Round> get roundList => session.roundList;

  List<int> getPlayerScoresAsList() => session.getScoresList;

  List<String> getPlayerNamesAsList() => session.getPlayerNamesList;

  /// Assigns the kamikaze points to all players except the kamikaze player.
  /// Every other player receives half of the session's point limit, or 50
  /// points in unlimited mode. The kamikaze player receives 0 points.
  void applyKamikaze(int roundNum, int kamikazePlayerIndex) {
    assert(
      kamikazePlayerIndex >= 0 && kamikazePlayerIndex < players.length,
      'kamikazePlayerIndex is out of range',
    );
    List<int> roundScores = List.generate(players.length, (_) => 0);
    List<int> scoreUpdates = List.generate(players.length, (_) => 0);
    for (int i = 0; i < scoreUpdates.length; i++) {
      if (i != kamikazePlayerIndex) {
        // In unlimited mode use standard point limit
        final limit = pointLimit ?? 100;
        scoreUpdates[i] += (limit / 2).round();
      }
    }
    addRoundScoresToList(
      roundNum,
      roundScores,
      scoreUpdates,
      0,
      kamikazePlayerIndex,
    );
  }

  /// Checks the scores of the current round and assigns points to the players.
  /// There are two possible outcomes of a round (kamikaze is handled by
  /// [applyKamikaze]):
  ///
  /// **Case 1**<br>
  /// The player who said CABO has the lowest score (or shares it).
  /// Only they receive 0 points. Every other player gets their round score.
  ///
  /// **Case 2**<br>
  ///  The player who said CABO does not have the lowest score.
  ///  They receive the session's cabo penalty added to their round score.
  ///  Every player with the lowest score gets 0 points.
  ///  Every other player gets their round score.
  void calculateScoredPoints(
    int roundNum,
    List<int> roundScores,
    int caboPlayerIndex,
  ) {
    assert(
      roundScores.length == players.length,
      'roundScores must contain a score for every player',
    );
    assert(
      caboPlayerIndex >= 0 && caboPlayerIndex < players.length,
      'caboPlayerIndex is out of range',
    );

    /// List of the index of the player(s) with the lowest score
    List<int> lowestScoreIndex = _getLowestScoreIndex(roundScores);

    if (lowestScoreIndex.contains(caboPlayerIndex)) {
      // The player who said CABO is one of the players which have the
      // fewest points.
      _assignPoints(roundNum, roundScores, caboPlayerIndex, [caboPlayerIndex]);
    } else {
      // A player other than the one who said CABO has the fewest points.
      _assignPoints(
        roundNum,
        roundScores,
        caboPlayerIndex,
        lowestScoreIndex,
        caboPlayerIndex,
      );
    }
  }

  /// The _getLowestScoreIndex method but forwarded for testing purposes.
  @visibleForTesting
  List<int> testingGetLowestScoreIndex(List<int> roundScores) =>
      _getLowestScoreIndex(roundScores);

  /// Returns the index of the player with the lowest score. If there are
  /// multiple players with the same lowest score, all of them are returned.
  /// [roundScores] is a list of the scores of all players in the current round.
  List<int> _getLowestScoreIndex(List<int> roundScores) {
    assert(roundScores.isNotEmpty, 'roundScores must not be empty');
    int lowestScore = roundScores[0];
    List<int> lowestScoreIndex = [0];

    for (int i = 1; i < roundScores.length; i++) {
      if (roundScores[i] < lowestScore) {
        lowestScore = roundScores[i];
        lowestScoreIndex = [i];
      } else if (roundScores[i] == lowestScore) {
        lowestScoreIndex.add(i);
      }
    }
    return lowestScoreIndex;
  }

  @visibleForTesting
  void testingAssignPoints(
    int roundNum,
    List<int> roundScores,
    int caboPlayerIndex,
    List<int> winnerIndex, [
    int? loserIndex,
  ]) => _assignPoints(
    roundNum,
    roundScores,
    caboPlayerIndex,
    winnerIndex,
    loserIndex,
  );

  /// Assigns points to the players based on the scores of the current round.
  /// [roundNum] is the number of the current round.
  /// [roundScores] is the raw list of the scores of all players in the current round.
  /// [winnerIndex] is the list of indices of the players who receive 0 points.
  /// [loserIndex] is the index of the player who receives the session's cabo
  /// penalty, or `null` if the player who said CABO has won.
  void _assignPoints(
    int roundNum,
    List<int> roundScores,
    int caboPlayerIndex,
    List<int> winnerIndex, [
    int? loserIndex,
  ]) {
    /// List of the updates for every player score
    List<int> scoreUpdates = [...roundScores];

    for (int i in winnerIndex) {
      scoreUpdates[i] = 0;
    }
    if (loserIndex != null) {
      scoreUpdates[loserIndex] += session.caboPenalty;
    }
    addRoundScoresToList(roundNum, roundScores, scoreUpdates, caboPlayerIndex);
  }

  /// Sets the scores of the players for a specific round.
  /// If [roundNum] is a new round, the round is added to the [roundList],
  /// otherwise the existing round with that number is replaced.
  /// It's important that each index of [roundScores] and [scoreUpdates]
  /// corresponds to the index of the player in the [players] list.
  void addRoundScoresToList(
    int roundNum,
    List<int> roundScores,
    List<int> scoreUpdates,
    int caboPlayerIndex, [
    int? kamikazePlayerIndex,
  ]) {
    assert(
      roundScores.length == players.length,
      'roundScores must contain a score for every player',
    );
    assert(
      scoreUpdates.length == players.length,
      'scoreUpdates must contain an update for every player',
    );
    assert(
      roundNum >= 1 && roundNum <= roundList.length + 1,
      'roundNum must reference an existing round or the next new round',
    );
    const uuid = Uuid();
    Round newRound = Round(
      roundId: uuid.v4(),
      gameSessionId: id,
      caboPlayerIndex: caboPlayerIndex,
      kamikazePlayerIndex: kamikazePlayerIndex,
      scores: roundScores,
      scoreUpdates: scoreUpdates,
    );
    if (roundNum > roundList.length) {
      roundList.add(newRound);
      _enqueueWrite(
        () => db.roundDao.addRound(
          gameSessionId: id,
          round: newRound,
          roundNumber: roundNum,
          players: players,
        ),
      );
    } else {
      roundList[roundNum - 1] = newRound;
      _enqueueWrite(
        () => db.roundDao.replaceRound(
          gameSessionId: id,
          round: newRound,
          roundNumber: roundNum,
          players: players,
        ),
      );
    }
  }

  /// This method updates the points of each player after a round.
  /// It first uses the _sumPoints() method to calculate the total points of each player.
  /// If the game has a point limit, it then uses _checkHundredPointsReached()
  /// to subtract half of the point limit from every player who reached the
  /// point limit exactly in the current round.
  /// Afterwards it checks if any player has exceeded the point limit. If so,
  /// it sets isGameFinished to true.
  /// It returns a list of player indices who reached the point limit
  /// (bonus players) in the current round for the [RoundView] to show a popup.
  List<int> updatePoints() {
    List<int> bonusPlayers = [];
    _sumPoints();

    if (isPointsLimitEnabled) {
      bonusPlayers = _checkHundredPointsReached();
      bool limitExceeded = false;

      for (int i = 0; i < players.length; i++) {
        if (players[i].totalScore > pointLimit!) {
          session.isGameFinished = true;
          limitExceeded = true;
        }
      }
      if (!limitExceeded) {
        session.isGameFinished = false;
      }
    }
    _enqueueWrite(
      () => db.gameSessionDao.updateGameFinished(
        gameId: id,
        isFinished: isGameFinished,
      ),
    );

    return bonusPlayers;
  }

  @visibleForTesting
  void testingSumPoints() => _sumPoints();

  /// Sums up the score updates of all rounds and stores the result in the
  /// [Player.totalScore] of each player.
  void _sumPoints() {
    for (int i = 0; i < players.length; i++) {
      players[i].totalScore = 0;
      for (int j = 0; j < roundList.length; j++) {
        players[i].totalScore += roundList[j].scoreUpdates[i];
      }
    }
    _enqueueWrite(() => db.playerDao.updatePlayerScores(players: players));
  }

  /// Checks if a player has reached the point limit exactly in the current round.
  /// If so, it subtracts half of the point limit from that player's score
  /// update of the last round and returns the indices of these players.
  List<int> _checkHundredPointsReached() {
    List<int> bonusPlayers = [];
    final int lastRoundIndex = roundList.length - 1;
    for (int i = 0; i < players.length; i++) {
      if (players[i].totalScore == pointLimit) {
        bonusPlayers.add(i);
        roundList[lastRoundIndex].scoreUpdates[i] -= (pointLimit! / 2).round();
      }
    }
    if (bonusPlayers.isNotEmpty) {
      // The round's score updates were adjusted after it was already persisted,
      // so persist the corrected round again to keep the database in sync.
      _enqueueWrite(
        () => db.roundDao.replaceRound(
          gameSessionId: id,
          round: roundList[lastRoundIndex],
          roundNumber: lastRoundIndex + 1,
          players: players,
        ),
      );
    }
    _sumPoints();
    return bonusPlayers;
  }

  /// Ends the game if it is in unlimited mode.
  /// It sets isGameFinished to true; the winner is derived automatically.
  void endGame() => session.isGameFinished = true;
}
