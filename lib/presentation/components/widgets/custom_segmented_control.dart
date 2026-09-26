import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:material_ui/material_ui.dart';

/// A themed rebuild of Cupertino's segmented control.
///
/// The whole control is painted in [borderColor]; the individual segments are
/// laid on top with a [spacing] gap between them, so the transitions between
/// segments are completely filled with color.
class CustomSegmentedControl<T extends Object> extends StatelessWidget {
  const CustomSegmentedControl({
    super.key,
    required this.children,
    required this.groupValue,
    required this.onValueChanged,
  });

  final Map<T, Widget> children;
  final T? groupValue;
  final ValueChanged<T?> onValueChanged;

  @override
  Widget build(BuildContext context) {
    final entries = children.entries.toList();
    const Color selectedColor = CustomTheme.primaryColor;
    const Color unselectedColor = CustomTheme.backgroundColor;
    const Color borderColor = CustomTheme.primaryColor;
    const double borderWidth = 2;
    const double spacing = 2;
    const double borderRadius = 8;
    const Duration animationDuration = Duration(milliseconds: 200);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(borderWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            (borderRadius - borderWidth).clamp(0, borderRadius),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                for (int i = 0; i < entries.length; i++) ...[
                  if (i > 0) const SizedBox(width: spacing),
                  Expanded(
                    child: _Segment<T>(
                      value: entries[i].key,
                      selected: entries[i].key == groupValue,
                      selectedColor: selectedColor,
                      unselectedColor: unselectedColor,
                      animationDuration: animationDuration,
                      onTap: onValueChanged,
                      child: entries[i].value,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.value,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.animationDuration,
    required this.onTap,
    required this.child,
  });

  final T value;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final Duration animationDuration;
  final ValueChanged<T?> onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fillColor = selected ? selectedColor : unselectedColor;
    final textColor = selected ? unselectedColor : selectedColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapSegment,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        color: fillColor,
        child: AnimatedDefaultTextStyle(
          duration: animationDuration,
          curve: Curves.easeInOut,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          child: IconTheme.merge(
            data: IconThemeData(color: textColor),
            child: child,
          ),
        ),
      ),
    );
  }

  void onTapSegment() {
    VibrationService.selectionClick();
    selected ? onTap(null) : onTap(value);
  }
}
