import 'dart:io';

import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScoreEnterTile extends StatefulWidget {
  /// A tile for entering scores for a player
  ///
  /// - [playerName]: The name of the player to display
  /// - [points]: The current score of the player, displayed below the name
  /// - [shufflePlayer]: Whether to show the "dealer" label next to the player's name
  /// - [showMedal]: Whether to show a medal icon next to the player's name, indicating they won the previous round.
  /// - [textInputAction]: The action to perform when the user submits the score (e.g., "next" or "done")
  /// - [controller]: The controller for the text field, used to manage the input value
  /// - [onSubmitted]: The callback to invoke when the user submits the score
  /// - [focusNode]: The focus node for the text field, used to manage focus
  /// - [onChanged]: The callback to invoke when the input value changes
  const ScoreEnterTile({
    super.key,
    required this.playerName,
    required this.points,
    required this.textInputAction,
    required this.controller,
    required this.onSubmitted,
    required this.focusNode,
    required this.onChanged,
    this.shufflePlayer = false,
    this.showMedal = false,
  });

  final String playerName;
  final int points;
  final bool shufflePlayer;
  final bool showMedal;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;

  @override
  State<ScoreEnterTile> createState() => _ScoreEnterTileState();
}

class _ScoreEnterTileState extends State<ScoreEnterTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: CustomTheme.tileColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(widget.playerName),
                    if (widget.shufflePlayer) ...[
                      const SizedBox(width: 8),
                      Text(
                        loc.dealer,
                        style: const TextStyle(
                          fontSize: 13,
                          color: CustomTheme.subtitleColor,
                        ),
                      ),
                    ],
                    if (widget.showMedal) ...const [
                      SizedBox(width: 10),
                      FaIcon(
                        FontAwesomeIcons.crown,
                        size: 15,
                        color: CustomTheme.primaryColor,
                      ),
                    ],
                  ],
                ),
                Text(
                  getPointLabel(loc, widget.points),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  isDense: true,
                  fillColor: Colors.red,
                  border: InputBorder.none,
                  hintText: loc.points,
                  hintStyle: TextStyle(color: CustomTheme.hintTextColor),
                ),
                keyboardType: Platform.isAndroid
                    ? TextInputType.number
                    // Even though negative input isnt possible, signed needs
                    // to be true for ios to show the normal keyboard type and
                    // not the numbers input
                    : const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: widget.textInputAction,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                maxLength: 3,
                focusNode: widget.focusNode,
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
