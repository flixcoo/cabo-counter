import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

/// A pressable, animated action button used inside [CustomPopup].
class CustomPopupAction<T> extends StatefulWidget {
  const CustomPopupAction({
    required this.label,
    this.icon,
    this.style = CustomPopupActionStyle.primary,
    this.isDestructive = false,
    this.isEmphasized = false,
    this.returnValue,
    this.onPressed,
  });

  final String label;
  final IconData? icon;
  final CustomPopupActionStyle style;
  final bool isDestructive;
  final bool isEmphasized;
  final T? returnValue;
  final VoidCallback? onPressed;

  @override
  State<CustomPopupAction<T>> createState() => _CustomPopupActionState<T>();
}

class _CustomPopupActionState<T> extends State<CustomPopupAction<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 50),
    vsync: this,
  );
  late final Animation<double> _scale = Tween<double>(
    begin: 1.0,
    end: 0.95,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get backgroundColor {
    if (widget.isDestructive) return CustomTheme.red;

    switch (widget.style) {
      case CustomPopupActionStyle.primary:
        return widget.isEmphasized
            ? CustomTheme.primaryColor
            : CustomTheme.white;
      case CustomPopupActionStyle.secondary:
        return Colors.transparent;
    }
  }

  Color get foregroundColor {
    if (widget.isDestructive) return CustomTheme.textColor;
    if (widget.isEmphasized) return CustomTheme.textColor;

    switch (widget.style) {
      case CustomPopupActionStyle.primary:
        return Colors.black;
      case CustomPopupActionStyle.secondary:
        return CustomTheme.textColor;
    }
  }

  Color get borderColor {
    switch (widget.style) {
      case CustomPopupActionStyle.secondary:
        if (widget.isDestructive) return CustomTheme.red;
        if (widget.isEmphasized)
          return CustomTheme.primaryColor;
        else
          return CustomTheme.white;
      case CustomPopupActionStyle.primary:
        return backgroundColor;
    }
  }

  void handleTap() {
    VibrationService.selectionClick();
    Navigator.of(context).pop(widget.returnValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPressed?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) async {
          await _controller.reverse();
          if (mounted) handleTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: 2,
              color: borderColor,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                AppIcon(widget.icon!, color: foregroundColor, size: 20),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 16,
                    fontWeight: widget.style == CustomPopupActionStyle.primary
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
