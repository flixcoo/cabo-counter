import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:material_ui/material_ui.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.selected = false,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = selected
        ? Color.alphaBlend(
            CustomTheme.primaryColor.withAlpha(25),
            CustomTheme.mainElementColor,
          )
        : CustomTheme.tileColor;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          VibrationService.selectionClick();
          onTap?.call();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: selected ? CustomTheme.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                color: CustomTheme.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Description
            Text(
              description,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
