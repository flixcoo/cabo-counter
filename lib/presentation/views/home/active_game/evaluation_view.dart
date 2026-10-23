import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/game_statistics.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_set.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_tile.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:material_ui/material_ui.dart';

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
  List<(String, int)> rowWins = [];
  bool hasOnlyKamikazeRounds = false;

  @override
  void initState() {
    super.initState();
    final statistics = GameStatistics(
      players: widget.gameSession.players,
      rounds: widget.gameSession.roundList,
    );
    averagePoints = statistics.averagePoints();
    roundsWon = statistics.roundsWon();
    caboPenalties = statistics.caboPenalties();
    rowWins = statistics.longestWinStreak();
    hasOnlyKamikazeRounds = statistics.hasOnlyKamikazeRounds;
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
                description: loc.rounds_won_description,
                content: [
                  for (final value in roundsWon)
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
                description: loc.points_per_round_description,
                content: [
                  for (final value in averagePoints)
                    ActiveGameListTile(
                      title: Text(value.$1),
                      trailing: Text(
                        // If only kamikaze rounds, show "-"
                        hasOnlyKamikazeRounds
                            ? '-'
                            : '${value.$2.toStringAsFixed(1)} ${loc.points}',
                      ),
                    ),
                ],
              ),

              // Received cabo penalties
              ActiveGameListSet(
                title: loc.received_cabo_penalties,
                description: loc.received_cabo_penalties_description,
                content: [
                  for (final value in caboPenalties)
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
                description: loc.longest_win_streak_description,
                content: [
                  for (final value in rowWins)
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
}
