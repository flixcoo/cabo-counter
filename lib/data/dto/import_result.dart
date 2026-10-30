import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/models/game_session.dart';

class ImportResult {
  /// The result of a game data import.
  ///
  /// - [status]: The [ImportStatus] of the import operation.
  /// - [importedAmount]: The number of newly imported game sessions.
  /// - [duplicates]: The game sessions that were skipped because their IDs
  ///   already exist locally.
  ImportResult({
    required this.status,
    this.importedAmount = 0,
    this.duplicates = const [],
  });

  final ImportStatus status;
  final int importedAmount;
  final List<GameSession> duplicates;
}
