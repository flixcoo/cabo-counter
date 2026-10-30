import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/round_score_table.dart';
import 'package:cabo_counter/data/db/tables/round_table.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart';

part 'rounds_dao.g.dart';

@DriftAccessor(tables: [RoundTable, RoundScoreTable])
class RoundDao extends DatabaseAccessor<AppDatabase> with _$RoundDaoMixin {
  RoundDao(super.db);

  /* Create */

  /// Inserts a new round into the database.
  Future<void> addRound({
    required String gameSessionId,
    required Round round,
    required int roundNumber,
    required List<Player> players,
  }) async {
    assert(roundNumber >= 1, 'roundNumber must be at least 1');
    assert(
      round.scores.length == players.length,
      'The round must contain a score for every player',
    );
    final roundEntry = RoundTableCompanion.insert(
      id: round.id,
      gameSessionId: gameSessionId,
      roundNumber: roundNumber,
      caboPlayerIndex: round.caboPlayerIndex,
      kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
    );

    await into(roundTable).insert(roundEntry);

    for (int i = 0; i < players.length; i++) {
      final player = players[i];
      final roundScoreEntry = RoundScoreTableCompanion.insert(
        roundId: round.id,
        playerId: player.id,
        score: round.scores[i],
        scoreUpdate: round.scoreUpdates[i],
      );
      await into(roundScoreTable).insert(roundScoreEntry);
    }
  }

  /// Inserts multiple rounds into the database.
  Future<void> addRoundAsList({
    required String gameSessionId,
    required List<Round> rounds,
    required List<Player> players,
  }) async {
    assert(
      rounds.every((round) => round.scores.length == players.length),
      'Every round must contain a score for every player',
    );
    if (rounds.isEmpty) return;
    await batch((batch) {
      final roundEntries = <RoundTableCompanion>[];
      final roundScoreEntries = <RoundScoreTableCompanion>[];

      for (int r = 0; r < rounds.length; r++) {
        final round = rounds[r];
        roundEntries.add(
          RoundTableCompanion.insert(
            id: round.id,
            gameSessionId: gameSessionId,
            roundNumber: r + 1,
            caboPlayerIndex: round.caboPlayerIndex,
            kamikazePlayerIndex: Value(round.kamikazePlayerIndex),
          ),
        );

        for (int i = 0; i < players.length; i++) {
          roundScoreEntries.add(
            RoundScoreTableCompanion.insert(
              roundId: round.id,
              playerId: players[i].id,
              score: round.scores[i],
              scoreUpdate: round.scoreUpdates[i],
            ),
          );
        }
      }

      batch.insertAll(roundTable, roundEntries);
      batch.insertAll(roundScoreTable, roundScoreEntries);
    });
  }

  /* Read */

  /// Retrieves all rounds for a specific game session by its ID.
  /// The rounds are ordered by their round number so that the position of a
  /// round in the returned list matches its round number (index + 1).
  Future<List<Round>> getRoundsByGameId({required String gameSessionId}) async {
    final query = select(roundTable)
      ..where((tbl) => tbl.gameSessionId.equals(gameSessionId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.roundNumber)]);

    final roundResult = await query.get();

    final roundList = await Future.wait(
      roundResult.map((row) async {
        final scores = await db.roundScoresDao.getScoresByRoundId(
          roundId: row.id,
        );
        final roundScores = await db.roundScoresDao.getScoreUpdatesByRoundId(
          roundId: row.id,
        );

        return Round(
          roundId: row.id,
          gameSessionId: row.gameSessionId,
          caboPlayerIndex: row.caboPlayerIndex,
          kamikazePlayerIndex: row.kamikazePlayerIndex,
          scores: scores,
          scoreUpdates: roundScores,
        );
      }),
    );

    return roundList;
  }

  /// Retrieves a specific round by its [gameSessionId] and [roundNumber].
  /// Returns null if the round does not exist.
  Future<Round?> getRoundByGameIdAndRoundNumber({
    required String gameSessionId,
    required int roundNumber,
  }) async {
    final query = select(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameSessionId) &
            tbl.roundNumber.equals(roundNumber),
      );
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return null;

    final scoreResult = await Future.wait([
      db.roundScoresDao.getScoresByRoundId(roundId: roundResult.id),
      db.roundScoresDao.getScoreUpdatesByRoundId(roundId: roundResult.id),
    ]);

    return Round(
      roundId: roundResult.id,
      gameSessionId: roundResult.gameSessionId,
      caboPlayerIndex: roundResult.caboPlayerIndex,
      kamikazePlayerIndex: roundResult.kamikazePlayerIndex,
      scores: scoreResult[0],
      scoreUpdates: scoreResult[1],
    );
  }

  /* Update */

  /// Replaces an already existing round with a new one.
  Future<void> replaceRound({
    required String gameSessionId,
    required Round round,
    required int roundNumber,
    required List<Player> players,
  }) async {
    assert(roundNumber >= 1, 'roundNumber must be at least 1');
    assert(
      round.scores.length == players.length,
      'The round must contain a score for every player',
    );
    await deleteRound(gameSessionId: gameSessionId, roundNumber: roundNumber);

    await addRound(
      gameSessionId: gameSessionId,
      round: round,
      roundNumber: roundNumber,
      players: players,
    );
  }

  /* Delete */

  /// Deletes a specific round by its [gameSessionId] and [roundNumber].
  Future<bool> deleteRound({
    required String gameSessionId,
    required int roundNumber,
  }) async {
    final query = select(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameSessionId) &
            tbl.roundNumber.equals(roundNumber),
      );
    final roundResult = await query.getSingleOrNull();
    if (roundResult == null) return false;

    final deleteQuery = delete(roundTable)
      ..where(
        (tbl) =>
            tbl.gameSessionId.equals(gameSessionId) &
            tbl.roundNumber.equals(roundNumber),
      );
    await deleteQuery.go();
    return true;
  }
}
