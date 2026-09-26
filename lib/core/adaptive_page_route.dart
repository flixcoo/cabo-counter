import 'dart:io';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

/// Returns a platform-adaptive page route based on the current platform.
/// - On iOS, it returns a [CupertinoPageRoute].
/// - On other platforms, it returns a [MaterialPageRoute].
Route<T> adaptivePageRoute<T>({
  required Widget Function(BuildContext) builder,
  bool fullscreenDialog = false,
  RouteSettings? settings,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute<T>(
      settings: settings,
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
  return MaterialPageRoute<T>(
    settings: settings,

    builder: builder,
    fullscreenDialog: fullscreenDialog,
  );
}
