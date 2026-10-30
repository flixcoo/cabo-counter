import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

/// This class represents a single round in the game.
/// - [kamikazePlayerIndex] is the index of the player who got kamikaze. If no one got
/// - [scores] is a list of the actual scores the players got.
/// - [scoreUpdates] is a list of how the players scores updated this round.
/// kamikaze, this value is null.
class Round {
  final String id;
  final String gameSessionId;
  final int caboPlayerIndex;
  final int? kamikazePlayerIndex;
  final List<int> scores;
  final List<int> scoreUpdates;

  Round({
    String? roundId,
    required this.gameSessionId,
    required this.caboPlayerIndex,
    required this.scores,
    required this.scoreUpdates,
    this.kamikazePlayerIndex,
  }) : assert(
         scores.length == scoreUpdates.length,
         'scores and scoreUpdates must have the same length',
       ),
       assert(
         caboPlayerIndex >= 0 && caboPlayerIndex < scores.length,
         'caboPlayerIndex is out of range',
       ),
       assert(
         kamikazePlayerIndex == null ||
             (kamikazePlayerIndex >= 0 && kamikazePlayerIndex < scores.length),
         'kamikazePlayerIndex is out of range',
       ),
       id = roundId ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'gameSessionId': gameSessionId,
    'caboPlayerIndex': caboPlayerIndex,
    'kamikazePlayerIndex': kamikazePlayerIndex,
    'scores': scores,
    'scoreUpdates': scoreUpdates,
  };

  Round.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      gameSessionId = json['gameSessionId'],
      caboPlayerIndex = json['caboPlayerIndex'],
      kamikazePlayerIndex = json['kamikazePlayerIndex'],
      scores = List<int>.from(json['scores']),
      scoreUpdates = List<int>.from(json['scoreUpdates']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Round &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          gameSessionId == other.gameSessionId &&
          caboPlayerIndex == other.caboPlayerIndex &&
          kamikazePlayerIndex == other.kamikazePlayerIndex &&
          const ListEquality<int>().equals(scores, other.scores) &&
          const ListEquality<int>().equals(scoreUpdates, other.scoreUpdates);

  @override
  int get hashCode => Object.hash(
    id,
    gameSessionId,
    caboPlayerIndex,
    kamikazePlayerIndex,
    const ListEquality<int>().hash(scores),
    const ListEquality<int>().hash(scoreUpdates),
  );
}
