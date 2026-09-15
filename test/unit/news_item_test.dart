import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/news_view/news.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('News tests', () {
    test('Fallback news (english) are set', () {
      const fallbackLoc = 'en';
      expect(
        localizedNews,
        isNotEmpty,
        reason: 'News list is empty',
      );

      for (final entry in localizedNews) {
        expect(
          entry.localizedTitle[fallbackLoc],
          isNotNull,
          reason: 'Fallback news title for locale $fallbackLoc is null',
        );
        expect(
          entry.localizedTitle[fallbackLoc],
          isNotEmpty,
          reason: 'Fallback news title for locale $fallbackLoc is empty',
        );
        expect(
          entry.localizedText[fallbackLoc],
          isNotNull,
          reason: 'Fallback news text for locale $fallbackLoc is null',
        );
        expect(
          entry.localizedText[fallbackLoc],
          isNotEmpty,
          reason: 'Fallback news text for locale $fallbackLoc is empty',
        );
      }
    });

    test('For every locale there is a news', () {
      final loc = AppLocalizations.supportedLocales
          .map((e) => e.languageCode)
          .toList();
      for (final locale in loc) {
        for (final entry in localizedNews) {
          expect(
            entry.localizedTitle[locale],
            isNotNull,
            reason: 'News title for locale $locale is null',
          );
          expect(
            entry.localizedTitle[locale],
            isNotEmpty,
            reason: 'News title for locale $locale is empty',
          );
          expect(
            entry.localizedText[locale],
            isNotNull,
            reason: 'News text for locale $locale is null',
          );
          expect(
            entry.localizedText[locale],
            isNotEmpty,
            reason: 'News text for locale $locale is empty',
          );
        }
      }
    });
  });
}
