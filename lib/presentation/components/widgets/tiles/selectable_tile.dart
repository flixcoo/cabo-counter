import 'dart:async';

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

/// A simple tile with a selection animation
///
/// - [title]: The primary label of the tile.
/// - [icon]: Optional leading icon.
/// - [selected]: Whether the tile is currently selected.
/// - [onTap]: Called when the tile is tapped.
/// - [selectionColor]: The color used for the selected tint, border and icon.
/// - [selectedTintAlpha]: Alpha of the accent tint when selected.
class SelectableTile extends StatefulWidget {
  const SelectableTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    required this.selectionColor,
    this.icon,
    this.description,
    this.selectedTintAlpha = 40,
    this.centerContent = false,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Color selectionColor;
  final int selectedTintAlpha;
  final bool centerContent;

  @override
  State<SelectableTile> createState() => _SelectableTileState();
}

class _SelectableTileState extends State<SelectableTile> {
  bool isPressed = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final centerContent = widget.centerContent;

    final Color backgroundColor = selected
        ? Color.alphaBlend(
            widget.selectionColor.withAlpha(widget.selectedTintAlpha),
            CustomTheme.tileColor,
          )
        : CustomTheme.tileColor;

    return GestureDetector(
      onTap: () => {VibrationService.selectionClick(), widget.onTap?.call()},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? widget.selectionColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          spacing: 6,
          crossAxisAlignment: centerContent
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: centerContent
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              spacing: 10,
              children: [
                if (widget.icon != null) ...[
                  AppIcon(widget.icon!, color: widget.selectionColor, size: 22),
                ],
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: widget.icon == null ? 17 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: TextStyle(
                  color: CustomTheme.textColor.withAlpha(150),
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
