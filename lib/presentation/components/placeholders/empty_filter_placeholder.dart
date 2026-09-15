import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/opacity_button.dart';
import 'package:flutter/cupertino.dart';

/// A placeholder for the [MainMenuView] when the filter does not return any games
class EmptyFilterPlaceholder extends StatelessWidget {
  final void Function() toggleShowOnlyActiveGames;

  const EmptyFilterPlaceholder({
    super.key,
    required this.toggleShowOnlyActiveGames,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Center(
          child: AppIcon(
            AppIcons.visibility_off,
            size: 60,
            color: CustomTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Text(
            loc.empty_filter_text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        OpacityButton.text(
          onPressed: () => toggleShowOnlyActiveGames(),
          text: loc.empty_filter_button,
        ),
      ],
    );
  }
}
