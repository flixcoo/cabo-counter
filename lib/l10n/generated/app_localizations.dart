import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @about.
  ///
  /// In de, this message translates to:
  /// **'Über'**
  String get about;

  /// No description provided for @add_player.
  ///
  /// In de, this message translates to:
  /// **'Spieler:in hinzufügen'**
  String get add_player;

  /// No description provided for @app.
  ///
  /// In de, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @app_name.
  ///
  /// In de, this message translates to:
  /// **'Cabo Counter'**
  String get app_name;

  /// No description provided for @ascending.
  ///
  /// In de, this message translates to:
  /// **'Aufsteigend'**
  String get ascending;

  /// No description provided for @bad_rating_message.
  ///
  /// In de, this message translates to:
  /// **'Schreib mir gerne direkt eine E-Mail, damit wir dein Problem lösen können!'**
  String get bad_rating_message;

  /// No description provided for @bad_rating_title.
  ///
  /// In de, this message translates to:
  /// **'Unzufrieden mit der App?'**
  String get bad_rating_title;

  /// No description provided for @bonus_points_message.
  ///
  /// In de, this message translates to:
  /// **'{playerCount, plural, =1{{names} hat exakt das Punktelimit von {pointLimit} Punkten erreicht und bekommt deshalb {bonusPoints} Punkte abgezogen!} other{{names} haben exakt das Punktelimit von {pointLimit} Punkten erreicht und bekommen deshalb jeweils {bonusPoints} Punkte abgezogen!}}'**
  String bonus_points_message(
    int playerCount,
    String names,
    int pointLimit,
    int bonusPoints,
  );

  /// No description provided for @bonus_points_title.
  ///
  /// In de, this message translates to:
  /// **'Bonus-Punkte!'**
  String get bonus_points_title;

  /// No description provided for @build.
  ///
  /// In de, this message translates to:
  /// **'Build-Nr.'**
  String get build;

  /// No description provided for @cabo_penalty.
  ///
  /// In de, this message translates to:
  /// **'Cabo-Strafe'**
  String get cabo_penalty;

  /// No description provided for @cancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get cancel;

  /// No description provided for @config_change_info.
  ///
  /// In de, this message translates to:
  /// **'Geänderte Punktewerte gelten nur für neu erstellte Spiele. Bereits bestehende Spiele behalten ihre ursprünglichen Einstellungen.'**
  String get config_change_info;

  /// No description provided for @contact_email.
  ///
  /// In de, this message translates to:
  /// **'E-Mail schreiben'**
  String get contact_email;

  /// No description provided for @continu.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get continu;

  /// No description provided for @create_game.
  ///
  /// In de, this message translates to:
  /// **'Spiel erstellen'**
  String get create_game;

  /// No description provided for @date.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get date;

  /// No description provided for @dealer.
  ///
  /// In de, this message translates to:
  /// **'Mischer:in'**
  String get dealer;

  /// No description provided for @delete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get delete;

  /// No description provided for @delete_data.
  ///
  /// In de, this message translates to:
  /// **'Alle Spieldaten löschen'**
  String get delete_data;

  /// No description provided for @delete_data_message.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du alle Spieldaten löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.'**
  String get delete_data_message;

  /// No description provided for @delete_data_title.
  ///
  /// In de, this message translates to:
  /// **'Spieldaten löschen?'**
  String get delete_data_title;

  /// No description provided for @delete_game.
  ///
  /// In de, this message translates to:
  /// **'Spiel löschen'**
  String get delete_game;

  /// No description provided for @delete_game_message.
  ///
  /// In de, this message translates to:
  /// **'Bist du sicher, dass du das Spiel \"{gameTitle}\" löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.'**
  String delete_game_message(String gameTitle);

  /// No description provided for @delete_game_title.
  ///
  /// In de, this message translates to:
  /// **'Spiel löschen?'**
  String get delete_game_title;

  /// No description provided for @descending.
  ///
  /// In de, this message translates to:
  /// **'Absteigend'**
  String get descending;

  /// No description provided for @detailed_analytics.
  ///
  /// In de, this message translates to:
  /// **'Detaillierte Auswertung'**
  String get detailed_analytics;

  /// No description provided for @done.
  ///
  /// In de, this message translates to:
  /// **'Fertig'**
  String get done;

  /// No description provided for @email_body.
  ///
  /// In de, this message translates to:
  /// **'Ich habe folgendes Feedback...'**
  String get email_body;

  /// No description provided for @email_subject.
  ///
  /// In de, this message translates to:
  /// **'Feedback: Cabo Counter App'**
  String get email_subject;

  /// No description provided for @empty_filter_button.
  ///
  /// In de, this message translates to:
  /// **'Alle Spiele anzeigen'**
  String get empty_filter_button;

  /// No description provided for @empty_filter_text.
  ///
  /// In de, this message translates to:
  /// **'Passe die Filteroptionen an um alle Spiele zu sehen.'**
  String get empty_filter_text;

  /// No description provided for @empty_graph_text.
  ///
  /// In de, this message translates to:
  /// **'Du musst mindestens eine Runde spielen, damit der Graph des Spielverlaufes angezeigt werden kann.'**
  String get empty_graph_text;

  /// No description provided for @end_game.
  ///
  /// In de, this message translates to:
  /// **'Spiel beenden'**
  String get end_game;

  /// No description provided for @end_game_message.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du das Spiel beenden? Das Spiel wird als beendet markiert und kann nicht fortgeführt werden.'**
  String get end_game_message;

  /// No description provided for @end_game_title.
  ///
  /// In de, this message translates to:
  /// **'Spiel beenden?'**
  String get end_game_title;

  /// No description provided for @end_of_game_message.
  ///
  /// In de, this message translates to:
  /// **'{playerCount, plural, =1{{names} hat das Spiel mit {points} Punkten gewonnen. Glückwunsch!} other{{names} haben das Spiel mit {points} Punkten gewonnen. Glückwunsch!}}'**
  String end_of_game_message(int playerCount, String names, int points);

  /// No description provided for @end_of_game_title.
  ///
  /// In de, this message translates to:
  /// **'Spiel beendet'**
  String get end_of_game_title;

  /// No description provided for @export_data.
  ///
  /// In de, this message translates to:
  /// **'Spieldaten exportieren'**
  String get export_data;

  /// No description provided for @export_error_message.
  ///
  /// In de, this message translates to:
  /// **'Datei konnte nicht exportiert werden'**
  String get export_error_message;

  /// No description provided for @export_error_title.
  ///
  /// In de, this message translates to:
  /// **'Fehler'**
  String get export_error_title;

  /// No description provided for @export_game.
  ///
  /// In de, this message translates to:
  /// **'Spiel exportieren'**
  String get export_game;

  /// No description provided for @filter.
  ///
  /// In de, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @game.
  ///
  /// In de, this message translates to:
  /// **'Spiel'**
  String get game;

  /// No description provided for @game_data.
  ///
  /// In de, this message translates to:
  /// **'Spieldaten'**
  String get game_data;

  /// No description provided for @game_graph.
  ///
  /// In de, this message translates to:
  /// **'Spielgraph'**
  String get game_graph;

  /// No description provided for @game_name.
  ///
  /// In de, this message translates to:
  /// **'Spielname'**
  String get game_name;

  /// No description provided for @gamemode.
  ///
  /// In de, this message translates to:
  /// **'Spielmodus'**
  String get gamemode;

  /// No description provided for @games.
  ///
  /// In de, this message translates to:
  /// **'Spiele'**
  String get games;

  /// No description provided for @haptic_feedback.
  ///
  /// In de, this message translates to:
  /// **'Haptisches Feedback'**
  String get haptic_feedback;

  /// No description provided for @home.
  ///
  /// In de, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @id_error_message.
  ///
  /// In de, this message translates to:
  /// **'Das Spiel hat bisher noch keine ID zugewiesen bekommen. Falls du das Spiel löschen möchtest, mache das bitte über das Hauptmenü. Alle neu erstellten Spiele haben eine ID.'**
  String get id_error_message;

  /// No description provided for @id_error_title.
  ///
  /// In de, this message translates to:
  /// **'ID Fehler'**
  String get id_error_title;

  /// No description provided for @import_data.
  ///
  /// In de, this message translates to:
  /// **'Spieldaten importieren'**
  String get import_data;

  /// No description provided for @import_format_error_message.
  ///
  /// In de, this message translates to:
  /// **'Die Datei ist kein gültiges JSON-Format oder enthält ungültige Daten.'**
  String get import_format_error_message;

  /// No description provided for @import_format_error_title.
  ///
  /// In de, this message translates to:
  /// **'Falsches Format'**
  String get import_format_error_title;

  /// No description provided for @import_generic_error_message.
  ///
  /// In de, this message translates to:
  /// **'Der Import ist fehlgeschlagen.'**
  String get import_generic_error_message;

  /// No description provided for @import_generic_error_title.
  ///
  /// In de, this message translates to:
  /// **'Import fehlgeschlagen'**
  String get import_generic_error_title;

  /// No description provided for @import_success_message.
  ///
  /// In de, this message translates to:
  /// **'Die Spieldaten wurden erfolgreich importiert.'**
  String get import_success_message;

  /// No description provided for @import_success_title.
  ///
  /// In de, this message translates to:
  /// **'Import erfolgreich'**
  String get import_success_title;

  /// No description provided for @import_validation_error_message.
  ///
  /// In de, this message translates to:
  /// **'Es wurden keine Cabo-Counter Spieldaten gefunden. Bitte stellen Sie sicher, dass es sich um eine gültige Cabo-Counter Exportdatei handelt.'**
  String get import_validation_error_message;

  /// No description provided for @import_validation_error_title.
  ///
  /// In de, this message translates to:
  /// **'Validierung fehlgeschlagen'**
  String get import_validation_error_title;

  /// No description provided for @kamikaze.
  ///
  /// In de, this message translates to:
  /// **'Kamikaze'**
  String get kamikaze;

  /// No description provided for @legal_notice.
  ///
  /// In de, this message translates to:
  /// **'Impressum'**
  String get legal_notice;

  /// No description provided for @license_details.
  ///
  /// In de, this message translates to:
  /// **'Lizenzdetails'**
  String get license_details;

  /// No description provided for @licenses.
  ///
  /// In de, this message translates to:
  /// **'Lizenzen'**
  String get licenses;

  /// No description provided for @longest_win_streak.
  ///
  /// In de, this message translates to:
  /// **'Längste Siegesserie'**
  String get longest_win_streak;

  /// No description provided for @mail_developer.
  ///
  /// In de, this message translates to:
  /// **'E-Mail an Entwickler'**
  String get mail_developer;

  /// No description provided for @mode.
  ///
  /// In de, this message translates to:
  /// **'Modus'**
  String get mode;

  /// No description provided for @name.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @new_game.
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel'**
  String get new_game;

  /// No description provided for @new_game_same_settings.
  ///
  /// In de, this message translates to:
  /// **'Neues Spiel mit gleichen Einstellungen'**
  String get new_game_same_settings;

  /// No description provided for @next_round.
  ///
  /// In de, this message translates to:
  /// **'Nächste Runde'**
  String get next_round;

  /// No description provided for @no.
  ///
  /// In de, this message translates to:
  /// **'Nein'**
  String get no;

  /// No description provided for @no_default_description.
  ///
  /// In de, this message translates to:
  /// **'Entscheide bei jedem Spiel selber, welchen Modus du spielen möchtest.'**
  String get no_default_description;

  /// No description provided for @no_default_mode.
  ///
  /// In de, this message translates to:
  /// **'Kein Modus'**
  String get no_default_mode;

  /// No description provided for @no_games_created_yet.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Spiele erstellt.'**
  String get no_games_created_yet;

  /// No description provided for @no_license_text.
  ///
  /// In de, this message translates to:
  /// **'Keine Lizenz verfügbar'**
  String get no_license_text;

  /// No description provided for @no_mode_selected.
  ///
  /// In de, this message translates to:
  /// **'Wähle einen Spielmodus'**
  String get no_mode_selected;

  /// No description provided for @ok.
  ///
  /// In de, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @only_active_game_title.
  ///
  /// In de, this message translates to:
  /// **'Nur aktive Spiele'**
  String get only_active_game_title;

  /// No description provided for @only_active_games.
  ///
  /// In de, this message translates to:
  /// **'Nur aktive Spiele werden angezeigt'**
  String get only_active_games;

  /// No description provided for @overview.
  ///
  /// In de, this message translates to:
  /// **'Übersicht'**
  String get overview;

  /// No description provided for @player.
  ///
  /// In de, this message translates to:
  /// **'Spieler:in'**
  String get player;

  /// No description provided for @players.
  ///
  /// In de, this message translates to:
  /// **'Spieler:innen'**
  String get players;

  /// No description provided for @point.
  ///
  /// In de, this message translates to:
  /// **'Punkt'**
  String get point;

  /// No description provided for @point_limit.
  ///
  /// In de, this message translates to:
  /// **'Punkte-Limit'**
  String get point_limit;

  /// No description provided for @point_limit_description.
  ///
  /// In de, this message translates to:
  /// **'Es wird so lange gespielt, bis ein:e Spieler:in mehr als {pointLimit} Punkte erreicht'**
  String point_limit_description(int pointLimit);

  /// No description provided for @points.
  ///
  /// In de, this message translates to:
  /// **'Punkte'**
  String get points;

  /// No description provided for @points_per_round.
  ///
  /// In de, this message translates to:
  /// **'Punkte pro Runde'**
  String get points_per_round;

  /// No description provided for @pre_rating_message.
  ///
  /// In de, this message translates to:
  /// **'Feedback hilft mir, die App zu verbessern. Vielen Dank!'**
  String get pre_rating_message;

  /// No description provided for @pre_rating_title.
  ///
  /// In de, this message translates to:
  /// **'Gefällt dir die App?'**
  String get pre_rating_title;

  /// No description provided for @privacy_policy.
  ///
  /// In de, this message translates to:
  /// **'Datenschutzerklärung'**
  String get privacy_policy;

  /// No description provided for @received_cabo_penalties.
  ///
  /// In de, this message translates to:
  /// **'Erhaltene Cabo-Strafen'**
  String get received_cabo_penalties;

  /// No description provided for @report_error.
  ///
  /// In de, this message translates to:
  /// **'Fehler melden'**
  String get report_error;

  /// No description provided for @reset.
  ///
  /// In de, this message translates to:
  /// **'Zurücksetzen'**
  String get reset;

  /// No description provided for @reset_config_message.
  ///
  /// In de, this message translates to:
  /// **'Möchtest du deine Einstellungen zurücksetzen?'**
  String get reset_config_message;

  /// No description provided for @reset_config_title.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen zurücksetzen'**
  String get reset_config_title;

  /// No description provided for @reset_to_default.
  ///
  /// In de, this message translates to:
  /// **'Auf Standard zurücksetzen'**
  String get reset_to_default;

  /// No description provided for @results.
  ///
  /// In de, this message translates to:
  /// **'Ergebnisse'**
  String get results;

  /// No description provided for @rotate_dealer.
  ///
  /// In de, this message translates to:
  /// **'Mischer:in rotieren'**
  String get rotate_dealer;

  /// No description provided for @rotate_dealer_info.
  ///
  /// In de, this message translates to:
  /// **'Standardmäßig mischt die Person, welche die letzte Runde verloren hat. Aktiviere diese Option um die Rolle jede Runde in Spielreihenfolge zu rotieren.'**
  String get rotate_dealer_info;

  /// No description provided for @round.
  ///
  /// In de, this message translates to:
  /// **'Runde'**
  String get round;

  /// No description provided for @rounds.
  ///
  /// In de, this message translates to:
  /// **'Runden'**
  String get rounds;

  /// No description provided for @rounds_won.
  ///
  /// In de, this message translates to:
  /// **'Gewonnene Runden'**
  String get rounds_won;

  /// No description provided for @score_table.
  ///
  /// In de, this message translates to:
  /// **'Punktetabelle'**
  String get score_table;

  /// No description provided for @settings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settings;

  /// No description provided for @sort_by.
  ///
  /// In de, this message translates to:
  /// **'Sortieren nach'**
  String get sort_by;

  /// No description provided for @sort_order.
  ///
  /// In de, this message translates to:
  /// **'Reihenfolge'**
  String get sort_order;

  /// No description provided for @standard_game_title.
  ///
  /// In de, this message translates to:
  /// **'Spiel vom {date}'**
  String standard_game_title(Object date);

  /// No description provided for @standard_mode.
  ///
  /// In de, this message translates to:
  /// **'Standard-Modus'**
  String get standard_mode;

  /// No description provided for @statistics.
  ///
  /// In de, this message translates to:
  /// **'Statistiken'**
  String get statistics;

  /// No description provided for @submit.
  ///
  /// In de, this message translates to:
  /// **'Bestätigen'**
  String get submit;

  /// No description provided for @support_me.
  ///
  /// In de, this message translates to:
  /// **'Unterstütze mich'**
  String get support_me;

  /// No description provided for @unlimited.
  ///
  /// In de, this message translates to:
  /// **'Unbegrenzt'**
  String get unlimited;

  /// No description provided for @unlimited_description.
  ///
  /// In de, this message translates to:
  /// **'Es wird so lange gespielt, bis ihr keine Lust mehr habt. Das Spiel kann jederzeit manuell beendet werden.'**
  String get unlimited_description;

  /// No description provided for @version.
  ///
  /// In de, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @whats_new.
  ///
  /// In de, this message translates to:
  /// **'Was ist Neu?'**
  String get whats_new;

  /// No description provided for @who_has_kamikaze.
  ///
  /// In de, this message translates to:
  /// **'Wer hat Kamikaze?'**
  String get who_has_kamikaze;

  /// No description provided for @who_said_cabo.
  ///
  /// In de, this message translates to:
  /// **'Wer hat CABO gesagt?'**
  String get who_said_cabo;

  /// No description provided for @yes.
  ///
  /// In de, this message translates to:
  /// **'Ja'**
  String get yes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
