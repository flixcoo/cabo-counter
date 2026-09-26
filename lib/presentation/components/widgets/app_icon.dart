// ignore_for_file: non_constant_identifier_names
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:material_ui/material_ui.dart';

/// Wrapper for Icons / SFIcons
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size, this.color});

  final IconData icon;
  final double? size;
  final Color? color;

  bool get _isSFSymbol => icon.fontPackage == 'flutter_sficon';

  @override
  Widget build(BuildContext context) {
    if (_isSFSymbol) {
      final iconTheme = IconTheme.of(context);
      return SFIcon(
        icon,
        fontSize: size ?? iconTheme.size ?? 24,
        color: color ?? iconTheme.color,
      );
    }
    return Icon(icon, size: size, color: color);
  }
}
