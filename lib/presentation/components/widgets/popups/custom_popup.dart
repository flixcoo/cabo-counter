import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup_action.dart';
import 'package:flutter/material.dart';

class CustomPopup<T> extends StatelessWidget {
  /// A custom popup dialog.
  ///
  /// - [title]: The title shown in the popup
  /// - [actions]: [CustomPopupAction]s for the popup
  /// - [message]: An optional message shown.
  /// - [icon]: An optional icon shown.
  /// - [iconColor]: The color for the icon and the icon background.
  const CustomPopup({
    super.key,
    required this.title,
    required this.actions,
    this.message,
    this.icon,
    this.iconColor,
  });

  final String title;
  final List<CustomPopupAction<T>> actions;
  final String? message;
  final IconData? icon;
  final Color? iconColor;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<CustomPopupAction<T>> actions,
    String? message,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withAlpha(140),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, _, _) => CustomPopup<T>(
        title: title,
        message: message,
        icon: icon,
        iconColor: iconColor,
        actions: actions,
      ),
      transitionBuilder: (context, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = iconColor ?? CustomTheme.primaryColor;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: CustomTheme.mainElementColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: CustomTheme.white.withAlpha(12)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (icon != null) ...[
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: accent.withAlpha(38),
                          shape: BoxShape.circle,
                        ),
                        child: AppIcon(icon!, color: accent, size: 30),
                      ),
                    ),
                  ],
                  Column(
                    spacing: 10,
                    children: [
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: CustomTheme.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Message
                      if (message != null) ...[
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CustomTheme.subtitleColor,
                            fontSize: 15,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Actions
                  Column(
                    spacing: 10,
                    children: [
                      for (int i = 0; i < actions.length; i++) ...[actions[i]],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
