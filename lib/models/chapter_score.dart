import 'package:fv1/models/serializable.dart';

class ChapterScore implements Serializable {
  final double correctAnswersPercentage;

  ChapterScore({required this.correctAnswersPercentage});

  factory ChapterScore.fromJson(Map<dynamic, dynamic> json) {
    return ChapterScore(
      correctAnswersPercentage: json['correctAnswersPercentage'].toDouble(),
    );
  }

  factory ChapterScore.zero() => ChapterScore(correctAnswersPercentage: 0);

  @override
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
