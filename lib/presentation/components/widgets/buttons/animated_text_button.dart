import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class AnimtedTextButton extends StatefulWidget {
  const AnimtedTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  State<AnimtedTextButton> createState() => _AnimtedTextButtonState();
}

class _AnimtedTextButtonState extends State<AnimtedTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    return ScaleTransition(
      scale: scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          animationController.forward();
        },
        onTapUp: (_) async {
          await animationController.reverse();
          if (mounted && enabled) {
            VibrationService.selectionClick();
            widget.onPressed!();
          }
        },
        onTapCancel: () {
          animationController.reverse();
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: enabled
                    ? CustomTheme.white
                    : CustomTheme.white.withAlpha(128),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
