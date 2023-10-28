import 'package:flutter/foundation.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/serializable.dart';
import 'package:fv1/models/teaching.dart';

class ProgressModel implements Serializable {
  final int id;
  final TeachingModel teaching;
  final List<ChapterScore> scores;
  final int clientTimestamp;
  double _completionPercentage = 0;
  double get completionPercentage => _completionPercentage;

  ProgressModel({
    required this.id,
    required this.teaching,
    required this.scores,
    required this.clientTimestamp,
  }) {
    _calculateCompletionPercentage();
  }

  factory ProgressModel.fromJson(Map<dynamic, dynamic> json) {
    return ProgressModel(
      id: json['id'],
      teaching: TeachingModel.fromJson(json['teaching']),
      clientTimestamp: json['clientTimestamp'],
      scores: List<ChapterScore>.from(
        json['scores'].map((e) => ChapterScore.fromJson(e)),
      ),
    );
  }

  bool isChapterDone(int index) {
    return scores.length > index &&
        scores[index].correctAnswersPercentage >= 0.75;
  }

  void _calculateCompletionPercentage() {
    int completed = 0;
    for (int i = 0; i < teaching.chapters.length; i++) {
      if (isChapterDone(i)) {
        completed++;
      }
    }
    _completionPercentage = completed / teaching.chapters.length;
  }

  int getNextChapterIndex() {
    for (int i = 0; i < scores.length; i++) {
      if (!isChapterDone(i)) {
        return i;
      }
    }
    return scores.length < teaching.chapters.length ? scores.length : 0;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teaching': teaching,
      'scores': scores,
      'clientTimestamp': clientTimestamp,
    };
  }

  @override
  int get hashCode => teaching.hashCode ^ scores.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ProgressModel &&
      other.id == id &&
      other.teaching == teaching &&
      other.clientTimestamp == clientTimestamp &&
      listEquals(scores, other.scores);

  @override
  String toString() => 'ProgressModel${toJson().toString()}';
}
