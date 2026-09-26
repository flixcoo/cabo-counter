import 'package:cabo_counter/core/custom_theme.dart';
import 'package:material_ui/material_ui.dart';

class AdaptiveSwitch extends StatefulWidget {
  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool) onChanged;

  @override
  State<AdaptiveSwitch> createState() => _AdaptiveSwitchState();
}

class _AdaptiveSwitchState extends State<AdaptiveSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      activeTrackColor: CustomTheme.primaryColor,
      inactiveThumbColor: Colors.white,
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
