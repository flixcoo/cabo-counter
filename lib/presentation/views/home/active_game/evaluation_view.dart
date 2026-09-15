import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/data/models/round.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_set.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_tile.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class EvaluationView extends StatefulWidget {
  const EvaluationView({super.key, required this.gameSession});

  final GameSessionController gameSession;

  @override
  State<EvaluationView> createState() => _EvaluationViewState();
}

class _EvaluationViewState extends State<EvaluationView> {
  List<(String, double)> averagePoints = [];
  List<(String, int)> roundsWon = [];
  List<(String, int)> caboPenalties = [];
  List<(String, int)> longestWinStreak = [];

  @override
  void initState() {
    super.initState();
    averagePoints = calculateAveragePoints();
    roundsWon = calculateRoundsWon();
    caboPenalties = calculateCaboPenalties();
    longestWinStreak = calculateRowWins();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.detailed_analytics)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Rounds won
              ActiveGameListSet(
                title: loc.rounds_won,
                content: [
                  for (final value in calculateRoundsWon())
                    ActiveGameListTile(
                      title: Text(value.$1),
                      trailing: Text(
                        '${value.$2.toString()} ${value.$2 == 1 ? loc.round : loc.rounds}',
                      ),
                    ),
                ],
              ),

              // Average points
              ActiveGameListSet(
                title: '\u{00D8} ${loc.points_per_round}',
                content: [
                  for (final value in averagePoints)
                    ActiveGameListTile(
                      title: Text(value.$1),
                      trailing: Text(
                        ('${value.$2.toStringAsFixed(1)} ${loc.points}'),
                      ),
                    ),
                ],
              ),

              // Received cabo penalties
              ActiveGameListSet(
                title: loc.received_cabo_penalties,
                content: [
                  for (final value in calculateCaboPenalties())
                    ActiveGameListTile(
                      title: Text(value.$1),
                      trailing: Text(
                        '${value.$2.toString()}x (${getPointLabel(loc, widget.gameSession.caboPenalty * value.$2)})',
                      ),
                    ),
                ],
              ),

              // Longest win streak
              ActiveGameListSet(
                title: loc.longest_win_streak,
                content: [
                  for (final value in calculateRowWins())
                    ActiveGameListTile(
                      title: Text(value.$1),
                      trailing: Text(
                        '${value.$2.toString()} ${value.$2 == 1 ? loc.round : loc.rounds}',
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculates the average points per round for each player
  List<(String, double)> calculateAveragePoints() {
    var values = <(String, double)>[];
    final roundList = widget.gameSession.roundList;

    for (int i = 0; i < widget.gameSession.players.length; i++) {
      var allPoints = roundList.map((round) => round.scores[i]).toList();
      var average = allPoints.sum / allPoints.length;
      values.add((widget.gameSession.players[i].name, average));
    }
    return values..sort((a, b) => a.$2.compareTo(b.$2));
  }

  /// Calulates the amount of rounds won for each player.
  List<(String, int)> calculateRoundsWon() {
    var values = <(String, int)>[];
    final roundList = widget.gameSession.roundList;

    for (int i = 0; i < widget.gameSession.players.length; i++) {
      var roundsWon = roundList.where((round) => hasWonRound(round, i)).length;
      values.add((widget.gameSession.players[i].name, roundsWon));
    }
    return values..sort((a, b) => b.$2.compareTo(a.$2));
  }

  /// Calculates the amount of times a player got a cabo penalty
  List<(String, int)> calculateCaboPenalties() {
    var values = <(String, int)>[];
    final roundList = widget.gameSession.roundList;
    final caboPenalty = widget.gameSession.caboPenalty;

    for (int i = 0; i < widget.gameSession.players.length; i++) {
      var caboPenalties = roundList
          .where(
            (round) => round.scores[i] == round.scoreUpdates[i] - caboPenalty,
          )
          .length;
      values.add((widget.gameSession.players[i].name, caboPenalties));
    }
    return values..sort((a, b) => b.$2.compareTo(a.$2));
  }

  /// Calculates the longest streak of consecutive rounds won for each player.
  List<(String, int)> calculateRowWins() {
    var values = <(String, int)>[];
    final roundList = widget.gameSession.roundList;

    for (int i = 0; i < widget.gameSession.players.length; i++) {
      int longestStreak = 0;
      int currentStreak = 0;
      for (final round in roundList) {
        if (hasWonRound(round, i)) {
          currentStreak++;
          if (currentStreak > longestStreak) longestStreak = currentStreak;
        } else {
          currentStreak = 0;
        }
      }
      values.add((widget.gameSession.players[i].name, longestStreak));
    }
    return values..sort((a, b) => b.$2.compareTo(a.$2));
  }

  /// Whether the player at index [i] won the given [round].
  bool hasWonRound(Round round, int i) =>
      round.scores[i] == 0 ||
      round.scores[i] == round.scores.reduce((a, b) => a > b ? a : b);
}
