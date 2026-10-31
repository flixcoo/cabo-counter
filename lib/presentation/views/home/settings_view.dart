import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/import_result.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/adaptive_switch.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_stepper.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/custom_form_row.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/custom_form_section.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup_action.dart';
import 'package:cabo_counter/presentation/views/home/create_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:material_ui/material_ui.dart';
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
                    prefixIcon: AppIcons.cabo_penalty,
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
                    prefixIcon: AppIcons.point_limit,
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
                    prefixIcon: AppIcons.mode,
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
                    prefixIcon: AppIcons.shuffle_cards,
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
                    prefixIcon: AppIcons.reset,
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
                    prefixIcon: AppIcons.export,
                    onPressed: () =>
                        DataTransferService.exportGameData(context),
                  ),

                  // Import data
                  CustomFormRow(
                    prefixText: loc.import_data,
                    prefixIcon: AppIcons.import,
                    onPressed: () async {
                      final result = await DataTransferService.importJsonFile(
                        context,
                      );
                      widget.onSessionsUpdated.call();
                      if (mounted) showImportFeedbackDialog(result);
                    },
                  ),

                  // Delete data
                  CustomFormRow(
                    prefixText: loc.delete_data,
                    prefixIcon: AppIcons.delete,
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
                    prefixIcon: AppIcons.vibration,
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
                    prefixIcon: AppIcons.e_mail,
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                    ),
                  ),

                  // Report error
                  CustomFormRow(
                    prefixText: loc.report_error,
                    prefixIcon: AppIcons.brand_github,
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_ISSUE_LINK)),
                  ),

                  // Version
                  CustomFormRow(
                    prefixText: loc.version,
                    prefixIcon: AppIcons.version,
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
                    prefixIcon: AppIcons.number,
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
      icon: AppIcons.delete,
      iconColor: CustomTheme.red,
      title: loc.delete_data_title,
      message: loc.delete_data_message,
      actions: dialogActions,
    );
  }

  /// Displays a feedback dialog for import operations based on the [ImportResult].
  /// If the import was canceled, no dialog is shown. If duplicates were found,
  /// the user is asked whether the local games should be overwritten.
  void showImportFeedbackDialog(ImportResult result) {
    final status = result.status;
    if (status == ImportStatus.canceled) return;
    if (status == ImportStatus.duplicatesFound) {
      showImportDuplicatesPopup(result);
      return;
    }

    final (title, message) = getDialogContent(result);
    final success = result.status == ImportStatus.success;

    final IconData icon;
    final Color iconColor;

    if (success) {
      icon = AppIcons.success;
      iconColor = CustomTheme.primaryColor;
      VibrationService.successNotification();
    } else {
      icon = AppIcons.error;
      iconColor = CustomTheme.red;
      VibrationService.errorNotification();
    }

    PopupService.showInfoPopup(
      context: context,
      icon: icon,
      iconColor: iconColor,
      title: title,
      message: message,
    );
  }

  /// Shows a popup listing the imported games that already exist locally and
  /// lets the user decide whether to overwrite the local games with them.
  Future<void> showImportDuplicatesPopup(ImportResult result) async {
    final loc = AppLocalizations.of(context);

    const displayedGamesAmount = 3;

    final duplicateGamesAmount = result.duplicates.length;
    final allGamesAmount = result.importedAmount + duplicateGamesAmount;
    final hiddenGamesAmount = duplicateGamesAmount - displayedGamesAmount;
    final hiddenGamesText = hiddenGamesAmount > 0
        ? loc.import_more_games(hiddenGamesAmount)
        : '';

    VibrationService.warningNotification();
    final shouldOverwrite =
        await PopupService.showSelectionPopup<bool>(
          context: context,
          icon: AppIcons.duplicate,
          iconColor: CustomTheme.kamikazeColor,
          title: loc.import_duplicates_title,
          content: Column(
            spacing: 20,
            children: [
              Text(
                loc.import_new_games_message(
                  allGamesAmount,
                  result.importedAmount,
                  duplicateGamesAmount,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final game in result.duplicates.take(
                    displayedGamesAmount,
                  ))
                    Text(
                      game.title.trim(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 14),
                    ),
                  if (hiddenGamesText.isNotEmpty)
                    Text(
                      hiddenGamesText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomTheme.textColor.withAlpha(150),
                      ),
                    ),
                ],
              ),
              Text(loc.overwrite_games_message(duplicateGamesAmount)),
            ],
          ),
          actions: [
            CustomPopupAction(
              label: loc.overwrite,
              isDestructive: true,
              returnValue: true,
            ),
            CustomPopupAction(
              label: loc.skip,
              style: CustomPopupActionStyle.secondary,
              returnValue: false,
            ),
          ],
        ) ??
        false;
    if (!shouldOverwrite || !mounted) return;

    final success = await DataTransferService.overwriteGameSessionsInDb(
      context,
      result.duplicates,
    );
    widget.onSessionsUpdated.call();

    if (!mounted) return;
    showImportFeedbackDialog(
      ImportResult(
        status: success ? ImportStatus.success : ImportStatus.genericError,
      ),
    );
  }

  /// Returns the dialog title and message based on the [ImportResult].
  /// [result] The result of the import operation.
  /// Returns a tuple containing the title and message for the dialog.
  (String, String) getDialogContent(ImportResult result) {
    final loc = AppLocalizations.of(context);
    switch (result.status) {
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

      // Canceled imports show no dialog and
      // duplicates are handled by [showImportDuplicatesPopup].
      case ImportStatus.canceled:
      case ImportStatus.duplicatesFound:
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
      icon: AppIcons.reset,
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
