import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/adaptive_sheet_route.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/active_game/active_game_list_set.dart';
import 'package:cabo_counter/presentation/components/widgets/active_game/active_game_list_tile.dart';
import 'package:cabo_counter/presentation/components/widgets/popups/custom_popup_action.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:cabo_counter/presentation/views/home/active_game/evaluation_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/graph_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/points_view.dart';
import 'package:cabo_counter/presentation/views/home/active_game/round_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game/create_game_view.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/rating_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:collection/collection.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Displays the active game view, showing game details, player rankings, rounds, and statistics.
///
/// This view allows users to interact with an ongoing game session, including viewing player scores,
/// navigating through rounds, ending or deleting the game, exporting game data, and starting a new game
/// with the same settings. It also provides visual feedback such as confetti animation when the game ends.
///
/// The widget listens to changes in the provided [GameSession] and updates the UI accordingly.
class ActiveGameView extends StatefulWidget {
  const ActiveGameView({
    super.key,
    required this.gameSession,
    required this.onSessionsUpdated,
  });
  final GameSession gameSession;
  final VoidCallback onSessionsUpdated;

  @override
  _ActiveGameViewState createState() => _ActiveGameViewState();
}

class _ActiveGameViewState extends State<ActiveGameView> {
  late final GameSessionController gameSession;

  /// A list of the ranks for each player corresponding to their index in sortedPlayerIndices
  late List<int> denseRanks;

  /// A list of player indices sorted by their scores in ascending order.
  late List<int> sortedPlayerIndices;

  bool get hasGameValues =>
      gameSession.roundNumber > 1 || gameSession.isGameFinished;
  bool get isGameFinished => gameSession.isGameFinished;

