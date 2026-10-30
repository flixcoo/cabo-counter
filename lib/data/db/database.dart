import 'package:cabo_counter/data/dao/game_session_dao.dart';
import 'package:cabo_counter/data/dao/player_dao.dart';
import 'package:cabo_counter/data/dao/round_scores_dao.dart';
import 'package:cabo_counter/data/dao/rounds_dao.dart';
import 'package:cabo_counter/data/db/migrations/database_migration.dart';
import 'package:cabo_counter/data/db/tables/game_session_table.dart';
import 'package:cabo_counter/data/db/tables/player_table.dart';
import 'package:cabo_counter/data/db/tables/round_score_table.dart';
import 'package:cabo_counter/data/db/tables/round_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [GameSessionTable, PlayerTable, RoundScoreTable, RoundTable],
  daos: [GameSessionDao, PlayerDao, RoundDao, RoundScoresDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => migrationStrategy(this);

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cabo-counter_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
