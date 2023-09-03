import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';

class AudioPlayerWidget extends StatefulWidget {
  static const playerKey = Key('AudioPlayer');
  final AppAudioPlayer player;

  const AudioPlayerWidget({super.key, required this.player});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  void dispose() {
    super.dispose();
    widget.player.onPlayerUnmounted();
  }

  Widget _buildPlayPauseButton(PlayerStreamData data) {
    return data.state() == InternalPlayerState.playing
        ? IconButton(
            onPressed: () => widget.player.pause(),
            icon: const Icon(Icons.pause_circle_outline),
          )
        : IconButton(
            onPressed: () => widget.player.play(),
            icon: const Icon(Icons.play_circle_outline),
          );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: AudioPlayerWidget.playerKey,
      stream: widget.player.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const LinearProgressIndicator(value: null);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlayPauseButton(data),
            ProgressBar(
              progress: data.position() ?? Duration.zero,
              total: data.totalDuration() ?? Duration.zero,
              onSeek: (position) => widget.player.seek(position),
            ),
          ],
        );
      },
    );
  }
}
