import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/views/about/licenses/oss_licenses.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class LicenseTile extends StatefulWidget {
  const LicenseTile({super.key, required this.package, required this.onTap});

  final Package package;
  final VoidCallback onTap;

  @override
  State<LicenseTile> createState() => _LicenseTileState();
}

class _LicenseTileState extends State<LicenseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        VibrationService.selectionClick();
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        decoration: BoxDecoration(
          color: CustomTheme.mainElementColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  AppIcon(
                    AppIcons.license,
                    size: 28,
                    color: CustomTheme.primaryColor,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.package.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: CustomTheme.textColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            // Version
                            if (widget.package.version != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF202020),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  widget.package.version!,
                                  style: TextStyle(
                                    color: CustomTheme.hintTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(
                            widget.package.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppIcon(
              AppIcons.chevron,
              size: 17,
              color: CustomTheme.hintTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
