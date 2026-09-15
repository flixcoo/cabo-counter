import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';

class HapticBackButton extends StatefulWidget {
  const HapticBackButton({super.key});

  @override
  State<HapticBackButton> createState() => _HapticBackButtonState();
}

class _HapticBackButtonState extends State<HapticBackButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      icon: AppIcons.back,
      onPressed: () async {
        VibrationService.selectionClick();
        Navigator.of(context).maybePop();
      },
    );
  }
}
