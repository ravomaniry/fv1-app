import 'package:fv1/models/serializable.dart';

class SectionModel implements Serializable {
  final String subtitle;
  final String verses;
  final String comment;
  final String audioId;

  SectionModel({
    required this.subtitle,
    required this.verses,
    required this.comment,
    required this.audioId,
  });

  factory SectionModel.fromJson(Map<dynamic, dynamic> json) {
    return SectionModel(
      subtitle: json['subtitle'],
      verses: json['verses'],
      comment: json['comment'],
      audioId: json['audioId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'subtitle': subtitle,
      'verses': verses,
      'comment': comment,
      'audioId': audioId,
    };
  }

  @override
  int get hashCode =>
      subtitle.hashCode ^ verses.hashCode ^ comment.hashCode ^ audioId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SectionModel &&
      other.verses == verses &&
      other.subtitle == subtitle &&
      other.comment == comment &&
      other.audioId == audioId;

  @override
  String toString() => 'SectionModel<${toJson().toString()}>';
}
