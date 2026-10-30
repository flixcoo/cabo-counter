import 'dart:convert';

import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/import_result.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';
import 'package:provider/provider.dart';

class DataTransferService {
  /// Writes the game session list to a JSON file and returns it as string.
  @visibleForTesting
  static Future<String> getGameDataAsJsonFile(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final sessions = await db.gameSessionDao.getAllGameSessions();

    final jsonFile = sessions.map((session) => session.toJson()).toList();
    return json.encode(jsonFile);
  }

  /// Opens the file picker to export game data as a JSON file.
  /// This method will export the given [jsonString] as a JSON file. It opens
  /// the file picker with the choosen [fileName].
  static Future<bool> _exportJsonData(
    String jsonString,
    String fileName,
  ) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      await FileSaver.instance.saveAs(
        name: fileName,
        bytes: bytes,
        mimeType: MimeType.json,
        fileExtension: 'json',
      );
      return true;
    } catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return false;
    }
  }

  /// Opens the file picker to export all game sessions as a JSON file.
  static Future<bool> exportGameData(BuildContext context) async {
    String jsonString = await getGameDataAsJsonFile(context);
    String fileName = 'cabo_counter';
    return _exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to save a single game session as a JSON file.
  static Future<bool> exportSingleGameSession(GameSession session) async {
    String jsonString = json.encode(session.toJson());
    String fileName = session.title.toSafeFilename();
    return _exportJsonData(jsonString, fileName);
  }

  /// Opens the file picker to import a JSON file and loads the game data from it.
  /// Game sessions whose IDs already exist locally are not imported but
  /// returned as [ImportResult.duplicates].
  static Future<ImportResult> importJsonFile(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (file == null) {
      return ImportResult(status: ImportStatus.canceled);
    }

    try {
      final jsonString = utf8.decode(await file.readAsBytes());
      final List<GameSession> importedList;

      // Checks if the JSON String is in the gameList format
      if (await validateJsonSchema(jsonString, true)) {
        final jsonData = json.decode(jsonString) as List<dynamic>;
        importedList = jsonData
            .map(
              (jsonItem) =>
                  GameSession.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();
      } else if (await validateJsonSchema(jsonString, false)) {
        // Checks if the JSON String is in the single game format
        final jsonData = json.decode(jsonString) as Map<String, dynamic>;
        importedList = [GameSession.fromJson(jsonData)];
      } else {
        return ImportResult(status: ImportStatus.validationError);
      }

      return await importGameSessionsToDb(db, importedList);
    } on FormatException catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return ImportResult(status: ImportStatus.formatError);
    } on Exception catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return ImportResult(status: ImportStatus.genericError);
    }
  }

  /// Adds all [sessions] to the database whose IDs do not exist locally yet.
  /// Sessions with an already existing ID are skipped and returned as
  /// duplicates. If an ID occurs multiple times in [sessions], only the
  /// first occurrence is considered.
  @visibleForTesting
  static Future<ImportResult> importGameSessionsToDb(
    AppDatabase db,
    List<GameSession> sessions,
  ) async {
    final localIds = await db.gameSessionDao.getAllGameSessionIds();
    final seenIds = <String>{};
    final newSessions = <GameSession>[];
    final duplicates = <GameSession>[];

    for (GameSession session in sessions) {
      if (!seenIds.add(session.id)) continue;
      if (localIds.contains(session.id)) {
        duplicates.add(session);
      } else {
        newSessions.add(session);
      }
    }

    await db.gameSessionDao.addGameSessionsAsList(newSessions);

    return ImportResult(
      status: duplicates.isEmpty
          ? ImportStatus.success
          : ImportStatus.duplicatesFound,
      importedAmount: newSessions.length,
      duplicates: duplicates,
    );
  }

  /// Overwrites the local game sessions with the given [sessions].
  /// Returns `true` if all sessions were replaced successfully.
  static Future<bool> overwriteGameSessionsInDb(
    BuildContext context,
    List<GameSession> sessions,
  ) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    try {
      await db.gameSessionDao.replaceGameSessions(sessions);
      return true;
    } catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return false;
    }
  }

  /// Validates the JSON data against the schema.
  /// This method checks if the provided [jsonString] is valid against the
  /// JSON schema. It takes a boolean [isGameList] to determine
  /// which schema to use (game list or single game).
  static Future<bool> validateJsonSchema(
    String jsonString,
    bool isGameList,
  ) async {
    final String schemaString;

    if (isGameList) {
      schemaString = await rootBundle.loadString(
        'assets/game_list-schema.json',
      );
    } else {
      schemaString = await rootBundle.loadString('assets/game-schema.json');
    }

    try {
      final schema = JsonSchema.create(json.decode(schemaString));
      final jsonData = json.decode(jsonString);
      final result = schema.validate(jsonData);
      return result.isValid;
    } catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return false;
    }
  }
}
