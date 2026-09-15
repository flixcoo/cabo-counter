import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_tile.dart';
import 'package:flutter/material.dart';

class ActiveGameListSet extends StatefulWidget {
  const ActiveGameListSet({
    super.key,
    required this.title,
    required this.content,
    this.subtitle,
    this.tilePadding,
  });

  final String title;
  final List<ActiveGameListTile> content;
  final String? subtitle;
  final EdgeInsets? tilePadding;

  @override
  State<ActiveGameListSet> createState() => _ActiveGamelistSetState();
}

class _ActiveGamelistSetState extends State<ActiveGameListSet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: CustomTheme.rowTitle),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: CustomTheme.rowTitle.copyWith(fontSize: 14),
                  ),
              ],
            ),
          ),
          if (widget.content.isNotEmpty) ...[
            for (var tile in widget.content)
              Padding(
                padding:
                    widget.tilePadding ??
                    const EdgeInsets.fromLTRB(16, 12, 12, 12),
                child: tile,
              ),
            const SizedBox(height: 5),
          ],
        ],
      ),
    );
  }
}
