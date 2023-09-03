class ChapterScore {
  final double correctAnswersPercentage;

  ChapterScore({required this.correctAnswersPercentage});

  factory ChapterScore.fromJson(Map<dynamic, dynamic> json) {
    return ChapterScore(
      correctAnswersPercentage:
          (json['correctAnswersPercentage'] as int).toDouble(),
    );
  }

  factory ChapterScore.zero() => ChapterScore(correctAnswersPercentage: 0);

  Map<String, dynamic> toJson() {
    return {
      'correctAnswersPercentage': correctAnswersPercentage,
    };
  }

  @override
  int get hashCode => correctAnswersPercentage.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ChapterScore &&
      correctAnswersPercentage == other.correctAnswersPercentage;

  @override
  String toString() => 'ChapterScore${toJson().toString()}';
}
