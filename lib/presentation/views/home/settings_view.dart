import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/adaptive_switch.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup_action.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_form_row.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_form_section.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_stepper.dart';
import 'package:cabo_counter/presentation/views/home/create_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Settings and information page for the app.
///
/// [SettingsView] is a settings page for the app, allowing users to configure game options,
/// manage game data (import, export, delete), and view app information.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.onSessionsUpdated});

  final VoidCallback onSessionsUpdated;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  UniqueKey stepperKey1 = UniqueKey();
  UniqueKey stepperKey2 = UniqueKey();
  GameMode defaultMode = ConfigService.getGameMode();
  bool rotateShuffler = ConfigService.getRotateShuffler();
  bool enableVibrations = ConfigService.getVibrationsEnabled();
  int pointLimit = ConfigService.getPointLimit();
  int caboPenalty = ConfigService.getCaboPenalty();

  String get defaultModeString {
    final loc = AppLocalizations.of(context);
    switch (defaultMode) {
      case GameMode.none:
        return loc.no_default_mode;
      case GameMode.pointLimit:
        return getPointLabel(loc, pointLimit);
      case GameMode.unlimited:
        return loc.unlimited;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Points section
              CustomFormSection(
                title: loc.points,
                infoText: loc.rotate_dealer_info,
                rows: [
                  // Cabo penalty
                  CustomFormRow(
                    prefixText: loc.cabo_penalty,
                    prefixIcon: IconService.cabo_penalty,
                    showChevron: false,
                    suffixWidget: CustomStepper(
                      key: stepperKey1,
                      initialValue: ConfigService.getCaboPenalty(),
                      minValue: 0,
                      maxValue: 50,
                      step: 1,
                      onChanged: (newCaboPenalty) {
                        setState(() {
                          ConfigService.setCaboPenalty(newCaboPenalty);
                        });
                      },
                    ),
                  ),

                  // Point limit
                  CustomFormRow(
                    prefixText: loc.point_limit,
                    prefixIcon: IconService.point_limit,
                    showChevron: false,
                    suffixWidget: CustomStepper(
                      key: stepperKey2,
                      initialValue: ConfigService.getPointLimit(),
                      minValue: 30,
                      maxValue: 1000,
                      step: 10,
                      onChanged: (newPointLimit) {
                        setState(() => pointLimit = newPointLimit);
                        ConfigService.setPointLimit(newPointLimit);
                      },
                    ),
                  ),

                  // Standard mode
                  CustomFormRow(
                    prefixText: loc.standard_mode,
                    prefixIcon: IconService.mode,
                    suffixWidget: Text(
                      defaultModeString,
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    onPressed: () async {
                      final selectedMode = await Navigator.push(
                        context,
                        adaptivePageRoute(
                          builder: (context) => ModeSelectionView(
                            pointLimit: ConfigService.getPointLimit(),
                            showDeselection: true,
                            initialSelectedGameMode: defaultMode,
                          ),
                        ),
                      );
                      setState(() {
                        defaultMode = selectedMode ?? GameMode.none;
                      });
                      ConfigService.setGameMode(defaultMode);
                    },
                  ),

                  // Rotate dealer
                  CustomFormRow(
                    prefixText: loc.rotate_dealer,
                    prefixIcon: IconService.shuffle_cards,
                    onPressed: () => toggleShuffler(!rotateShuffler),
                    suffixWidget: AdaptiveSwitch(
                      value: rotateShuffler,
                      onChanged: (bool value) => toggleShuffler(value),
                    ),
                    showChevron: false,
                  ),
                ],
              ),

              // Reset config
              CustomFormSection(
                infoText: loc.config_change_info,
                rows: [
                  CustomFormRow(
                    prefixText: loc.reset_to_default,
                    prefixIcon: IconService.reset,
                    onPressed: () => showResetConfirmPopup(),
                  ),
                ],
              ),

              // Game data section
              CustomFormSection(
                title: loc.game_data,
                rows: [
                  // Export data
                  CustomFormRow(
                    prefixText: loc.export_data,
                    prefixIcon: IconService.export,
                    onPressed: () =>
                        DataTransferService.exportGameData(context),
                  ),

                  // Import data
                  CustomFormRow(
                    prefixText: loc.import_data,
                    prefixIcon: IconService.import,
                    onPressed: () async {
                      final status = await DataTransferService.importJsonFile(
                        context,
                      );
                      if (mounted) showImportFeedbackDialog(status);
                      widget.onSessionsUpdated.call();
                    },
                  ),

                  // Delete data
                  CustomFormRow(
                    prefixText: loc.delete_data,
                    prefixIcon: IconService.delete,
                    showChevron: false,
                    onPressed: () => showDeleteAllGamesPopup(),
                  ),
                ],
              ),

              // App section
              CustomFormSection(
                title: loc.app,
                rows: [
                  // Mail developer
                  CustomFormRow(
                    prefixText: loc.haptic_feedback,
                    prefixIcon: IconService.vibration,
                    showChevron: false,
                    onPressed: () => toggleVibrations(!enableVibrations),
                    suffixWidget: AdaptiveSwitch(
                      value: enableVibrations,
                      onChanged: (bool value) => toggleVibrations(value),
                    ),
                  ),

                  // Mail developer
                  CustomFormRow(
                    prefixText: loc.mail_developer,
                    prefixIcon: IconService.e_mail,
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                    ),
                  ),

                  // Report error
                  CustomFormRow(
                    prefixText: loc.report_error,
                    prefixIcon: IconService.brand_github,
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_ISSUE_LINK)),
                  ),

                  // Version
                  CustomFormRow(
                    prefixText: loc.version,
                    prefixIcon: IconService.version,
                    suffixWidget: Text(
                      VersionService.getVersion(),
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    suffixPadding: 12,
                    showChevron: false,
                  ),

                  // Build number
                  CustomFormRow(
                    prefixText: loc.build,
                    prefixIcon: IconService.number,
                    onPressed: null,
                    suffixWidget: Text(
                      VersionService.getBuildNumber(),
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    suffixPadding: 12,
                    showChevron: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows a dialog to confirm the deletion of all game data.
  /// When confirmed, it deletes all game data from local storage.
  void showDeleteAllGamesPopup() {
    final loc = AppLocalizations.of(context);
    final db = Provider.of<AppDatabase>(context, listen: false);
    final dialogActions = [
      CustomPopupAction<void>(
        style: CustomPopupActionStyle.primary,
        isDestructive: true,
        onPressed: () async {
          await db.gameSessionDao.deleteAllGames();
          widget.onSessionsUpdated.call();
        },
        label: loc.delete,
      ),
      CustomPopupAction<void>(
        style: CustomPopupActionStyle.secondary,
        label: loc.cancel,
      ),
    ];

    VibrationService.warningNotification();
    PopupService.showSelectionPopup<void>(
      context: context,
      icon: Icons.delete_outline_rounded,
      iconColor: CustomTheme.red,
      title: loc.delete_data_title,
      message: loc.delete_data_message,
      actions: dialogActions,
    );
  }

  /// Displays a feedback dialog for import operations based on the [ImportStatus].
  /// If the import was canceled, no dialog is shown.
  void showImportFeedbackDialog(ImportStatus status) {
    if (status == ImportStatus.canceled) return;
    final (title, message) = getDialogContent(status);

    final icon = status == ImportStatus.success
        ? Icons.check_circle_outline_rounded
        : Icons.error_outline_rounded;
    final iconColor = status == ImportStatus.success
        ? CustomTheme.primaryColor
        : CustomTheme.red;

    VibrationService.errorNotification();
    PopupService.showInfoPopup(
      context: context,
      icon: icon,
      iconColor: iconColor,
      title: title,
      message: message,
    );
  }

  /// Returns the dialog title and message based on the [ImportStatus].
  /// [status] The status of the import operation.
  /// Returns a tuple containing the title and message for the dialog.
  (String, String) getDialogContent(ImportStatus status) {
    final loc = AppLocalizations.of(context);
    switch (status) {
      case ImportStatus.success:
        return (loc.import_success_title, loc.import_success_message);
      case ImportStatus.validationError:
        return (
          loc.import_validation_error_title,
          loc.import_validation_error_message,
        );

      case ImportStatus.formatError:
        return (loc.import_format_error_title, loc.import_format_error_message);
      case ImportStatus.genericError:
        return (
          loc.import_generic_error_title,
          loc.import_generic_error_message,
        );
      case ImportStatus.canceled:
        return ('', '');
    }
  }

  /// Shows a popup for the user to confirm the reset of their settings
  void showResetConfirmPopup() {
    final loc = AppLocalizations.of(context);
    final dialogActions = [
      CustomPopupAction<void>(
        style: CustomPopupActionStyle.primary,
        label: loc.reset,
        onPressed: () {
          ConfigService.resetUserConfig();
          setState(() {
            stepperKey1 = UniqueKey();
            stepperKey2 = UniqueKey();
            defaultMode = ConfigService.getGameMode();
            rotateShuffler = ConfigService.getRotateShuffler();
          });
        },
      ),
      CustomPopupAction<void>(
        style: CustomPopupActionStyle.secondary,
        label: loc.cancel,
      ),
    ];

    VibrationService.warningNotification();
    PopupService.showSelectionPopup<void>(
      context: context,
      icon: Icons.settings_backup_restore_rounded,
      title: loc.reset_config_title,
      message: loc.reset_config_message,
      actions: dialogActions,
    );
  }

  void toggleShuffler(bool newValue) {
    VibrationService.selectionClick();
    setState(() {
      ConfigService.setRotateShuffler(newValue);
      rotateShuffler = newValue;
    });
  }

  void toggleVibrations(bool newValue) {
    VibrationService.selectionClick();
    setState(() {
      ConfigService.setVibrationsEnabled(newValue);
      enableVibrations = newValue;
    });
  }
}
