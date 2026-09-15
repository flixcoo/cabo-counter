import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/app_icons.dart';
import 'package:cabo_counter/core/common.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/app_icon.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/add_player_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_text_button.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_set.dart';
import 'package:cabo_counter/presentation/components/widgets/grouped_lists/active_game_list_tile.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

/// A view for creating a new game session in the Cabo Counter app.
///
/// The [CreateGameView] allows users to input a game title, select a game mode,
/// add and reorder player names, and validate all required fields before
/// starting a new game. It provides feedback dialogs for missing or invalid
/// input and navigates to the active game view upon successful creation.
class CreateGameView extends StatefulWidget {
  const CreateGameView({
    super.key,
    this.gameTitle,
    this.players,
    required this.gameMode,
    required this.onSessionsUpdated,
  });

  final GameMode gameMode;
  final String? gameTitle;
  final List<String>? players;
  final VoidCallback onSessionsUpdated;

  @override
  // ignore: library_private_types_in_public_api
  _CreateGameViewState createState() => _CreateGameViewState();
}

class _CreateGameViewState extends State<CreateGameView> {
  final TextEditingController titleController = TextEditingController();

  final int minPlayers = 2;
  final int maxPlayers = 5;

  List<FocusNode> playerNameFocusNodes = [];
  List<TextEditingController> playerNameControllers = [];

  /// Variable to hold the selected game mode.
  late GameMode selectedGameMode;

  bool get hasReachedMaxPlayers => playerNameControllers.length >= maxPlayers;
  bool get hasReachedMinPlayers => playerNameControllers.length <= minPlayers;
  bool get isValidGame =>
      selectedGameMode != GameMode.none &&
      playerNameControllers.length >= 2 &&
      everyPlayerHasAName;

  @override
  void initState() {
    super.initState();
    selectedGameMode = widget.gameMode;
    titleController.text = widget.gameTitle ?? '';

    initializeController();
  }

