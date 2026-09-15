import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HapticCloseButton extends StatefulWidget {
  const HapticCloseButton({super.key});

  @override
  State<HapticCloseButton> createState() => _HapticCloseButtonState();
}

class _HapticCloseButtonState extends State<HapticCloseButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      icon: AppIcons.close,
      onPressed: () async {
        VibrationService.selectionClick();
        Navigator.of(context).maybePop();
      },
    );
  }
}
