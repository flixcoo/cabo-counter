import 'dart:ui' as dart_ui;

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// A widget that displays the cumulative scoring history of a game session as a line graph.
///
/// The [GraphView] visualizes the progression of each player's score over multiple rounds
/// using a line chart. It supports dynamic coloring for each player, axis formatting,
/// and handles cases where insufficient data is available to render the graph.
class GraphView extends StatefulWidget {
  final GameSessionController gameSession;

  const GraphView({super.key, required this.gameSession});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  final List<Color> lineColors = [
    CustomTheme.graphColor1,
    CustomTheme.graphColor2,
    CustomTheme.graphColor3,
    CustomTheme.graphColor4,
    CustomTheme.graphColor5,
  ];
  final GlobalKey<SfCartesianChartState> _key = GlobalKey();
  bool hasZoomed = false;

  /*late final ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    enableDoubleTapZooming: true,
    enableMouseWheelZooming: true,
    zoomMode: ZoomMode.x,
    maximumZoomLevel: 0.05,
  );*/

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isGraphAvailable =
        widget.gameSession.roundNumber > 1 || widget.gameSession.isGameFinished;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.game_graph),
        actions: [
          /*AnimatedIconButton(
            onPressed: isGraphAvailable && hasZoomed
                ? () => zoomPanBehavior.reset()
                : null,
            icon: IconService.reset,
          ),*/
          AnimatedIconButton(
            onPressed: isGraphAvailable ? () => shareImage() : null,
            icon: IconService.share,
          ),
        ],
      ),
      body: SafeArea(
        child: Visibility(
          visible: isGraphAvailable,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Center(child: AppIcon(IconService.chart, size: 60)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  loc.empty_graph_text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          child: SfCartesianChart(
            key: _key,
            backgroundColor: CustomTheme.backgroundColor,
            enableAxisAnimation: false,
            /*zoomPanBehavior: zoomPanBehavior,
            onZoomEnd: (ZoomPanArgs args) {
              if (args.axis?.name != 'rounds') return;
              final bool zoomed = args.currentZoomFactor < 1;
              if (zoomed != hasZoomed) {
                setState(() => hasZoomed = zoomed);
              }
            },
            onZoomReset: (ZoomPanArgs args) {
              if (args.axis?.name != 'rounds') return;
              if (hasZoomed) {
                setState(() => hasZoomed = false);
              }
            },*/
            legend: const Legend(
              alignment: ChartAlignment.near,
              overflowMode: LegendItemOverflowMode.scroll,
              isVisible: true,
              position: LegendPosition.bottom,
            ),
            primaryXAxis: const CategoryAxis(
              name: 'rounds',
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              interval: 1,
              labelPlacement: LabelPlacement.onTicks,
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              labelAlignment: LabelAlignment.center,
              labelPosition: ChartDataLabelPosition.inside,
              anchorRangeToVisiblePoints: false,
              rangePadding: ChartRangePadding.round,
              interval: 1,
              decimalPlaces: 0,
              axisLabelFormatter: (AxisLabelRenderDetails details) {
                if (details.value == 0) {
                  return ChartAxisLabel('', const TextStyle());
                }
                return ChartAxisLabel(
                  '${details.value.toInt()}',
                  const TextStyle(),
                );
              },
            ),
            series: getCumulativeScores(),
          ),
        ),
      ),
    );
  }

  /// Returns a list of LineSeries representing the cumulative scores of each player.
  /// Each series contains data points for each round, showing the cumulative score up to that round.
  /// The x-axis represents the round number, and the y-axis represents the cumulative score.
  List<LineSeries<(int, num), String>> getCumulativeScores() {
    final rounds = widget.gameSession.roundList;
    final playerCount = widget.gameSession.players.length;
    final playerNames = widget.gameSession.getPlayerNamesAsList();

    List<List<int>> cumulativeScores = List.generate(playerCount, (_) => []);
    List<int> runningTotals = List.filled(playerCount, 0);

    for (var round in rounds) {
      for (int i = 0; i < playerCount; i++) {
        runningTotals[i] += round.scoreUpdates[i];
        cumulativeScores[i].add(runningTotals[i]);
      }
    }

    const double jitterStep = 0.03;

    /// Create a list of LineSeries for each player
    /// Each series contains data points for each round
    return List.generate(playerCount, (i) {
      final data = List.generate(
        cumulativeScores[i].length + 1,
        (j) => (
          j,
          j == 0 || cumulativeScores[i][j - 1] == 0
              ? 0 // 0 points at the start of the game or when the value is 0 (don't subtract jitter step)
              // Adds a small jitter to the cumulative scores to prevent overlapping data points in the graph.
              // The jitter is centered around zero by subtracting playerCount ~/ 2 from the player index i.
              : cumulativeScores[i][j - 1] +
                    (i - playerCount ~/ 2) * jitterStep,
        ),
      );

      /// Create a LineSeries for the player
      /// The xValueMapper maps the round number, and the yValueMapper maps the cumulative score.
      return LineSeries<(int, num), String>(
        name: playerNames[i],
        dataSource: data,
        xValueMapper: (record, _) => '${record.$1}',
        yValueMapper: (record, _) => record.$2,
        markerSettings: const MarkerSettings(isVisible: true),
        color: lineColors[i],
      );
    });
  }

  /// Captures the current state of the graph as an image and shares it using the SharePlus package.
  /// The image is saved as a PNG file and shared via available sharing options on the device.
  /// The method uses a pixel ratio of 5.0 for high-resolution images.
  Future<void> shareImage() async {
    // Get the RenderBox of the current view to determine its position on screen.
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    // Capture the chart as an image with a pixel ratio of 5.0 for high quality.
    final image = await _key.currentState?.toImage(pixelRatio: 5.0);
    final byteData = await image?.toByteData(
      format: dart_ui.ImageByteFormat.png,
    );

    // Exit if image capture failed.
    if (byteData == null) return;

    // Set the share position origin:
    // - Use the view's position if available.
    // - Fall back to a default position (top-left corner) if the view's position is unavailable.
    Rect sharePositionOrigin = renderBox == null
        ? const Rect.fromLTWH(0, 0, 100, 100)
        : renderBox.localToGlobal(Offset.zero) & renderBox.size;

    await SharePlus.instance.share(
      ShareParams(
        sharePositionOrigin: sharePositionOrigin,
        files: [
          XFile.fromData(
            byteData.buffer.asUint8List(),
            mimeType: 'image/png',
            name: 'scoring_history.png',
          ),
        ],
      ),
    );
  }
}
