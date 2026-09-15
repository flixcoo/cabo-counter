import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';

class CustomFormRow extends StatefulWidget {
  const CustomFormRow({
    super.key,
    required this.prefixText,
    required this.prefixIcon,
    this.suffixWidget,
    this.onPressed,
    this.showChevron = true,
    this.suffixPadding = 8.0,
  });

  final String prefixText;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  final bool showChevron;
  final double suffixPadding;

  @override
  State<CustomFormRow> createState() => _CustomFormRowState();
}

class _CustomFormRowState extends State<CustomFormRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.onPressed != null) {
          VibrationService.selectionClick();
          widget.onPressed!.call();
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: widget.suffixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5,
                children: [
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: AppIcon(
                        widget.prefixIcon,
                        size: 22,
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                  ),
                  Text(widget.prefixText, style: const TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  widget.suffixWidget ?? const SizedBox.shrink(),
                  if (widget.showChevron) ...[
                    const SizedBox(width: 10),
                    AppIcon(
                      AppIcons.chevron,
                      color: CustomTheme.hintTextColor,
                      size: 17,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
