import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class OpacityButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? darkenAmount;
  final EdgeInsetsGeometry? padding;
  final bool _isText;
  final bool _isIcon;

  const OpacityButton._({
    super.key,
    required this.child,
    required this.onPressed,
    this.darkenAmount,
    this.padding,
    required this._isText,
    required this._isIcon,
  });

  /// Creates an [OpacityButton] with text.
  factory OpacityButton.text({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    double? darkenAmount,
    EdgeInsetsGeometry? padding,
    TextStyle? style,
  }) {
    return OpacityButton._(
      key: key,
      onPressed: onPressed,
      darkenAmount: darkenAmount,
      padding: padding,
      isText: true,
      isIcon: false,
      child: Text(
        text,
        style: style ?? const TextStyle(color: CustomTheme.primaryColor),
      ),
    );
  }

  /// Creates an [OpacityButton] with an icon.
  factory OpacityButton.icon({
    Key? key,
    required IconData icon,
    required VoidCallback? onPressed,
    double? darkenAmount,
    EdgeInsetsGeometry? padding,
    double? size,
    Color? color,
  }) {
    return OpacityButton._(
      key: key,
      onPressed: onPressed,
      darkenAmount: darkenAmount,
      padding: padding,
      isText: false,
      isIcon: true,
      child: AppIcon(
        icon,
        size: size,
        color: color ?? CustomTheme.primaryColor,
      ),
    );
  }

  @override
  State<OpacityButton> createState() => _OpacityButtonState();
}

class _OpacityButtonState extends State<OpacityButton> {
  bool isPressed = false;
  double darkenAmount = 0.5;

  @override
  void initState() {
    super.initState();
    if (widget.darkenAmount != null && widget.darkenAmount! <= 0.5) {
      darkenAmount = widget.darkenAmount!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null;
    var effectiveChild = widget.child;
    final Widget darkChild;

    if (widget._isText && effectiveChild is Text) {
      darkChild = Text(
        effectiveChild.data!,
        style: (effectiveChild.style ?? const TextStyle()).copyWith(
          color: Colors.black,
        ),
      );
      if (isDisabled) {
        effectiveChild = Text(
          effectiveChild.data!,
          style: (effectiveChild.style ?? const TextStyle()).copyWith(
            color: CustomTheme.textColor,
          ),
        );
      }
    } else if (widget._isIcon && effectiveChild is AppIcon) {
      darkChild = AppIcon(
        effectiveChild.icon,
        color: Colors.black,
        size: effectiveChild.size,
      );
      if (isDisabled) {
        effectiveChild = AppIcon(
          effectiveChild.icon,
          color: CustomTheme.textColor,
          size: effectiveChild.size,
        );
      }
    } else {
      darkChild = const SizedBox.shrink();
    }

    return Opacity(
      opacity: isDisabled ? 0.3 : 1.0,
      child: GestureDetector(
        onTapDown: !isDisabled ? (_) => setState(() => isPressed = true) : null,
        onTapUp: (_) async => {
          await Future.delayed(const Duration(milliseconds: 100)),
          if (mounted) setState(() => isPressed = false),
        },
        onTap: () => {
          VibrationService.selectionClick(),
          widget.onPressed?.call(),
        },
        onTapCancel: !isDisabled
            ? () => setState(() => isPressed = false)
            : null,
        child: Stack(
          children: [
            Padding(
              padding:
                  widget.padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: effectiveChild,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: isPressed ? darkenAmount : 0.0,
              child: Padding(
                padding:
                    widget.padding ??
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: darkChild,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