  final confettiController = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    gameSession = GameSessionController(
      session: widget.gameSession,
      db: Provider.of<AppDatabase>(context, listen: false),
    );
  }

  @override
  void dispose() {
    gameSession.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Stack(
      children: [
        ListenableBuilder(
          listenable: gameSession,
          builder: (context, _) {
            sortedPlayerIndices = getSortedPlayerIndices();
            denseRanks = calculateDenseRank(
              gameSession.getPlayerScoresAsList(),
              sortedPlayerIndices,
            );
            return Scaffold(
              appBar: AppBar(title: Text(loc.overview)),
              body: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ActiveGameListSet(
                        title: loc.game,
                        content: [
                          // Title
                          ActiveGameListTile(
                            title: Text(loc.name),
                            trailing: Text(
                              gameSession.title,
                              style: const TextStyle(
                                color: CustomTheme.primaryColor,
                              ),
                            ),
                          ),

                          // Mode
                          ActiveGameListTile(
                            title: Text(loc.mode),
                            trailing: Text(
                              gameSession.isPointsLimitEnabled
                                  ? getPointLabel(loc, gameSession.pointLimit!)
                                  : loc.unlimited,
                              style: const TextStyle(
                                color: CustomTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Players
                      ActiveGameListSet(
                        title: loc.players,
                        tilePadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        content: [
                          for (
                            int index = 0;
                            index < gameSession.players.length;
                            index++
                          ) ...[
                            ActiveGameListTile(
                              title: Row(
                                spacing: 5,
                                children: [
                                  getPlacementTextWidget(index),
                                  Text(
                                    gameSession
                                        .players[sortedPlayerIndices[index]]
                                        .name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                children: [
                                  Text(
                                    getPointLabel(
                                      loc,
                                      gameSession
                                          .getPlayerScoresAsList()[sortedPlayerIndices[index]],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Rounds
                      ActiveGameListSet(
                        title: loc.rounds,
                        content: [
                          for (
                            int index = 0;
                            index < gameSession.roundNumber;
                            index++
                          )
                            ActiveGameListTile(
                              title: Text('${loc.round} ${index + 1}'),
                              showChevron: true,
                              trailing: Row(
                                children: [
                                  // Round is in progress
                                  index + 1 == gameSession.roundNumber &&
                                          !isGameFinished
                                      ? const Text(
                                          '\u{23F3}',
                                          style: TextStyle(fontSize: 22),
                                        )
                                      : (const Text(
                                          '\u{2705}',
                                          style: TextStyle(fontSize: 22),
                                        )),
                                ],
                              ),
                              onTap: () async {
                                openRoundView(context, index + 1);
                              },
                            ),
                        ],
                      ),

                      // Statistics
                      ActiveGameListSet(
                        title: loc.statistics,
                        content: [
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(loc.detailed_analytics),
                            onTap: hasGameValues
                                ? () => Navigator.push(
                                    context,
                                    adaptivePageRoute(
                                      builder: (_) => EvaluationView(
                                        gameSession: gameSession,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(loc.game_graph),
                            onTap: hasGameValues
                                ? () => Navigator.push(
                                    context,
                                    adaptivePageRoute(
                                      builder: (_) =>
                                          GraphView(gameSession: gameSession),
                                    ),
                                  )
                                : null,
                          ),
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(loc.score_table),
                            onTap: hasGameValues
                                ? () => Navigator.push(
                                    context,
                                    adaptivePageRoute(
                                      builder: (_) =>
                                          PointsView(gameSession: gameSession),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),

                      // Settings
                      ActiveGameListSet(
                        title: loc.settings,
                        content: [
                          if (!gameSession.isPointsLimitEnabled)
                            ActiveGameListTile(
                              title: Text(loc.end_game),
                              showChevron: true,
                              onTap:
                                  hasGameValues && !gameSession.isGameFinished
                                  ? () => showEndGameDialog()
                                  : null,
                            ),
                          ActiveGameListTile(
                            title: Text(loc.delete_game),
                            showChevron: true,
                            onTap: () {
                              showDeleteGameDialog().then((shouldDeleteGame) {
                                if (shouldDeleteGame) {
                                  removeGameSession(widget.gameSession);
                                }
                              });
                            },
                          ),
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(
                              AppLocalizations.of(context)
                                  .new_game_same_settings,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                adaptivePageRoute(
                                  builder: (_) => CreateGameView(
                                    gameTitle: gameSession.title,
                                    gameMode:
                                        widget
                                                .gameSession
                                                .isPointsLimitEnabled ==
                                            true
                                        ? GameMode.pointLimit
                                        : GameMode.unlimited,
                                    players: gameSession.getPlayerNamesAsList(),
                                    onSessionsUpdated: widget.onSessionsUpdated,
                                  ),
                                ),
                              );
                            },
                          ),
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(loc.export_game),
                            onTap: () async {
                              final success =
                                  await DataTransferService.exportSingleGameSession(
                                    widget.gameSession,
                                  );
                              if (!success && context.mounted) {
                                PopupService.showInfoPopup(
                                  context: context,
                                  icon: Icons.error_outline_rounded,
                                  title: AppLocalizations.of(context)
                                      .export_error_title,
                                  message: AppLocalizations.of(context)
                                      .export_error_message,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ConfettiWidget(
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.07,
                emissionFrequency: 0.1,
                numberOfParticles: 10,
                minBlastForce: 5,
                maxBlastForce: 20,
                confettiController: confettiController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Shows a dialog to confirm ending the game.
  /// If the user confirms, it calls the `endGame` method on the game manager
  void showEndGameDialog() {
    final loc = AppLocalizations.of(context);

    final endGameAction = CustomPopupAction<bool>(
      style: CustomPopupActionStyle.primary,
      isDestructive: true,
      label: loc.end_game,
      returnValue: true,
      onPressed: () {
        if (mounted) {
          setState(() {
            endGame();
            playFinishAnimation(context);
          });
        }
      },
    );
    final cancelAction = CustomPopupAction<bool>(
      style: CustomPopupActionStyle.secondary,
      label: loc.cancel,
      returnValue: false,
    );

    PopupService.showSelectionPopup<bool>(
      context: context,
      icon: Icons.flag_outlined,
      title: loc.end_game_title,
      message: loc.end_game_message,
      actions: [endGameAction, cancelAction],
    );
  }

  /// Ends a game session if its in unlimited mode.
  /// Takes a String [id] as input. It finds the index of the game
  /// session with the matching ID marks it as finished,
  void endGame() {
    if (gameSession.isPointsLimitEnabled) return;
    gameSession.endGame();

    final db = Provider.of<AppDatabase>(context, listen: false);
    db.gameSessionDao.updateGameFinished(
      gameId: gameSession.id,
      isFinished: true,
    );
  }

  /// Returns a list of player indices sorted by their scores in
  /// ascending order.
  List<int> getSortedPlayerIndices() {
    List<int> playerIndices = List<int>.generate(
      gameSession.players.length,
      (index) => index,
    );
    // Sort the indices based on the summed points
    playerIndices.sort((a, b) {
      int scoreA = gameSession.getPlayerScoresAsList()[a];
      int scoreB = gameSession.getPlayerScoresAsList()[b];
      if (scoreA != scoreB) {
        return scoreA.compareTo(scoreB);
      }
      return a.compareTo(b);
    });
    return playerIndices;
  }

  /// Calculates the dense rank for a player based on their index in the sorted list of players.
  List<int> calculateDenseRank(
    List<int> playerScores,
    List<int> sortedIndices,
  ) {
    List<int> denseRanks = [];
    int rank = 1;
    for (int i = 0; i < sortedIndices.length; i++) {
      if (i > 0) {
        int prevScore = playerScores[sortedIndices[i - 1]];
        int currScore = playerScores[sortedIndices[i]];
        if (currScore != prevScore) {
          rank++;
        }
      }
      denseRanks.add(rank);
    }
    return denseRanks;
  }

  /// Returns a text widget representing the placement text based on the given placement number.
  /// [index] is the index of the player in [players] list,
  Text getPlacementTextWidget(int index) {
    int placement = denseRanks[index];
    switch (placement) {
      case 1:
        return const Text('\u{1F947}', style: TextStyle(fontSize: 20)); // 🥇
      case 2:
        return const Text('\u{1F948}', style: TextStyle(fontSize: 20)); // 🥈
      case 3:
        return const Text('\u{1F949}', style: TextStyle(fontSize: 20)); // 🥉
      default:
        return Text(
          ' $placement.',
          style: const TextStyle(fontWeight: FontWeight.bold, height: 1.6),
        );
    }
  }

  /// Shows a dialog to confirm deleting the game session.
  Future<bool> showDeleteGameDialog() async {
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<bool>(
          context: context,
          icon: Icons.delete_outline_rounded,
          iconColor: Colors.red,
          title: loc.delete_game_title,
          message: loc.delete_game_message(gameSession.title),
          actions: [
            CustomPopupAction(
              style: CustomPopupActionStyle.primary,
              isDestructive: true,
              label: loc.delete,
              returnValue: true,
            ),
            CustomPopupAction(
              returnValue: false,
              style: CustomPopupActionStyle.secondary,
              label: loc.cancel,
            ),
          ],
        ) ??
        false;
  }

  /// Removes the game session in the game manager and navigates back to the previous screen.
  /// If the game session does not exist in the game list, it shows an error dialog.
  Future<void> removeGameSession(GameSession gameSession) async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final deleted = await db.gameSessionDao.deleteGameSession(
      gameSessionId: gameSession.id,
    );
    if (!mounted) return;
    if (deleted) {
      widget.onSessionsUpdated.call();
      Navigator.pop(context);
    } else {
      final loc = AppLocalizations.of(context);
      PopupService.showInfoPopup(
        context: context,
        icon: Icons.error_outline_rounded,
        title: loc.id_error_title,
        message: loc.id_error_message,
      );
    }
  }

  /// Recursively opens the RoundView for the specified round number.
  /// It starts with the given [roundNumber] and continues to open the next round
  /// until the user navigates back or the round number is invalid.
  void openRoundView(BuildContext context, int roundNumber) async {
    final int? nextRoundNumber =
        await Navigator.of(context, rootNavigator: true).push(
          adaptiveSheetRoute(
            builder: (context) => RoundView(
              gameSession: gameSession,
              roundNumber: roundNumber,
              onRoundSubmitted: () => setState(() {}),
            ),
          ),
        );

    // If the user presses the cancel button
    if (nextRoundNumber == -1) return;

    if (widget.gameSession.isGameFinished && context.mounted) {
      playFinishAnimation(context);
    }

    // If the previous round was not the last one
    if (nextRoundNumber != null && nextRoundNumber >= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(
          const Duration(milliseconds: Constants.ROUND_VIEW_DELAY),
        );
        if (context.mounted) {
          openRoundView(context, nextRoundNumber);
        }
      });
    }
    widget.onSessionsUpdated.call();
  }

  /// Plays the confetti animation and shows a dialog with the winner's information.
  Future<void> playFinishAnimation(BuildContext context) async {
    final loc = AppLocalizations.of(context);

    int winnerPoints = widget.gameSession.getScoresList.min;
    int winnerCount = widget.gameSession.winner.length;
    String winnerString = widget.gameSession.winnerAsString;

    confettiController.play();
    VibrationService.successNotification();

    await Future.delayed(const Duration(milliseconds: Constants.POP_UP_DELAY));

    if (context.mounted) {
      PopupService.showInfoPopup(
        context: context,
        icon: Icons.emoji_events_rounded,
        iconColor: CustomTheme.kamikazeColor,
        title: loc.end_of_game_title,
        message: loc.end_of_game_message(
          winnerCount,
          winnerString,
          winnerPoints,
        ),
        onAfterPop: () {
          confettiController.stop();
          RatingService.maybeShowRatingDialog(context);
        },
      );
    }
  }
}
