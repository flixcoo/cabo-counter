import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/migrations/migration_strategy.dart';
import 'package:cabo_counter/data/db/migrations/v2_rename_ids_and_drop_point_limit_flag.dart';
import 'package:cabo_counter/data/db/migrations/v3_replace_empty_names.dart';
import 'package:drift/drift.dart';

/// Central migration registry.
///
/// Add one entry per migration file here. Order does not matter — migrations
/// are executed sorted by their target version ([Migration.to]).
const List<Migration> _migrations = [
  V2RenameIdsAndDropPointLimitFlag(),
  V3ReplaceEmptyNames(),
];

/// Builds the [MigrationStrategy] for the [AppDatabase] by running every
/// registered [Migration] whose target version lies in the (from, to] range.
MigrationStrategy migrationStrategy(AppDatabase db) {
  final ordered = [..._migrations]..sort((a, b) => a.to.compareTo(b.to));

  return MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      for (final migration in ordered) {
        if (from < migration.to && migration.to <= to) {
          await migration.apply(db, migrator);
        }
      }
    },
    beforeOpen: (details) async {
      await db.customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
