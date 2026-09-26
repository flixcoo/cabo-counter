import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

class HapticCloseButton extends StatefulWidget {
  const HapticCloseButton({super.key});

  @override
  State<HapticCloseButton> createState() => _HapticCloseButtonState();
}

class _HapticCloseButtonState extends State<HapticCloseButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      icon: IconService.close,
      onPressed: () async {
        VibrationService.selectionClick();
        Navigator.of(context).maybePop();
      },
    );
  }
}
