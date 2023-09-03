import 'package:flutter/foundation.dart';
import 'package:fv1/models/chapter.dart';

class TeachingModel {
  final int id;
  final String title;
  final String subtitle;
  final List<ChapterModel> chapters;

  TeachingModel(this.id, this.title, this.subtitle, this.chapters);

  factory TeachingModel.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> chapters = json['chapters'];
    return TeachingModel(
      json['id'],
      json['title'],
      json['subtitle'],
      chapters.map((e) => ChapterModel.fromJson(e)).toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'chapters': chapters.map((e) => e.toJson()),
    };
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ subtitle.hashCode ^ chapters.hashCode;

  @override
  bool operator ==(Object other) =>
      other is TeachingModel &&
      id == other.id &&
      title == other.title &&
      subtitle == other.subtitle &&
      listEquals(chapters, other.chapters);
}
