import 'dart:convert';
import 'dart:io';

import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
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
  static Future<ImportStatus> importJsonFile(BuildContext context) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final path = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (path == null) {
      return ImportStatus.canceled;
    }

    try {
      final jsonString = await _readFileContent(path.files.single);

      // Checks if the JSON String is in the gameList format
      if (await validateJsonSchema(jsonString, true)) {
        final jsonData = json.decode(jsonString) as List<dynamic>;
        List<GameSession> importedList = jsonData
            .map(
              (jsonItem) =>
                  GameSession.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();

        for (GameSession session in importedList) {
          await db.gameSessionDao.addGameSession(session);
        }
      } else if (await validateJsonSchema(jsonString, false)) {
        // Checks if the JSON String is in the single game format
        final jsonData = json.decode(jsonString) as Map<String, dynamic>;
        await db.gameSessionDao.addGameSession(GameSession.fromJson(jsonData));
      } else {
        return ImportStatus.validationError;
      }

      return ImportStatus.success;
    } on FormatException catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return ImportStatus.formatError;
    } on Exception catch (e, stack) {
      print('[DataTransferService] $e');
      print(stack);
      return ImportStatus.genericError;
    }
  }

  /// Helper method to read file content from either bytes or path
  static Future<String> _readFileContent(PlatformFile file) async {
    if (file.bytes != null) return utf8.decode(file.bytes!);
    if (file.path != null) return await File(file.path!).readAsString();

    throw Exception('Die Datei hat keinen lesbaren Inhalt');
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
