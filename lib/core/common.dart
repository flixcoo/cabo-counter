import 'package:cabo_counter/l10n/generated/app_localizations.dart';

String getPointLabel(AppLocalizations loc, int points) {
  if (points == 1 || points == -1) {
    return '$points ${loc.point}';
  } else {
    return '$points ${loc.points}';
  }
}

extension FilenameSanitization on String {
  /// Sanitizes a string to be used as a filename.
  ///
  /// Replaces spaces with underscores, normalizes German umlauts,
  /// and removes any characters that are not alphanumeric, dots, underscores, or hyphens.
  /// If the resulting string is empty, returns the [fallback].
  String toSafeFilename({String fallback = 'game_session'}) {
    final sanitized = replaceAll(' ', '_')
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('Ä', 'Ae')
        .replaceAll('Ö', 'Oe')
        .replaceAll('Ü', 'Ue')
        .replaceAll('ß', 'ss')
        .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '');

    return sanitized.isEmpty ? fallback : sanitized;
  }
}

/// Concatenates a list of names into a single readable string.
///
/// The output depends on the number of names:
/// - **0 names:** returns an empty string (`''`).
/// - **1 name:** returns that name unchanged (e.g. `'Anna'`).
/// - **2 names:** joins both with an ampersand (e.g. `'Anna & Ben'`).
/// - **3 or more names:** joins all but the last with commas and appends the
///   last one with an ampersand (e.g. `'Anna, Ben & Carla'`).
String concatenateNames(List<String> names) {
  switch (names.length) {
    case 0:
      return '';
    case 1:
      return names.first;
    case 2:
      return names[0] + ' & ' + names[1];
    default:
      return names.sublist(0, names.length - 1).join(', ') + ' & ' + names.last;
  }
}
