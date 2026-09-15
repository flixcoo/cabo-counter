import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/news_item.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({required this.newsItem, super.key});

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context).localeName;
    final title =
        newsItem.localizedTitle[locale] ?? newsItem.localizedTitle['en']!;
    final text =
        newsItem.localizedText[locale] ?? newsItem.localizedText['en']!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
        // Icon
        SizedBox(width: 50, child: Center(child: newsItem.icon)),

        // Text
        Expanded(
          child: Column(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Text
              Text(
                text,
                style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
