/// Sorting options for the game list in the main menu.
/// - [date]: Sort by date
/// - [title]: Sort by title
enum SortOption { date, title }

/// Sorting directions for the game list in the main menu.
/// - [ascending]: Ascending order
/// - [descending]: Descending order
enum SortDirection { ascending, descending }

/// Decisions for the pre-rating dialog in the main menu.
/// - [yes]: User likes the app
/// - [no]: User dislikes the app
/// - [cancel]: User dismissed the dialog
enum PreRatingDialogDecision { yes, no, cancel }

/// Decisions for the bad-rating dialog in the main menu.
/// - [email]: User wants to send an email
/// - [cancel]: User dismissed the dialog
enum BadRatingDialogDecision { email, cancel }

/// Game modes available for a game session.
/// - [none]: No game mode selected
/// - [pointLimit]: Point limit mode
/// - [unlimited]: Unlimited mode
enum GameMode { none, pointLimit, unlimited }

/// Status codes for creating a new game session.
/// - [noModeSelected]: No game mode selected
/// - [minPlayers]: Not enough players
/// - [maxPlayers]: Too many players
/// - [noPlayerName]: A player has no name
enum CreateStatus { noModeSelected, minPlayers, maxPlayers, noPlayerName }

/// Status codes for importing game data from a JSON file.
/// - [success]: Import successful
/// - [canceled]: Import canceled by user
/// - [validationError]: JSON validation error
/// - [formatError]: JSON format error
/// - [genericError]: Generic error during import
/// - [duplicatesFound]: Some games were not imported because their IDs
///   already exist locally
enum ImportStatus {
  success,
  canceled,
  duplicatesFound,
  validationError,
  formatError,
  genericError,
}

/// Visual style of a [CustomPopupAction].
enum CustomPopupActionStyle { primary, secondary }
