import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/data/dto/news_item.dart';

final localizedNews = [
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
