import 'package:flutter/material.dart';
import 'package:fv1/services/audio_player/audio_player.dart';

class AudioPlayerWidget extends StatelessWidget {
  static const playerKey = Key('AudioPlayer');
  final AppAudioPlayer player;

  const AudioPlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: playerKey,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: 0.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
