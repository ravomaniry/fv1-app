import 'package:flutter/widgets.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/ui/widgets/AudioPlayer.dart';
import 'package:fv1/ui/widgets/h2.dart';

class SectionWidget extends StatelessWidget {
  final SectionModel _section;

  const SectionWidget(this._section, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenH2(_section.subtitle),
        Text(_section.content),
        AudioPlayer(_section.audioUrl),
      ],
    );
  }
}
