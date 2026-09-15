import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/cupertino.dart';

class GameTile extends StatefulWidget {
  const GameTile({
    super.key,
    required this.session,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  });

  final GameSession session;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final session = widget.session;
    List<({IconData icon, String text})> attributes = [
      (
        icon: session.isPointsLimitEnabled
            ? IconService.point_limit
            : IconService.infinity,
        text: session.isPointsLimitEnabled
            ? getPointLabel(loc, session.pointLimit!)
            : loc.unlimited,
      ),
      (
        icon: IconService.cabo_penalty,
        text: getPointLabel(loc, session.caboPenalty),
      ),
    ];

    return GestureDetector(
      onTap: () => {VibrationService.selectionClick(), widget.onTap?.call()},
      child: Container(
        decoration: const BoxDecoration(color: CustomTheme.tileColor),
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    session.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Text(
                  session.isGameFinished
                      ? '\u{1F947} ${session.winnerAsString}'
                      : '${loc.round} ${session.roundNumber}',
                  style: TextStyle(
                    fontSize: 16,
                    color: session.isGameFinished
                        ? CustomTheme.textColor
                        : CustomTheme.subtitleColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              session.players.map((p) => p.name).join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: CustomTheme.white),
            ),
            const SizedBox(height: 12),
            Row(
              spacing: 16,
              children: [
                for (final a in attributes)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(
                        a.icon,
                        size: 16,
                        color: CustomTheme.primaryColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        a.text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: CustomTheme.subtitleColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
