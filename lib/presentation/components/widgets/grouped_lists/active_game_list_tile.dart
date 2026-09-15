import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';

class ActiveGameListTile extends StatefulWidget {
  const ActiveGameListTile({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  });

  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  State<ActiveGameListTile> createState() => _ActiveGameListTileState();
}

class _ActiveGameListTileState extends State<ActiveGameListTile> {
  bool isPressed = false;
  bool isDisabled = false;
  bool showDisabled = false;

  double get effectiveOpacity {
    if (isPressed) return 0.6;
    if (showDisabled && isDisabled) return 0.3;
    return 1.0;
  }

  @override
  Widget build(BuildContext context) {
    isDisabled = widget.onTap == null;
    showDisabled = widget.trailing == null;

    return GestureDetector(
      onTapDown: isDisabled
          ? null
          : (_) {
              setState(() => isPressed = true);
            },
      onTapUp: (_) async {
        await Future.delayed(const Duration(milliseconds: 250));
        setState(() => isPressed = false);
      },
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () {
        if (widget.onTap != null) {
          VibrationService.selectionClick();
          widget.onTap!.call();
        }
      },
      child: AnimatedOpacity(
        opacity: effectiveOpacity,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: CustomTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.title,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                spacing: 12,
                children: [
                  if (widget.trailing != null) widget.trailing!,
                  if (widget.showChevron)
                    AppIcon(
                      AppIcons.chevron,
                      size: 17,
                      color: CustomTheme.hintTextColor,
                    )
                  else
                    // A little more space to the right when no chevron is shown
                    const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
