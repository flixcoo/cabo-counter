// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get about => 'Über';

  @override
  String get add_player => 'Spieler:in hinzufügen';

  @override
  String get app => 'App';

  @override
  String get app_name => 'Cabo Counter';

  @override
  String get ascending => 'Aufsteigend';

  @override
  String get bad_rating_message =>
      'Schreib mir gerne direkt eine E-Mail, damit wir dein Problem lösen können!';

  @override
  String get bad_rating_title => 'Unzufrieden mit der App?';

  @override
  String bonus_points_message(
    int playerCount,
    String names,
    int pointLimit,
    int bonusPoints,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      playerCount,
      locale: localeName,
      other:
          '$names haben exakt das Punktelimit von $pointLimit Punkten erreicht und bekommen deshalb jeweils $bonusPoints Punkte abgezogen!',
      one:
          '$names hat exakt das Punktelimit von $pointLimit Punkten erreicht und bekommt deshalb $bonusPoints Punkte abgezogen!',
    );
    return '$_temp0';
  }

  @override
  String get bonus_points_title => 'Bonus-Punkte!';

  @override
  String get build => 'Build-Nr.';

  @override
  String get cabo_penalty => 'Cabo-Strafe';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get config_change_info =>
      'Geänderte Punktewerte gelten nur für neu erstellte Spiele. Bereits bestehende Spiele behalten ihre ursprünglichen Einstellungen.';

  @override
  String get contact_email => 'E-Mail schreiben';

  @override
  String get continu => 'Weiter';

  @override
  String get create_game => 'Spiel erstellen';

  @override
  String get date => 'Datum';

  @override
  String get dealer => 'Mischer:in';

  @override
  String get delete => 'Löschen';

  @override
  String get delete_data => 'Alle Spieldaten löschen';

  @override
  String get delete_data_message =>
      'Bist du sicher, dass du alle Spieldaten löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get delete_data_title => 'Spieldaten löschen?';

  @override
  String get delete_game => 'Spiel löschen';

  @override
  String delete_game_message(String gameTitle) {
    return 'Bist du sicher, dass du das Spiel \"$gameTitle\" löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get delete_game_title => 'Spiel löschen?';

  @override
  String get descending => 'Absteigend';

  @override
  String get detailed_analytics => 'Detaillierte Auswertung';

  @override
  String get done => 'Fertig';

  @override
  String get email_body => 'Ich habe folgendes Feedback...';

  @override
  String get email_subject => 'Feedback: Cabo Counter App';

  @override
  String get empty_filter_button => 'Alle Spiele anzeigen';

  @override
  String get empty_filter_text =>
      'Passe die Filteroptionen an um alle Spiele zu sehen.';

  @override
  String get empty_graph_text =>
      'Du musst mindestens eine Runde spielen, damit der Graph des Spielverlaufes angezeigt werden kann.';

  @override
  String get end_game => 'Spiel beenden';

  @override
  String get end_game_message =>
      'Möchtest du das Spiel beenden? Das Spiel wird als beendet markiert und kann nicht fortgeführt werden.';

  @override
  String get end_game_title => 'Spiel beenden?';

  @override
  String end_of_game_message(int playerCount, String names, int points) {
    String _temp0 = intl.Intl.pluralLogic(
      playerCount,
      locale: localeName,
      other:
          '$names haben das Spiel mit $points Punkten gewonnen. Glückwunsch!',
      one: '$names hat das Spiel mit $points Punkten gewonnen. Glückwunsch!',
    );
    return '$_temp0';
  }

  @override
  String get end_of_game_title => 'Spiel beendet';

  @override
  String get export_data => 'Spieldaten exportieren';

  @override
  String get export_error_message => 'Datei konnte nicht exportiert werden';

  @override
  String get export_error_title => 'Fehler';

  @override
  String get export_game => 'Spiel exportieren';

  @override
  String get filter => 'Filter';

  @override
  String get game => 'Spiel';

  @override
  String get game_data => 'Spieldaten';

  @override
  String get game_graph => 'Spielgraph';

  @override
  String get game_name => 'Spielname';

  @override
  String get gamemode => 'Spielmodus';

  @override
  String get games => 'Spiele';

  @override
  String get haptic_feedback => 'Haptisches Feedback';

  @override
  String get home => 'Home';

  @override
  String get id_error_message =>
      'Das Spiel hat bisher noch keine ID zugewiesen bekommen. Falls du das Spiel löschen möchtest, mache das bitte über das Hauptmenü. Alle neu erstellten Spiele haben eine ID.';

  @override
  String get id_error_title => 'ID Fehler';

  @override
  String get import_data => 'Spieldaten importieren';

  @override
  String get import_format_error_message =>
      'Die Datei ist kein gültiges JSON-Format oder enthält ungültige Daten.';

  @override
  String get import_format_error_title => 'Falsches Format';

  @override
  String get import_generic_error_message => 'Der Import ist fehlgeschlagen.';

  @override
  String get import_generic_error_title => 'Import fehlgeschlagen';

  @override
  String get import_success_message =>
      'Die Spieldaten wurden erfolgreich importiert.';

  @override
  String get import_success_title => 'Import erfolgreich';

  @override
  String get import_validation_error_message =>
      'Es wurden keine Cabo-Counter Spieldaten gefunden. Bitte stellen Sie sicher, dass es sich um eine gültige Cabo-Counter Exportdatei handelt.';

  @override
  String get import_validation_error_title => 'Validierung fehlgeschlagen';

  @override
  String get kamikaze => 'Kamikaze';

  @override
  String get legal_notice => 'Impressum';

  @override
  String get license_details => 'Lizenzdetails';

  @override
  String get licenses => 'Lizenzen';

  @override
  String get longest_win_streak => 'Längste Siegesserie';

  @override
  String get mail_developer => 'E-Mail an Entwickler';

  @override
  String get mode => 'Modus';

  @override
  String get name => 'Name';

  @override
  String get new_game => 'Neues Spiel';

  @override
  String get new_game_same_settings => 'Neues Spiel mit gleichen Einstellungen';

  @override
  String get next_round => 'Nächste Runde';

  @override
  String get no => 'Nein';

  @override
  String get no_default_description =>
      'Entscheide bei jedem Spiel selber, welchen Modus du spielen möchtest.';

  @override
  String get no_default_mode => 'Kein Modus';

  @override
  String get no_games_created_yet => 'Noch keine Spiele erstellt.';

  @override
  String get no_license_text => 'Keine Lizenz verfügbar';

  @override
  String get no_mode_selected => 'Wähle einen Spielmodus';

  @override
  String get ok => 'OK';

  @override
  String get only_active_game_title => 'Nur aktive Spiele';

  @override
  String get only_active_games => 'Nur aktive Spiele werden angezeigt';

  @override
  String get overview => 'Übersicht';

  @override
  String get player => 'Spieler:in';

  @override
  String get players => 'Spieler:innen';

  @override
  String get point => 'Punkt';

  @override
  String get point_limit => 'Punkte-Limit';

  @override
  String point_limit_description(int pointLimit) {
    return 'Es wird so lange gespielt, bis ein:e Spieler:in mehr als $pointLimit Punkte erreicht';
  }

  @override
  String get points => 'Punkte';

  @override
  String get points_per_round => 'Punkte pro Runde';

  @override
  String get pre_rating_message =>
      'Feedback hilft mir, die App zu verbessern. Vielen Dank!';

  @override
  String get pre_rating_title => 'Gefällt dir die App?';

  @override
  String get privacy_policy => 'Datenschutzerklärung';

  @override
  String get received_cabo_penalties => 'Erhaltene Cabo-Strafen';

  @override
  String get report_error => 'Fehler melden';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get reset_config_message =>
      'Möchtest du deine Einstellungen zurücksetzen?';

  @override
  String get reset_config_title => 'Einstellungen zurücksetzen';

  @override
  String get reset_to_default => 'Auf Standard zurücksetzen';

  @override
  String get results => 'Ergebnisse';

  @override
  String get rotate_dealer => 'Mischer:in rotieren';

  @override
  String get rotate_dealer_info =>
      'Standardmäßig mischt die Person, welche die letzte Runde verloren hat. Aktiviere diese Option um die Rolle jede Runde in Spielreihenfolge zu rotieren.';

  @override
  String get round => 'Runde';

  @override
  String get rounds => 'Runden';

  @override
  String get rounds_won => 'Gewonnene Runden';

  @override
  String get score_table => 'Punktetabelle';

  @override
  String get settings => 'Einstellungen';

  @override
  String get sort_by => 'Sortieren nach';

  @override
  String get sort_order => 'Reihenfolge';

  @override
  String standard_game_title(Object date) {
    return 'Spiel vom $date';
  }

  @override
  String get standard_mode => 'Standard-Modus';

  @override
  String get statistics => 'Statistiken';

  @override
  String get submit => 'Bestätigen';

  @override
  String get support_me => 'Unterstütze mich';

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get unlimited_description =>
      'Es wird so lange gespielt, bis ihr keine Lust mehr habt. Das Spiel kann jederzeit manuell beendet werden.';

  @override
  String get version => 'Version';

  @override
  String get whats_new => 'Was ist Neu?';

  @override
  String get who_has_kamikaze => 'Wer hat Kamikaze?';

  @override
  String get who_said_cabo => 'Wer hat CABO gesagt?';

  @override
  String get yes => 'Ja';
}
