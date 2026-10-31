import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:drift/drift.dart';

part 'game_session_dao.g.dart';

@DriftAccessor(tables: [GameSessionTable])
class GameSessionDao extends DatabaseAccessor<AppDatabase>
    with _$GameSessionDaoMixin {
  GameSessionDao(super.db);

  /* Create */

  /// Inserts a new game session into the database.
  Future<void> addGameSession(GameSession gameSession) async {
    await into(gameSessionTable).insert(
      GameSessionTableCompanion.insert(
        id: gameSession.id,
        createdAt: gameSession.createdAt,
        gameTitle: gameSession.title,
        pointLimit: Value(gameSession.pointLimit),
        caboPenalty: gameSession.caboPenalty,
        isGameFinished: gameSession.isGameFinished,
      ),
    );

    await db.playerDao.addPlayerAsList(
      gameId: gameSession.id,
      players: gameSession.players,
    );

    await db.roundDao.addRoundAsList(
      gameSessionId: gameSession.id,
      rounds: gameSession.roundList,
      players: gameSession.players,
    );
  }

  /// Inserts all given [gameSessions] into the database.
  Future<void> addGameSessionsAsList(List<GameSession> gameSessions) async {
    await transaction(() async {
      for (final gameSession in gameSessions) {
        await addGameSession(gameSession);
      }
    });
  }

  /* Read */

  /// Retrieves the IDs of all game sessions in the database.
  Future<Set<String>> getAllGameSessionIds() async {
    final query = selectOnly(gameSessionTable)
      ..addColumns([gameSessionTable.id]);
    final rows = await query.get();
    return rows.map((row) => row.read(gameSessionTable.id)!).toSet();
  }

  /// Retrieves all game sessions from the database.
  Future<List<GameSession>> getAllGameSessions() async {
    final query = select(gameSessionTable);
    final gameSessionResults = await query.get();
    if (gameSessionResults.isEmpty) return [];

    List<GameSession> gameSessions = await Future.wait(
      gameSessionResults.map((row) async {
        List<Player> playerList = await db.playerDao.getPlayersByGameSessionId(
          gameSessionId: row.id,
        );
        List<Round> roundList = await db.roundDao.getRoundsByGameId(
          gameSessionId: row.id,
        );

        return GameSession(
          id: row.id,
          createdAt: row.createdAt,
          title: row.gameTitle,
          players: playerList,
          pointLimit: row.pointLimit,
          caboPenalty: row.caboPenalty,
          isGameFinished: row.isGameFinished,
          roundList: roundList,
        );
      }),
    );

    return gameSessions;
  }

  /// Retrieves a game session by its ID.
  Future<GameSession?> getGameSessionById({
    required String gameSessionId,
  }) async {
    final query = select(gameSessionTable)
      ..where((tbl) => tbl.id.equals(gameSessionId));
    final gameSessionResult = await query.getSingleOrNull();
    if (gameSessionResult == null) {
      return null;
    }

    List<Player> playerList = await db.playerDao.getPlayersByGameSessionId(
      gameSessionId: gameSessionId,
    );
    List<Round> roundList = await db.roundDao.getRoundsByGameId(
      gameSessionId: gameSessionId,
    );

    GameSession gameSession = GameSession(
      id: gameSessionResult.id,
      createdAt: gameSessionResult.createdAt,
      title: gameSessionResult.gameTitle,
      players: playerList,
      pointLimit: gameSessionResult.pointLimit,
      caboPenalty: gameSessionResult.caboPenalty,
      isGameFinished: gameSessionResult.isGameFinished,
      roundList: roundList,
    );

    return gameSession;
  }

  /* Update */

  /// Updates the game finish status of a specific game session.
  Future<bool> updateGameFinished({
    required String gameId,
    required bool isFinished,
  }) async {
    final rowsAffected =
        await (update(
          gameSessionTable,
        )..where((tbl) => tbl.id.equals(gameId))).write(
          GameSessionTableCompanion(isGameFinished: Value(isFinished)),
        );
    return rowsAffected > 0;
  }

  /// Replaces the stored game sessions with the given [gameSessions].
  /// Existing sessions with the same ID are deleted including their players
  /// and rounds before the new data is inserted.
  Future<void> replaceGameSessions(List<GameSession> gameSessions) async {
    await transaction(() async {
      for (final gameSession in gameSessions) {
        await deleteGameSession(gameSessionId: gameSession.id);
      }
      await addGameSessionsAsList(gameSessions);
    });
  }

  /* Delete */

  /// Deletes the game session with the given [gameSessionId].
  /// Returns `true` if the deletion was successful, `false` otherwise.
  Future<bool> deleteGameSession({required String gameSessionId}) async {
    final rowsAffected = await (delete(
      gameSessionTable,
    )..where((tbl) => tbl.id.equals(gameSessionId))).go();
    return rowsAffected > 0;
  }

  /// Deletes all game sessions from the database.
  /// This method removes all entries from the [gameSessionTable].
  /// Returns `true` if any rows were deleted, `false` otherwise.
  Future<bool> deleteAllGames() async {
    return (await delete(gameSessionTable).go() > 0);
  }
}
