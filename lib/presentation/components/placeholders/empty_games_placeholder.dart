import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/views/home/home_view.dart';
import 'package:flutter/cupertino.dart';

/// A placeholder for the [HomeView] when the app contains no games
class EmptyGamesPlaceholder extends StatelessWidget {
  const EmptyGamesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AppIcon(
            AppIcons.no_games,
            size: 60,
            color: CustomTheme.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            '${loc.no_games_created_yet}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
