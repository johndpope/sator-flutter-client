import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/challenge.dart';
import 'package:satorio/util/extension.dart';

class ChallengeModel extends Challenge implements ToJsonInterface {
  const ChallengeModel(
    String id,
    String title,
    String description,
    String prizePool,
    int players,
    String winners,
    String timePerQuestion,
    String play,
    int userMaxAttempts,
    int attemptsLeft,
    double receivedReward,
    String receivedRewardAsString,
  ) : super(
          id,
          title,
          description,
          prizePool,
          players,
          winners,
          timePerQuestion,
          play,
          userMaxAttempts,
          attemptsLeft,
          receivedReward,
          receivedRewardAsString,
        );

  factory ChallengeModel.fromJson(Map json) => ChallengeModel(
        json.parseValueAsString('id'),
        json.parseValueAsString('title'),
        json.parseValueAsString('description'),
        json.parseValueAsString('prize_pool'),
        json.parseValueAsInt('players'),
        json.parseValueAsString('winners'),
        json.parseValueAsString('time_per_question'),
        json.parseValueAsString('play'),
        json.parseValueAsInt('user_max_attempts'),
        json.parseValueAsInt('attempts_left'),
        json.parseValueAsDouble('received_reward'),
        json.parseValueAsString('received_reward_str'),
      );

  @override
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'prize_pool': prizePool,
        'players': players,
        'winners': winners,
        'time_per_question': timePerQuestion,
        'play': play,
        'user_max_attempts': userMaxAttempts,
        'attempts_left': attemptsLeft,
        'received_reward': receivedReward,
        'received_reward_str': receivedRewardAsString,
      };
}