  @override
  void dispose() {
    titleController.dispose();
    for (var controller in playerNameControllers) {
      controller.dispose();
    }
    for (var focusnode in playerNameFocusNodes) {
      focusnode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          if (context.mounted) {
            widget.onSessionsUpdated();
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(loc.new_game)),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ActiveGameListSet(
                        title: loc.game,
                        content: [
                          // Title text field
                          ActiveGameListTile(
                            title: Text(loc.name),
                            trailing: SizedBox(
                              height: 30,
                              width: 300,
                              child: TextField(
                                maxLength: 24,
                                textAlign: TextAlign.right,
                                controller: titleController,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hint: Text(
                                    textAlign: TextAlign.end,
                                    getFallbackGameTitle(),
                                    style: TextStyle(
                                      color: CustomTheme.hintTextColor,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),

                          // Mode selection
                          ActiveGameListTile(
                            showChevron: true,
                            title: Text(loc.mode),
                            trailing: getDisplayedGameMode(),
                            onTap: () async {
                              if (context.mounted) {
                                final result = await Navigator.push(
                                  context,
                                  adaptivePageRoute(
                                    builder: (context) => ModeSelectionView(
                                      pointLimit: ConfigService.getPointLimit(),
                                      showDeselection: false,
                                      initialSelectedGameMode: selectedGameMode,
                                    ),
                                  ),
                                );

                                setState(() {
                                  selectedGameMode = result ?? selectedGameMode;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      ActiveGameListSet(
                        title: loc.players,
                        content: const [],
                        subtitle: '${playerNameControllers.length} / 5',
                      ),

                      // Players
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        itemCount: playerNameControllers.length,
                        onReorderStart: (_) => VibrationService.heavyImpact(),
                        onReorderEnd: (_) => VibrationService.selectionClick(),
                        onReorderItem: (oldIndex, newIndex) {
                          setState(() {
                            if (oldIndex < playerNameControllers.length &&
                                newIndex <= playerNameControllers.length) {
                              final item = playerNameControllers.removeAt(
                                oldIndex,
                              );
                              playerNameControllers.insert(newIndex, item);
                            }
                          });
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            key: ValueKey(index),
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomTheme.tileColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                spacing: 4,
                                children: [
                                  // Remove button
                                  AnimatedIconButton(
                                    icon: AppIcons.remove_player,
                                    color: CustomTheme.red,
                                    onPressed: () =>
                                        removePlayerTextfield(index),
                                  ),

                                  // Name field
                                  Expanded(
                                    child: TextField(
                                      controller: playerNameControllers[index],
                                      focusNode: playerNameFocusNodes[index],
                                      maxLength: 12,
                                      style: const TextStyle(
                                        color: CustomTheme.textColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      cursorColor: CustomTheme.primaryColor,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        hint: Text(
                                          '${loc.player} ${index + 1}',
                                          style: TextStyle(
                                            color: CustomTheme.hintTextColor,
                                          ),
                                        ),
                                        counterText: '',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction:
                                          index + 1 <
                                              playerNameControllers.length
                                          ? TextInputAction.next
                                          : TextInputAction.done,
                                      onSubmitted: (_) {
                                        if (index + 1 <
                                            playerNameFocusNodes.length) {
                                          final nextNode =
                                              playerNameFocusNodes[index + 1];
                                          nextNode.requestFocus();
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                                final nextContext =
                                                    nextNode.context;
                                                if (nextContext != null) {
                                                  Scrollable.ensureVisible(
                                                    nextContext,
                                                    alignment: 0.5,
                                                    duration: const Duration(
                                                      milliseconds: 200,
                                                    ),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }
                                              });
                                        } else {
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                    ),
                                  ),

                                  // Drag handle
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: ReorderableDragStartListener(
                                      index: index,
                                      child: AppIcon(
                                        AppIcons.drag,
                                        color: CustomTheme.subtitleColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        proxyDecorator:
                            (
                              Widget child,
                              int index,
                              Animation<double> animation,
                            ) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, _) {
                                  final overlayOpacity = 0.08 * animation.value;
                                  return Material(
                                    color: Colors.transparent,
                                    elevation: 6.0,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Stack(
                                      children: [
                                        child,
                                        Positioned.fill(
                                          child: IgnorePointer(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withValues(
                                                  alpha: overlayOpacity,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                      ),
                      hasReachedMaxPlayers
                          ? const SizedBox(width: double.infinity)
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 50),
                              child: AddPlayerButton(
                                onPressed: addPlayerTextfield,
                              ),
                            ),
                    ],
                  ),
                ),
              ),

              // Button
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  right: 16,
                  left: 16,
                ),
                child: AnimtedTextButton(
                  text: loc.create_game,
                  onPressed: isValidGame ? () async => createGame() : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeController() {
    // Prefill player
    if (widget.players != null) {
      for (var player in widget.players!) {
        final controller = TextEditingController(text: player);
        controller.addListener(() => setState(() {}));
        playerNameControllers.add(controller);
        playerNameFocusNodes.add(FocusNode());
      }
    } else {
      playerNameControllers = List.generate(
        minPlayers,
        (index) => TextEditingController()..addListener(() => setState(() {})),
      );
      playerNameFocusNodes = List.generate(minPlayers, (index) => FocusNode());
    }
  }

  void addPlayerTextfield() {
    setState(() {
      playerNameControllers.add(
        TextEditingController()..addListener(() => setState(() {})),
      );
      playerNameFocusNodes.add(FocusNode());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerNameFocusNodes.last.requestFocus();
    });
  }

  void removePlayerTextfield(int index) {
    setState(() {
      playerNameControllers[index].dispose();
      playerNameControllers.removeAt(index);
      playerNameFocusNodes[index].dispose();
      playerNameFocusNodes.removeAt(index);
    });
  }

  /// Returns a widget that displays the currently selected game mode in the View.
  Text getDisplayedGameMode() {
    final loc = AppLocalizations.of(context);
    const textStyle = TextStyle(color: CustomTheme.textColor);
    final selectedTextStyle = textStyle.copyWith(
      color: CustomTheme.primaryColor,
    );

    if (selectedGameMode == GameMode.none) {
      return Text(loc.no_mode_selected, style: textStyle);
    } else if (selectedGameMode == GameMode.pointLimit) {
      return Text(
        getPointLabel(loc, ConfigService.getPointLimit()),
        style: selectedTextStyle,
      );
    } else {
      return Text(loc.unlimited, style: selectedTextStyle);
    }
  }

  /// Checks if every player has a name.
  /// Returns true if all players have a name, false otherwise.
  bool get everyPlayerHasAName =>
      playerNameControllers.every((controller) => controller.text != '');

  /// Creates a new gameSession and navigates to the active game view.
  /// This method creates a new gameSession object with the provided attributes in the text fields.
  /// It then adds the game session to the game manager and navigates to the active game view.
  void createGame() {
    var uuid = const Uuid();
    final String gameSessionId = uuid.v4();

    // Collect player names from the text controllers.
    List<String> playerNames = [];
    for (var controller in playerNameControllers) {
      playerNames.add(controller.text);
    }

    // Create a list of Player objects with unique IDs and the corresponding attributes
    List<Player> players = [];
    for (int i = 0; i < playerNames.length; i++) {
      String id = uuid.v4();
      players.add(
        Player(
          id: id,
          gameSessionId: gameSessionId,
          name: playerNames[i],
          position: i,
        ),
      );
    }

    final String title = titleController.text == ''
        ? getFallbackGameTitle()
        : titleController.text;

    final bool isPointsLimitEnabled = selectedGameMode == GameMode.pointLimit;

    GameSession gameSession = GameSession(
      id: gameSessionId,
      createdAt: DateTime.now(),
      title: title,
      players: players,
      pointLimit: isPointsLimitEnabled ? ConfigService.getPointLimit() : null,
      caboPenalty: ConfigService.getCaboPenalty(),
      isGameFinished: false,
    );

    final db = Provider.of<AppDatabase>(context, listen: false);
    db.gameSessionDao.addGameSession(gameSession);
    widget.onSessionsUpdated();

    Navigator.pushAndRemoveUntil(
      context,
      adaptivePageRoute(
        builder: (context) => ActiveGameView(
          gameSession: gameSession,
          onSessionsUpdated: widget.onSessionsUpdated,
        ),
      ),
      (Route<dynamic> route) => route.isFirst,
    );
  }

  /// Generates a fallback game title based on the current date and locale.
  /// If the user does not provide a game title, this method will create one
  /// using the current date formatted according to the user's locale.
  String getFallbackGameTitle() {
    final locale = Localizations.localeOf(context);
    final formattedDate = DateFormat(
      'dd.MM.yy',
      locale.toLanguageTag(),
    ).format(DateTime.now());

    return AppLocalizations.of(context).standard_game_title(formattedDate);
  }
}
