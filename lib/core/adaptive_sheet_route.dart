import 'dart:io';

import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cupertino_ui/cupertino_ui.dart';

Route<T> adaptiveSheetRoute<T>({required WidgetBuilder builder}) {
  if (Platform.isIOS) {
    return CupertinoSheetRoute(
      scrollableBuilder: (context, controller) => builder(context),
    );
  } else {
    return adaptivePageRoute(fullscreenDialog: true, builder: builder);
  }
}
