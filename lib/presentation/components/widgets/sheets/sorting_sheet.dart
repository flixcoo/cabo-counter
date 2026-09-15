import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_text_button.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/selectable_tile.dart';
import 'package:flutter/material.dart';

class SortingSheet extends StatefulWidget {
  /// A bottom sheet for sorting and filtering the game list.
  ///
  /// - [currentSortOption]: The currently selected sorting option.
  /// - [currentSortDirection]: The currently selected sorting direction.
  /// - [showOnlyActiveGames]: Whether only active games are shown.
  /// - [onOptionChanged]: Called when the sorting option changes.
  /// - [onDirectionChanged]: Called when the sorting direction changes.
  /// - [onFilterChanged]: Called when the active-only filter toggles.
  const SortingSheet({
    super.key,
    required this.currentSortOption,
    required this.currentSortDirection,
    required this.showOnlyActiveGames,
    required this.onOptionChanged,
    required this.onDirectionChanged,
    required this.onFilterChanged,
  });

  final SortOption currentSortOption;
  final SortDirection currentSortDirection;
  final bool showOnlyActiveGames;
  final ValueChanged<SortOption> onOptionChanged;
  final ValueChanged<SortDirection> onDirectionChanged;
  final VoidCallback onFilterChanged;

  /// Displays the sorting bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required SortOption currentSortOption,
    required SortDirection currentSortDirection,
    required bool showOnlyActiveGames,
    required ValueChanged<SortOption> onOptionChanged,
    required ValueChanged<SortDirection> onDirectionChanged,
    required VoidCallback onFilterChanged,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SortingSheet(
        currentSortOption: currentSortOption,
        currentSortDirection: currentSortDirection,
        showOnlyActiveGames: showOnlyActiveGames,
        onOptionChanged: onOptionChanged,
        onDirectionChanged: onDirectionChanged,
        onFilterChanged: onFilterChanged,
      ),
    );
  }

  @override
  State<SortingSheet> createState() => _SortingSheetState();
}

class _SortingSheetState extends State<SortingSheet> {
  late SortOption sortOption = widget.currentSortOption;
  late SortDirection sortDirection = widget.currentSortDirection;
  late bool showOnlyActiveGames = widget.showOnlyActiveGames;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomTheme.mainElementColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: CustomTheme.subtitleColor.withAlpha(120),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
                      // Sort Option
                      Column(
                        children: [
                          buildLabel(loc.sort_by),
                          Row(
                            spacing: 10,
                            children: [
                              // Sort by date
                              Expanded(
                                child: SelectableTile(
                                  icon: AppIcons.sort_by_date,
                                  title: loc.date,
                                  selectionColor: CustomTheme.primaryColor,
                                  selected: sortOption == SortOption.date,
                                  onTap: () => setState(
                                    () => sortOption = SortOption.date,
                                  ),
                                ),
                              ),

                              // Sort by name
                              Expanded(
                                child: SelectableTile(
                                  icon: AppIcons.sort_by_name,
                                  title: loc.game_name,
                                  selectionColor: CustomTheme.primaryColor,
                                  selected: sortOption == SortOption.title,
                                  onTap: () => setState(
                                    () => sortOption = SortOption.title,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Sort direction
                      Column(
                        children: [
                          buildLabel(loc.sort_order),
                          Row(
                            spacing: 10,
                            children: [
                              // Sort descending
                              Expanded(
                                child: SelectableTile(
                                  icon: AppIcons.sort_desc,
                                  title: loc.descending,
                                  selectionColor: CustomTheme.primaryColor,
                                  selected:
                                      sortDirection == SortDirection.descending,
                                  onTap: () => setState(
                                    () => sortDirection =
                                        SortDirection.descending,
                                  ),
                                ),
                              ),

                              // Sort ascending
                              Expanded(
                                child: SelectableTile(
                                  icon: AppIcons.sort_asc,
                                  title: loc.ascending,
                                  selectionColor: CustomTheme.primaryColor,
                                  selected:
                                      sortDirection == SortDirection.ascending,

                                  onTap: () => setState(
                                    () =>
                                        sortDirection = SortDirection.ascending,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Filter
                      Column(
                        children: [
                          buildLabel(loc.filter),
                          SelectableTile(
                            icon: AppIcons.visibility_off,
                            title: loc.only_active_game_title,
                            selectionColor: CustomTheme.primaryColor,
                            selected: showOnlyActiveGames,
                            onTap: () => setState(
                              () => showOnlyActiveGames = !showOnlyActiveGames,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Submit button
              AnimtedTextButton(
                text: loc.submit,
                onPressed: () => {
                  propagateChangedOptions(),
                  Navigator.pop(context),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void propagateChangedOptions() {
    if (showOnlyActiveGames != widget.showOnlyActiveGames) {
      widget.onFilterChanged();
    }
    if (sortDirection != widget.currentSortDirection) {
      widget.onDirectionChanged(sortDirection);
    }
    if (sortOption != widget.currentSortOption) {
      widget.onOptionChanged(sortOption);
    }
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: CustomTheme.subtitleColor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
