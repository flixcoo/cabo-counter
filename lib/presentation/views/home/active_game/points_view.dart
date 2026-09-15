import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displays an overview of points for each player and round in the current game session.
///
/// The [PointsView] widget shows a table with all rounds and player scores,
/// including score updates and highlights for players who said "Cabo".
///
/// Requires a [GameSession] to provide player and round data.
class PointsView extends StatefulWidget {
  final GameSessionController gameSession;

  const PointsView({super.key, required this.gameSession});

  @override
  State<PointsView> createState() => _PointsViewState();
}

class _PointsViewState extends State<PointsView> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.score_table)),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double caboFieldWidthFactor = 0.2;
            const double tablePadding = 8;
            final int playerCount = widget.gameSession.players.length;
            const double roundColWidth = 35;
            final double playerColWidth =
                (constraints.maxWidth - roundColWidth - (tablePadding)) /
                playerCount;

            return Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: tablePadding,
                    ),
                    child: DataTable(
                      dataRowMaxHeight: 0,
                      dataRowMinHeight: 0,
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      columns: [
                        const DataColumn(
                          label: SizedBox(
                            width: roundColWidth,
                            child: Text(
                              '#',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          numeric: true,
                        ),
                        ...widget.gameSession.players.map(
                          (player) => DataColumn(
                            label: SizedBox(
                              width: playerColWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  player.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: const [],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.paddingOf(context).bottom,
                    ),
                    scrollDirection: Axis.vertical,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: tablePadding,
                        ),
                        child: DataTable(
                          dataRowMaxHeight: 75,
                          dataRowMinHeight: 75,
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          headingRowHeight: 0,
                          columns: [
                            const DataColumn(
                              label: SizedBox(
                                width: roundColWidth,
                                child: Text(
                                  '#',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              numeric: true,
                            ),
                            ...widget.gameSession.players.map(
                              (player) => DataColumn(
                                label: SizedBox(
                                  width: playerColWidth,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      player.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            ...List<
                              DataRow
                            >.generate(widget.gameSession.roundList.length, (
                              roundIndex,
                            ) {
                              final round =
                                  widget.gameSession.roundList[roundIndex];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${roundIndex + 1}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    widget.gameSession.players.length,
                                    (playerIndex) {
                                      final int score =
                                          round.scores[playerIndex];
                                      final int update =
                                          round.scoreUpdates[playerIndex];
                                      final bool saidCabo =
                                          round.caboPlayerIndex == playerIndex;
                                      return DataCell(
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 6.0,
                                            ),
                                            child: Container(
                                              width:
                                                  playerColWidth *
                                                  (playerCount *
                                                      caboFieldWidthFactor), // Adjust width based on amount of players
                                              decoration: BoxDecoration(
                                                color: saidCabo
                                                    ? CustomTheme
                                                          .buttonBackgroundColor
                                                    : CupertinoColors
                                                          .transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 5),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: update <= 0
                                                          ? CustomTheme
                                                                .pointLossColor
                                                          : CustomTheme
                                                                .pointGainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      '${update >= 0 ? '+' : ''}$update',
                                                      style: const TextStyle(
                                                        color: CupertinoColors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '$score',
                                                    style: TextStyle(
                                                      color: CustomTheme.white,
                                                      fontWeight: saidCabo
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),
                            DataRow(
                              cells: [
                                const DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Σ',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                ...widget.gameSession
                                    .getPlayerScoresAsList()
                                    .map(
                                      (score) => DataCell(
                                        Center(
                                          child: Text(
                                            '$score',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
