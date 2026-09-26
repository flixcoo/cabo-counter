import 'package:material_ui/material_ui.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// A utility class that holds constant values and configuration settings
/// used throughout the application, such as external links, email addresses,
/// and timing parameters for UI elements.
///
/// This class also provides an instance of [RateMyApp] for managing
/// in-app rating prompts.
class Constants {
  /// Indicates the current development phase of the app
  static const String appDevPhase = 'Stable';

  /// Links to various social media profiles and resources related to the app.
  /// URL to my Instagram profile
  static const String WEBSITE_LINK = 'https://felixkirchner.de';

  /// URL to my GitHub profile
  static const String GITHUB_LINK = 'https://github.felixkirchner.de';

  /// URL to the GitHub issues page for reporting bugs or requesting features.
  static const String GITHUB_ISSUE_LINK =
      'https://github.com/flixcoo/cabo-counter/issues';

  /// Official email address for user inquiries and support.
  static const String CONTACT_EMAIL = 'cabocounter@felixkirchner.de';

  /// URL to the app's privacy policy page.
  static const String PRIVACY_POLICY_LINK = 'https://cabocounter.app/privacy';

  /// URL to the app's imprint page, containing legal information.
  static const String LEGAL_LINK = 'https://cabocounter.app/legal';

  /// URL to my PayPal donation page for users who wish to support the app.
  static const String DONATE_LINK = 'https://www.paypal.me/flixcoo';

  /// Instance of [RateMyApp] configured to prompt users for app store ratings.
  static RateMyApp rateMyApp = RateMyApp(
    appStoreIdentifier: '6751843294',
    minDays: 14,
    remindDays: 28,
    minLaunches: 10,
    remindLaunches: 30,
  );

  /// Delay in milliseconds before a pop-up appears.
  static const int POP_UP_DELAY = 300;

  /// Delay in milliseconds before the round view appears after the previous one is closed.
  static const int ROUND_VIEW_DELAY = 600;

  /// Duration in milliseconds for the fade-in animation of texts.
  static const int FADE_IN_DURATION = 300;

  /// Duration in milliseconds for the keyboard to fully disappear.
  static const int KEYBOARD_DELAY = 300;

  /// Minimum duration in milliseconds that the skeleton screen should be displayed.
  static const int MINIMUM_SKELETON_SCREEN_DURATION = 500;

  /// Size of the icons used on the buttons in the nav bar.
  static const double NAVBAR_ICON_SIZE = 28.0;

  /// Standard divider widget for material bottom sheets.
  static const Widget BOTTOM_SHEET_DIVIDER = Divider(indent: 10, endIndent: 10);
}
