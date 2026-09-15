import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';

class NewsItem {
  final Map<String, String> localizedTitle;
  final Map<String, String> localizedText;
  final AppIcon icon;

  NewsItem({
    required this.localizedTitle,
    required this.localizedText,
    required this.icon,
  }) {
    for (final locale in AppLocalizations.supportedLocales.map(
      (e) => e.languageCode,
    )) {
      assert(
        localizedTitle[locale]?.isNotEmpty ?? false,
        'NewsItem is missing a title for locale "$locale"',
      );
      assert(
        localizedText[locale]?.isNotEmpty ?? false,
        'NewsItem is missing a text for locale "$locale"',
      );
    }
  }
}
