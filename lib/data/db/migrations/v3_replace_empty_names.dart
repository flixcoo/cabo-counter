import 'dart:ui';

import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/db/migrations/migration_strategy.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:drift/drift.dart';

/// v2 -> v3
/// - Replaces empty or whitespace-only game titles and player names with
///   localized placeholders. These could be saved before inputs were trimmed.
///   The placeholders are stored in the device language at migration time.
class V3ReplaceEmptyNames extends Migration {
  const V3ReplaceEmptyNames();

  @override
  int get to => 3;

  @override
  Future<void> apply(AppDatabase db, Migrator migrator) async {
    final loc = _deviceLocalizations();

    await db.customStatement(
      "UPDATE game_session_table SET game_title = ? WHERE TRIM(game_title) = ''",
      [loc.untitled_game],
    );

    await db.customStatement(
      "UPDATE player_table SET name = ? WHERE TRIM(name) = ''",
      [loc.unnamed_player],
    );
  }

  /// Resolves the localizations like the app's `localeResolutionCallback`.
  AppLocalizations _deviceLocalizations() {
    final deviceLocale = PlatformDispatcher.instance.locale;
    final locale = AppLocalizations.supportedLocales.firstWhere(
      (l) => l.languageCode == deviceLocale.languageCode,
      orElse: () => AppLocalizations.supportedLocales.first,
    );
    return lookupAppLocalizations(locale);
  }
}
