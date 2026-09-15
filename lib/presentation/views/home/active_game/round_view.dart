import 'dart:math';

import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_text_button.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_segmented_control.dart';
import 'package:cabo_counter/presentation/components/widgets/sheets/kamikaze_sheet.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/score_enter_tile.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class RoundView extends StatefulWidget {
  /// A view for displaying and managing a single round
  ///
  /// - [roundNumber]: The number of the current round.
  /// - [gameSession]: The controller managing the current game session.
  /// - [onRoundSubmitted]: Optional callback for when a round is submitted.
  const RoundView({
    super.key,
    required this.roundNumber,
    required this.gameSession,
    this.onRoundSubmitted,
  });

  final int roundNumber;
  final GameSessionController gameSession;
  final void Function()? onRoundSubmitted;

  @override
  _RoundViewState createState() => _RoundViewState();
}

class _RoundViewState extends State<RoundView> {
  late GameSessionController gameSession = widget.gameSession;

  int? caboPlayerIndex;
  int? kamikazePlayerIndex;

  bool get hasRoundBeenPlayed =>
      widget.roundNumber < widget.gameSession.roundNumber;
  bool get isGameFinished => widget.gameSession.isGameFinished;
  int get playerAmount => widget.gameSession.players.length;

  late int shufflePlayerIndex;

  late final List<TextEditingController> scoreControllerList = List.generate(
    playerAmount,
    (index) => TextEditingController(),
  );

  late final List<FocusNode> focusNodes = List.generate(
    playerAmount,
    (index) => FocusNode(),
  );

  /// List of global keys for the score text fields.
  late List<GlobalKey> textFieldKeys;

  @override
  void initState() {
    shufflePlayerIndex = getShufflePlayerIndex();

    if (hasRoundBeenPlayed || isGameFinished) prefillFields();

    textFieldKeys = List.generate(playerAmount, (index) => GlobalKey());

    super.initState();
  }

