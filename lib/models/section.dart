import 'package:fv1/models/serializable.dart';

class SectionModel implements Serializable {
  final String subtitle;
  final String content;
  final String audioId;

  SectionModel(this.subtitle, this.content, this.audioId);

  factory SectionModel.fromJson(Map<dynamic, dynamic> json) {
    return SectionModel(
      json['subtitle'],
      json['content'],
      json['audioId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'subtitle': subtitle,
      'content': content,
      'audioId': audioId,
    };
  }

  @override
  int get hashCode => subtitle.hashCode ^ content.hashCode ^ audioId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SectionModel &&
      other.content == content &&
      other.subtitle == subtitle &&
      other.audioId == audioId;

  @override
  String toString() => 'SectionModel<${toJson().toString()}>';
}
