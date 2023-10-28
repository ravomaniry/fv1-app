import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';

class AudioPlayerWidget extends StatefulWidget {
  static const playerKey = Key('AudioPlayer');
  final AppTexts texts;
  final AppAudioPlayer player;

  const AudioPlayerWidget({
    super.key,
    required this.player,
    required this.texts,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  @override
  void dispose() {
    super.dispose();
    widget.player.onPlayerUnmounted();
  }

  Widget _buildPlayPauseButton(BuildContext context, PlayerStreamData data) {
    final color = Theme.of(context).primaryColorLight;
    return data.state() == InternalPlayerState.playing
        ? IconButton(
            color: color,
            key: const Key('PauseButton'),
            onPressed: () => widget.player.pause(),
            icon: const Icon(Icons.pause_circle_outline),
          )
        : IconButton(
            color: color,
            key: const Key('PlayButton'),
            onPressed: () => widget.player.play(),
            icon: const Icon(Icons.play_circle_outline),
          );
  }

  Widget _buildLoader() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(widget.texts.loadingAudio),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder(
      key: AudioPlayerWidget.playerKey,
      stream: widget.player.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        if (data == null ||
            data.state() == InternalPlayerState.busy ||
            data.state() == InternalPlayerState.error) {
          return _buildLoader();
        }
        return Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.only(left: 4, right: 4),
          color: Colors.black87,
          child: Row(
            children: [
              _buildPlayPauseButton(context, data),
              const SizedBox(width: 4),
              Expanded(
                child: ProgressBar(
                  key: const Key('PlayerProgressBar'),
                  timeLabelLocation: TimeLabelLocation.sides,
                  progress: data.position() ?? Duration.zero,
                  total: data.totalDuration() ?? Duration.zero,
                  onSeek: (position) => widget.player.seek(position),
                  progressBarColor: theme.primaryColorLight,
                  thumbColor: theme.primaryColorLight,
                  baseBarColor: Colors.white,
                  timeLabelTextStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