  @override
  void dispose() {
    for (final controller in scoreControllerList) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final rotatedPlayers = getRotatedPlayers();
    final originalIndices = getOriginalIndices();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AnimatedIconButton(
          onPressed: () => Navigator.of(context).pop(-1),
          icon: AppIcons.close,
        ),
        title: Text(loc.results),
        actions: [
          AnimatedIconButton(
            icon: AppIcons.kamikaze,
            color: CustomTheme.kamikazeColor,
            onPressed: () async {
              if (await showKamikazeSheet(context)) {
                if (!context.mounted) return;
                endOfRoundNavigation(
                  context: context,
                  navigateToNextRound: true,
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20 + bottomInset, top: 40),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Round number
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${loc.round} ${widget.roundNumber}',
                        style: const TextStyle(
                          fontSize: 60,
                          color: CustomTheme.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Text
                    Text(
                      loc.who_said_cabo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    // Cabo player selection
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        height: 40,
                        child: CustomSegmentedControl<int>(
                          groupValue: caboPlayerIndex,
                          children: Map.fromEntries(
                            widget.gameSession.players.asMap().entries.map((
                              entry,
                            ) {
                              final index = entry.key;
                              final player = entry.value;
                              return MapEntry(
                                index,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 8,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      player.name,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          onValueChanged: (value) {
                            setState(() => caboPlayerIndex = value);
                          },
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rotatedPlayers.length,
                      itemBuilder: (context, index) {
                        // The index of the player in the original players list,
                        // which is needed to access the correct score and to
                        // update the correct text controller.
                        final originalIndex = originalIndices[index];

                        // The name of the player to display, which is taken
                        // from the rotated players list.
                        final name = rotatedPlayers[index];

                        // Whether to show the medal icon for this player.
                        // The medal is shown for the first player in the list
                        final shouldShowMedal =
                            index == 0 && widget.roundNumber > 1;

                        // Whether to show the shuffle player indicator for this player
                        final isShufflePlayer =
                            originalIndex == shufflePlayerIndex;

                        // The text input action for the score text field.
                        // It is "next" for all players except the last one,
                        // which is "done".
                        final textInputAction = index == playerAmount - 1
                            ? TextInputAction.done
                            : TextInputAction.next;

                        // The score for this player in the current round.
                        final score = widget.gameSession
                            .getPlayerScoresAsList()[originalIndex];

                        return Center(
                          child: ScoreEnterTile(
                            key: textFieldKeys[originalIndex],
                            playerName: name,
                            points: score,
                            shufflePlayer: isShufflePlayer,
                            showMedal: shouldShowMedal,
                            controller: scoreControllerList[originalIndex],
                            textInputAction: textInputAction,
                            onSubmitted: (_) =>
                                focusNextTextfield(originalIndex),
                            focusNode: focusNodes[originalIndex],
                            onChanged: (_) => setState(() {}),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AnimtedTextButton(
                        onPressed: canSubmitRound
                            ? () => endOfRoundNavigation(
                                context: context,
                                navigateToNextRound: false,
                              )
                            : null,
                        text: loc.done,
                      ),
                    ),
                    if (!isGameFinished)
                      Expanded(
                        child: AnimtedTextButton(
                          onPressed: canSubmitRound
                              ? () => endOfRoundNavigation(
                                  context: context,
                                  navigateToNextRound: true,
                                )
                              : null,
                          text: loc.next_round,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void prefillFields() {
    for (int i = 0; i < scoreControllerList.length; i++) {
      scoreControllerList[i].text = gameSession
          .roundList[widget.roundNumber - 1]
          .scores[i]
          .toString();
    }
    caboPlayerIndex =
        gameSession.roundList[widget.roundNumber - 1].caboPlayerIndex;
    kamikazePlayerIndex =
        gameSession.roundList[widget.roundNumber - 1].kamikazePlayerIndex;
  }

  /// Gets the index of the player who won the previous round.
  /// Returns 0 in the first round, as there is no previous round.
  int getPreviousRoundWinnerIndex() {
    if (widget.roundNumber == 1) {
      return 0; // If it's the first round, the order should be the same as the players list.
    }

    final List<int> scores =
        widget.gameSession.roundList[widget.roundNumber - 2].scoreUpdates;
    final int winnerIndex = scores.indexOf(0);

    // Fallback if no player has 0 points, which should not happen in a valid game.
    if (winnerIndex == -1) {
      return 0;
    }
    return winnerIndex;
  }

  /// Determines which player is responsible for shuffling the cards.
  /// In the first round, the first player shuffles. In subsequent rounds,
  /// the player with the highest score from the previous round (round loser)
  /// shuffles. If rotate shuffler is enabled in the configuration,
  /// the shuffler rotates among players each round.
  int getShufflePlayerIndex() {
    // In the first round the first player shuffles the cards
    if (widget.roundNumber == 1) {
      return 0;
    }

    // If the configuration is set to rotate the shuffler, calculate the
    // shuffler index according to the current round number and amount of players
    if (ConfigService.getRotateShuffler()) {
      return (widget.roundNumber - 1) % playerAmount;
    }

    final List<int> scores =
        widget.gameSession.roundList[widget.roundNumber - 2].scoreUpdates;

    final int maxScore = scores.reduce(
      (value, element) => value > element ? value : element,
    );

    // Collect all indices with the maxScore
    final List<int> candidateIndices = [];
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] == maxScore) candidateIndices.add(i);
    }

    // If only one player has the highest score, return that index.
    // If multiple players share the highest score, select one randomly.
    if (candidateIndices.length == 1) {
      return candidateIndices.first;
    } else {
      // Use a seeded random generator for consistent results.
      final seed =
          widget.gameSession.createdAt.microsecondsSinceEpoch +
          widget.roundNumber;
      final rnd = Random(seed);
      return candidateIndices[rnd.nextInt(candidateIndices.length)];
    }
  }

  /// Rotates the players list based on the previous round's winner.
  List<String> getRotatedPlayers() {
    final winnerIndex = getPreviousRoundWinnerIndex();
    final playerList = widget.gameSession.getPlayerNamesAsList();
    return [
      playerList[winnerIndex],
      ...playerList.sublist(winnerIndex + 1),
      ...playerList.sublist(0, winnerIndex),
    ];
  }

  /// Gets the original indices of the players by recalculating it from the rotated list.
  List<int> getOriginalIndices() {
    final winnerIndex = getPreviousRoundWinnerIndex();
    return [
      winnerIndex,
      ...List.generate(
        playerAmount - winnerIndex - 1,
        (i) => winnerIndex + i + 1,
      ),
      ...List.generate(winnerIndex, (i) => i),
    ];
  }

  /// Shows a bottom sheet sheet to select the player who has Kamikaze.
  /// It returns true if a player was selected, false if the action was cancelled.
  Future<bool> showKamikazeSheet(BuildContext context) async {
    final selectedIndex = await KamikazeSheet.show(context, gameSession);
    if (selectedIndex != null) {
      kamikazePlayerIndex = selectedIndex;
      return true;
    }
    return false;
  }

  /// Focuses the next text field in the list of text fields.
  /// [index] is the index of the current text field.
  void focusNextTextfield(int index) {
    final originalIndices = getOriginalIndices();
    final currentPos = originalIndices.indexOf(index);

    if (currentPos < originalIndices.length - 1) {
      final nextIndex = originalIndices[currentPos + 1];
      FocusScope.of(context)
          .requestFocus(focusNodes[originalIndices[currentPos + 1]]);

      final scrollContext = textFieldKeys[nextIndex].currentContext;
      if (scrollContext != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scrollable.ensureVisible(
            scrollContext,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            alignment: 0.45,
          );
        });
      }
    } else {
      focusNodes[index].unfocus();
    }
  }

  /// Checks if the round can be submitted.
  /// Therefore we need input in every text field and a cabo player selected
  /// or a kamikaze player selected
  bool get canSubmitRound =>
      (!areTextFieldsEmpty() && caboPlayerIndex != null) ||
      kamikazePlayerIndex != null;

  /// Checks if any of the text fields for the players points are empty.
  /// Returns true if any of the text fields is empty, false otherwise.
  bool areTextFieldsEmpty() {
    for (TextEditingController t in scoreControllerList) {
      if (t.text.isEmpty) {
        return true;
      }
    }
    return false;
  }

  /// Finishes the current round.
  /// It first determines, ifCalls the [_calculateScoredPoints()] method to calculate the points for
  /// every player. If the round is the highest round played in this game,
  /// it expands the player score lists. At the end it updates the score
  /// array for the game.
  List<int> finishRound() {
    if (kamikazePlayerIndex != null) {
      widget.gameSession.applyKamikaze(
        widget.roundNumber,
        kamikazePlayerIndex!,
      );
    } else {
      List<int> roundScores = [];
      for (TextEditingController c in scoreControllerList) {
        if (c.text.isNotEmpty) roundScores.add(int.parse(c.text));
      }
      widget.gameSession.calculateScoredPoints(
        widget.roundNumber,
        roundScores,
        caboPlayerIndex!,
      );
    }
    List<int> bonusPlayers = widget.gameSession.updatePoints();
    widget.onRoundSubmitted?.call();
    return bonusPlayers;
  }

  /// Shows a popup dialog with the information which player received the bonus points.
  Future<void> showBonusPopup(
    BuildContext context,
    List<int> bonusPlayers,
  ) async {
    final loc = AppLocalizations.of(context);
    final pointLimit = widget.gameSession.pointLimit!;
    final bonusPoints = (pointLimit / 2).round();

    String resultText = getBonusPopupMessage(
      pointLimit,
      bonusPoints,
      bonusPlayers,
    );

    VibrationService.heavyImpact();
    await PopupService.showInfoPopup(
      context: context,
      icon: Icons.star_rounded,
      title: loc.bonus_points_title,
      message: resultText,
    );
  }

  /// Generates the message string for the bonus popup.
  /// It takes the [pointLimit], [bonusPoints] and the list of [bonusPlayersIndices]
  /// and returns a formatted string.
  String getBonusPopupMessage(
    int pointLimit,
    int bonusPoints,
    List<int> bonusPlayersIndices,
  ) {
    final loc = AppLocalizations.of(context);
    List<String> playerNames = bonusPlayersIndices
        .map((index) => widget.gameSession.players[index].name)
        .toList();

    String resultText = concatenateNames(playerNames);
    resultText = loc.bonus_points_message(
      playerNames.length,
      concatenateNames(playerNames),
      pointLimit,
      bonusPoints,
    );

    return resultText;
  }

  /// Handles the navigation for the end of the round.
  /// It checks for bonus players and shows a popup, saves the game session,
  /// and navigates to the next round or back to the previous screen.
  /// It takes the BuildContext [context] and a boolean [navigateToNextRound] to determine
  /// if it should navigate to the next round or not.
  Future<void> endOfRoundNavigation({
    required BuildContext context,
    required bool navigateToNextRound,
  }) async {
    List<int> bonusPlayersIndices = finishRound();
    if (bonusPlayersIndices.isNotEmpty) {
      await showBonusPopup(context, bonusPlayersIndices);
    }

    if (context.mounted) {
      // If the game is finished, pop the context and return to the previous screen.
      if (isGameFinished) {
        Navigator.pop(context);
        return;
      }
      // If navigateToNextRound is false, pop the context and return to the previous screen.
      if (!navigateToNextRound) {
        Navigator.pop(context);
        return;
      }
      // If navigateToNextRound is true and the game isn't finished yet,
      // pop the context and navigate to the next round.
      Navigator.pop(context, widget.roundNumber + 1);
    }
  }
}
