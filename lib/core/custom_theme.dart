import 'package:cabo_counter/presentation/components/widgets/buttons/haptic_back_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/haptic_close_button.dart';
import 'package:material_ui/material_ui.dart';

class CustomTheme {
  /* ===== Basic Colors ===== */

  /// Primary color of the app, used for buttons, highlights, and interactive elements
  static const Color primaryColor = Color(0xFF34C759);

  /// Primary white color mainly used for text
  static const Color white = Color(0xFFFFFFFF);

  /// Red color, typically used for destructive actions or error states
  static const Color red = Color(0xFFF44336);

  /* ===== Text Colors ===== */

  /// Standard text color used throughout the app for readability
  static const Color textColor = white;

  /// Color for hint text, such as in input fields or placeholders
  static Color hintTextColor = textColor.withAlpha(100);

  /// Subtitle text color, used for secondary information
  static const Color subtitleColor = Color(0xFF8E8E93);

  /* ===== UI Colors ===== */

  /// Background color for the main app scaffold and views
  static const Color backgroundColor = Color(0xFF101010);

  /// Background color for the navigation bar at the bottom of the app.
  static const Color navBarBackgroundColor = Color(0xFF161616);

  /// Background color for main UI elements like cards or containers.
  static const Color mainElementColor = Color(0xFF171717);

  /// Background color for settings tiles and list items.
  static const Color tileColor = Color(0xFF1C1C1E);

  /// Background color for buttons and interactive controls.
  static const Color buttonBackgroundColor = Color(0xFF202020);

  /// Color used to highlight the kamikaze button and players
  static const Color kamikazeColor = Color(0xFFFFD738);

  // Line Colors for GraphView
  static const Color graphColor1 = Color(0xFFF44336);
  static const Color graphColor2 = Color(0xFF2196F3);
  static const Color graphColor3 = Color(0xFFFFA726);
  static const Color graphColor4 = Color(0xFF9C27B0);
  static const Color graphColor5 = primaryColor;

  // Colors for PointsView
  /// Color used to indicate a loss of points in the UI.
  static Color pointLossColor = primaryColor;

  /// Color used to indicate a gain of points in the UI.
  static const Color pointGainColor = Color(0xFFF44336);

  /* ===== Text Styles ===== */

  /// Text style for titles of sections.
  static const TextStyle rowTitle = TextStyle(
    fontSize: 20,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  // ==================== Component Themes ====================
  static const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: textColor,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
    iconTheme: IconThemeData(color: primaryColor),
  );

  static final ActionIconThemeData actionIconTheme = ActionIconThemeData(
    backButtonIconBuilder: (context) => const HapticBackButton(),
    closeButtonIconBuilder: (context) => const HapticCloseButton(),
  );

  static const IconButtonThemeData iconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(CustomTheme.primaryColor),
    ),
  );

  static const TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 17)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
    ),
  );

  static const TextTheme textTheme = TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
  );
}
