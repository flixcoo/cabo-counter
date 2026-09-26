import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:cupertino_ui/cupertino_ui.dart';

class AddPlayerButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AddPlayerButton({required this.onPressed});

  @override
  State<AddPlayerButton> createState() => _AddPlayerButtonState();
}

class _AddPlayerButtonState extends State<AddPlayerButton> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        VibrationService.selectionClick();
        widget.onPressed();
      },
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: CustomTheme.tileColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(IconService.add, size: 20, color: CustomTheme.primaryColor),
            const SizedBox(width: 8),
            Text(
              loc.add_player,
              style: const TextStyle(
                color: CustomTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
