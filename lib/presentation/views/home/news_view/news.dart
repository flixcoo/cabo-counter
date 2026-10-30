import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/data/dto/news_item.dart';

final localizedNews = [
  NewsItem(
    localizedTitle: {
      'de': 'Duplikate bei Import',
      'en': 'Duplicates on Import',
    },
    localizedText: {
      'de': 'Der Datenimport bricht bei bereits vorhandenen Spielen nicht mehr ab. Alle neuen Spiele werden importiert und für Spiele, die du bereits hast, kannst du entscheiden, ob deine lokalen Spiele überschrieben werden sollen.',
      'en': 'The data import no longer fails for games that already exist. All new games are imported, and for games you already have, you can choose whether to overwrite your local games.',
    },
    icon: AppIcons.duplicate,
  ),
  NewsItem(
    localizedTitle: {
      'de': 'Berechnung der Auswertung',
      'en': 'Evaluation Calculation',
    },
    localizedText: {
      'de': 'Es wurden Fehler bei Berechnung der detaillierten Auswertung behoben, die dazu geführt haben, das falsche Werte angezeigt wurden. Danke an Robin für den Hinweis!',
      'en': 'Errors in the calculation of the detailed analysis that caused incorrect values to be displayed have been fixed. Thanks to Robin for pointing this out!',
    },
    icon: AppIcons.chart,
  ),
];
