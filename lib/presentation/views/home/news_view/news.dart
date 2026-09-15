import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/news_item.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';

final localizedNews = [
  NewsItem(
    localizedTitle: {'de': 'Neues Design', 'en': 'New Design'},
    localizedText: {
      'de': 'Die App hat ein neues Design bekommen, mit überarbeiteten Elementen, Farben und einer teilweise neuer Anordnung. Schau dich gern um!',
      'en': 'The entire app has been redesigned, moving away from the iOS system design towards a distinct look of its own. Take a look around!',
    },
    icon: AppIcon(AppIcons.brush, color: CustomTheme.primaryColor),
  ),
  NewsItem(
    localizedTitle: {
      'de': 'Detaillierte Auswertung',
      'en': 'Detailed Analytics',
    },
    localizedText: {
      'de': 'Es gibt jetzt Auswertungen für jedes Spiel. Sie zeigt dir pro Spieler:in verschiedene Metriken an, mit welchen Ihr euch untereinander vergleichen könnt. Danke an Cameron für diesen Vorschlag!',
      'en': 'There are now statistics available for every game. They show you various metrics for each player, which you can use to compare yourselves with one another. Thanks to Cameron for this suggestion!',
    },
    icon: AppIcon(AppIcons.chart, color: CustomTheme.primaryColor),
  ),
  NewsItem(
    localizedTitle: {'de': 'Haptisches Feedback', 'en': 'Haptic Feedback'},
    localizedText: {
      'de': 'Die App wurde um haptisches Feedback ergänzt. Dieses kann in den Einstellungen deaktiviert werden.',
      'en': 'The app now includes haptic feedback. This can be disabled in the settings.',
    },
    icon: AppIcon(AppIcons.haptic_feedback, color: CustomTheme.primaryColor),
  ),
  NewsItem(
    localizedTitle: {
      'de': 'Cabo-Spieler:in wählen',
      'en': 'Select Cabo Player',
    },
    localizedText: {
      'de': 'Zu Beginn der Runde ist der/die Spieler:in, die Cabo angesagt hat, nun nicht mehr automatisch ausgewählt. Zudem kannst du die Auswahl jederzeit wieder aufheben.',
      'en': 'At the beginning of the round, the player who called Cabo is no longer automatically selected. You can also deselect the choice at any time.',
    },
    icon: AppIcon(AppIcons.players, color: CustomTheme.primaryColor),
  ),
  NewsItem(
    localizedTitle: {
      'de': 'Problem mit Kamikaze behoben',
      'en': 'Kamikaze Issue Fixed',
    },
    localizedText: {
      'de': 'Kamikaze addiert nun immer die Hälfte vom Punktelimit auf die Punktestände. Vorher wurde immer 50 Punkte addiert. Danke an Justus für den Hinweis!',
      'en': 'Kamikaze now always adds half of the point limit to the scores. Previously it always added 50 points. Thanks to Justus for the hint!',
    },
    icon: AppIcon(AppIcons.tool, color: CustomTheme.primaryColor),
  ),
];
