import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup_action.dart';
import 'package:flutter/material.dart';

class PopupService {
  /// Displays an informational pop-up with a title, message and a single
  /// confirming action, styled with the app's [CustomPopup] design.
  ///
  /// [title]: The headline of the pop-up.
  /// [message]: The message content of the pop-up.
  /// [icon]: Optional accent icon shown above the title.
  /// [onAfterPop]: Optional callback executed after the pop-up is dismissed.
  /// Returns a Future that completes when the dialog is dismissed.
  static Future<void> showInfoPopup({
    required BuildContext context,
    required String title,
    required String message,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onAfterPop,
  }) async {
    final loc = AppLocalizations.of(context);
    await CustomPopup.show<void>(
      context: context,
      title: title,
      message: message,
      icon: icon,
      iconColor: iconColor,
      actions: [
        CustomPopupAction<void>(
          label: loc.ok,
          style: CustomPopupActionStyle.primary,
          onPressed: onAfterPop,
        ),
      ],
    );
  }

  /// Displays a selection pop-up with a title, message and a list of actions,
  /// styled with the app's [CustomPopup] design.
  ///
  /// [title]: The headline of the pop-up.
  /// [message]: The message content of the pop-up.
  /// [actions]: The [CustomPopupAction]s available in the pop-up.
  /// [icon]: Optional accent icon shown above the title.
  /// Returns a Future that completes with the tapped action's value.
  static Future<T?> showSelectionPopup<T>({
    required BuildContext context,
    required String title,
    required String message,
    required List<CustomPopupAction<T>> actions,
    IconData? icon,
    Color? iconColor,
  }) async {
    return await CustomPopup.show<T>(
      context: context,
      title: title,
      message: message,
      icon: icon,
      iconColor: iconColor,
      actions: actions,
    );
  }

  /// Shows a dialog asking the user if they like the app.
  /// Returns the user's decision as enum [PreRatingDialogDecision].
  /// PreRatingDialogDecision.yes: User likes the app.
  /// PreRatingDialogDecision.no: User does not like the app.
  /// PreRatingDialogDecision.cancel: User cancels the dialog.
  static Future<PreRatingDialogDecision> showPreRatingDialog(
    BuildContext context,
  ) async {
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<PreRatingDialogDecision>(
          context: context,
          icon: Icons.favorite_rounded,
          title: loc.pre_rating_title,
          message: loc.pre_rating_message,
          actions: [
            CustomPopupAction(
              returnValue: PreRatingDialogDecision.yes,
              isEmphasized: true,
              label: loc.yes,
            ),
            CustomPopupAction(
              returnValue: PreRatingDialogDecision.no,
              label: loc.no,
            ),
            CustomPopupAction(
              returnValue: PreRatingDialogDecision.cancel,
              style: CustomPopupActionStyle.secondary,
              label: loc.cancel,
            ),
          ],
        ) ??
        PreRatingDialogDecision.cancel;
  }

  /// Shows a dialog asking the user for feedback if they do not like the app.
  /// Returns the user's decision as enum [BadRatingDialogDecision].
  /// BadRatingDialogDecision.email: User wants to send an email for feedback.
  /// BadRatingDialogDecision.cancel: User cancels the dialog.
  static Future<BadRatingDialogDecision> showBadRatingDialog(
    BuildContext context,
  ) async {
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<BadRatingDialogDecision>(
          context: context,
          icon: Icons.feedback_outlined,
          title: loc.bad_rating_title,
          message: loc.bad_rating_message,
          actions: [
            CustomPopupAction(
              label: loc.contact_email,
              returnValue: BadRatingDialogDecision.email,
            ),
            CustomPopupAction(
              label: loc.cancel,
              style: CustomPopupActionStyle.secondary,
              returnValue: BadRatingDialogDecision.cancel,
            ),
          ],
        ) ??
        BadRatingDialogDecision.cancel;
  }
}
