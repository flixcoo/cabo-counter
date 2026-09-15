import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_text_button.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/selectable_tile.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

/// A bottom sheet for selecting the player who has Kamikaze.
///
/// - [gameSession]: The current game session.
class KamikazeSheet extends StatefulWidget {
  final GameSessionController gameSession;

  const KamikazeSheet({super.key, required this.gameSession});

  /// Displays the Kamikaze bottom sheet and returns the selected player index,
  /// or `null` if the sheet was dismissed.
  static Future<int?> show(
    BuildContext context,
    GameSessionController gameSession,
  ) async {
    return await showModalBottomSheet<int?>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KamikazeSheet(gameSession: gameSession),
    );
  }

  @override
  State<KamikazeSheet> createState() => _KamikazeSheetState();
}

class _KamikazeSheetState extends State<KamikazeSheet> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomTheme.mainElementColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: CustomTheme.subtitleColor.withAlpha(120),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              // Title
              Column(
                spacing: 4,
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: CustomTheme.kamikazeColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AppIcon(
                        AppIcons.kamikaze,
                        color: CustomTheme.kamikazeColor,
                        size: 30,
                      ),
                    ),
                  ),

                  // Title
                  Text(
                    loc.kamikaze,
                    style: const TextStyle(
                      color: CustomTheme.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Description
                  Text(
                    loc.who_has_kamikaze,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CustomTheme.subtitleColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              // Player
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...widget.gameSession.players.asMap().entries.map((
                        entry,
                      ) {
                        return SelectableTile(
                          title: entry.value.name,
                          selectionColor: CustomTheme.kamikazeColor,
                          selectedTintAlpha: 45,
                          selected: selectedIndex == entry.key,
                          onTap: () {
                            VibrationService.selectionClick();
                            setState(() => selectedIndex = entry.key);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Submit
              AnimtedTextButton(
                text: loc.submit,
                onPressed: selectedIndex == null
                    ? null
                    : () {
                        VibrationService.mediumImpact();
                        Navigator.of(context).pop(selectedIndex);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
