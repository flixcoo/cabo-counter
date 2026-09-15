import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/selectable_tile.dart';
import 'package:flutter/material.dart';

/// A stateless widget that displays a menu for selecting the game mode.
///
/// The [ModeSelectionView] allows the user to choose between different game modes:
/// - Point limit mode with a specified [pointLimit]
/// - Unlimited mode
/// - Optionally, no default mode if [showDeselection] is true
class ModeSelectionView extends StatefulWidget {
  const ModeSelectionView({
    super.key,
    required this.pointLimit,
    required this.showDeselection,
    this.initialSelectedGameMode,
  });

  final int pointLimit;
  final bool showDeselection;
  final GameMode? initialSelectedGameMode;

  @override
  State<ModeSelectionView> createState() => _ModeSelectionViewState();
}

class _ModeSelectionViewState extends State<ModeSelectionView> {
  late GameMode? selectedMode;

  // Supresses the tap while the Future.delayed are running
  bool supressTap = false;

  @override
  void initState() {
    selectedMode = widget.initialSelectedGameMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.gamemode)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          // Point limit mode
          SelectableTile(
            icon: AppIcons.point_limit,
            title: getPointLabel(loc, widget.pointLimit),
            description: loc.point_limit_description(widget.pointLimit),
            onTap: supressTap ? null : () => onTapTile(GameMode.pointLimit),
            selected: selectedMode == GameMode.pointLimit,
            selectionColor: CustomTheme.primaryColor,
          ),

          // Unlimited mode
          SelectableTile(
            icon: AppIcons.infinity,
            title: loc.unlimited,
            description: loc.unlimited_description,
            onTap: supressTap ? null : () => onTapTile(GameMode.unlimited),
            selected: selectedMode == GameMode.unlimited,
            selectionColor: CustomTheme.primaryColor,
          ),

          // Deselection
          if (widget.showDeselection)
            SelectableTile(
              title: loc.no_default_mode,
              description: loc.no_default_description,
              onTap: supressTap ? null : () => onTapTile(GameMode.none),
              selected: selectedMode == GameMode.none,
              selectionColor: CustomTheme.primaryColor,
            ),
        ],
      ),
    );
  }

  void onTapTile(GameMode selectedMode) {
    if (supressTap) return;
    supressTap = true;
    setState(() => this.selectedMode = selectedMode);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) Navigator.of(context).pop(selectedMode);
    });
  }
}
