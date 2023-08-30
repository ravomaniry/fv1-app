import 'package:flutter/material.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/ui/widgets/audio_player.dart';
import 'package:fv1/ui/widgets/card_container.dart';

class SectionWidget extends StatelessWidget {
  final SectionModel _section;

  const SectionWidget(this._section, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(_section.subtitle),
            subtitle: Text(
              _section.content,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          AudioPlayer(_section.audioUrl),
        ],
      ),
    );
  }
}
