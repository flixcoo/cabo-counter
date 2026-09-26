import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

/// Handles the in-app rating and feedback flow.
class RatingService {
  /// Checks whether the rating dialog should be shown and, if so, starts the
  /// feedback dialog process after a short delay.
  static Future<void> maybeShowRatingDialog(BuildContext context) async {
    await Constants.rateMyApp.init();
    if (!Constants.rateMyApp.shouldOpenDialog) return;

    await Future.delayed(const Duration(milliseconds: Constants.POP_UP_DELAY));

    if (context.mounted) await _startFeedbackDialogProcess(context);
  }

  /// Handles the feedback dialog when the conditions for rating are met.
  /// It asks the user if they like the app and, based on their response, either
  /// opens the native rating dialog or an email client for feedback.
  static Future<void> _startFeedbackDialogProcess(BuildContext context) async {
    PreRatingDialogDecision preRatingDecision =
        await PopupService.showPreRatingDialog(context);
    BadRatingDialogDecision? badRatingDecision;

    // so that the bad rating dialog is not shown immediately
    await Future.delayed(const Duration(milliseconds: Constants.POP_UP_DELAY));

    switch (preRatingDecision) {
      case PreRatingDialogDecision.yes:
        if (context.mounted) Constants.rateMyApp.showStarRateDialog(context);
        break;
      case PreRatingDialogDecision.no:
        if (context.mounted)
          badRatingDecision = await PopupService.showBadRatingDialog(context);
        if (badRatingDecision == BadRatingDialogDecision.email)
          _openFeedbackEmail(context);
        break;
      case PreRatingDialogDecision.cancel:
    }
  }

  /// Opens the user's email client with a pre-filled feedback email.
  static void _openFeedbackEmail(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final emailSubject = loc.email_subject;
    final emailBody = loc.email_body;
    final emailUri = Uri(
      scheme: 'mailto',
      path: Constants.CONTACT_EMAIL,
      query:
          'subject=$emailSubject'
          '&body=$emailBody',
    );

    launchUrl(emailUri);
  }
}
