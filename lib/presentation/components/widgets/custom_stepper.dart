import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/opacity_button.dart';
import 'package:flutter/cupertino.dart'; // Für iOS-Style

/// A custom stepper widget for incrementing and decrementing a value.
///
/// The [CustomStepper] widget allows increasing and decreasing a value
/// within a defined range ([minValue] to [maxValue]) in fixed steps.
///
/// Properties:
/// - [minValue]: The minimum value.
/// - [maxValue]: The maximum value.
/// - [initialValue]: The initial value (optional, defaults to [minValue]).
/// - [step]: The step size.
/// - [onChanged]: Callback triggered when the value changes.
class CustomStepper extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int? initialValue;
  final int step;
  final ValueChanged<int> onChanged;
  const CustomStepper({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.onChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    final start = widget.initialValue ?? widget.minValue;
    _value = start.clamp(widget.minValue, widget.maxValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OpacityButton.icon(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          onPressed: _decrement,
          icon: AppIcons.minus,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            '$_value',
            style: const TextStyle(fontSize: 18, color: CustomTheme.white),
          ),
        ),
        OpacityButton.icon(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          onPressed: _increment,
          icon: AppIcons.add,
        ),
      ],
    );
  }

  void _increment() {
    if (_value + widget.step <= widget.maxValue) {
      setState(() {
        _value += widget.step;
        widget.onChanged.call(_value);
      });
    }
  }

  void _decrement() {
    if (_value - widget.step >= widget.minValue) {
      setState(() {
        _value -= widget.step;
        widget.onChanged.call(_value);
      });
    }
  }
}
