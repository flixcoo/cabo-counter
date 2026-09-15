import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class AnimatedIconButton extends StatefulWidget {
  /// A simple icon button with a scale animation
  ///
  /// - [icon]: The icon to display in the button.
  /// - [onPressed]: The callback for when the button is pressed.
  const AnimatedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color = CustomTheme.primaryColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color color;

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onPressed != null;
    final bool applyPadding = widget.icon != AppIcons.back;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: isEnabled ? 1.0 : 0.3,
      child: GestureDetector(
        onTapDown: isEnabled ? (_) => setPressed(true) : null,
        onTapCancel: () => setPressed(false),
        onTapUp: (_) => setPressed(false),
        onTap: isEnabled
            ? () {
                VibrationService.selectionClick();
                widget.onPressed?.call();
              }
            : null,
        child: AnimatedScale(
          scale: isPressed ? 0.9 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            padding: applyPadding
                ? const EdgeInsets.symmetric(horizontal: 12.0)
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [AppIcon(widget.icon, size: 24, color: widget.color)],
            ),
          ),
        ),
      ),
    );
  }

  void setPressed(bool value) {
    if (isPressed != value) {
      setState(() => isPressed = value);
    }
  }
}
