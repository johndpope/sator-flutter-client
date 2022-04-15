class PuzzleGame {
  final String id;
  final String episodeId;
  final double prizePool;
  final double rewards;
  final double bonusRewards;
  final int xSize;
  final int steps;
  final int stepsTaken;
  final int status;
  final int result;
  final String image;

  const PuzzleGame(
    this.id,
    this.episodeId,
    this.prizePool,
    this.rewards,
    this.bonusRewards,
    this.xSize,
    this.steps,
    this.stepsTaken,
    this.status,
    this.result,
    this.image,
  );
}

class PuzzleGameStatus {
  static const notStarted = 0;
  static const inProgress = 1;
  static const finished = 2;
}

class PuzzleGameResult {
  static const notFinished = 0;
  static const userWon = 1;
  static const userLost = 2;
}