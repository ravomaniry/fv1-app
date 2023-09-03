import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';
import 'package:fv1/ui/widgets/error_text.dart';

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
    final color = Theme.of(context).colorScheme.secondary;
    return data.state() == InternalPlayerState.playing
        ? IconButton(
            color: color,
            onPressed: () => widget.player.pause(),
            icon: const Icon(Icons.pause_circle_outline),
          )
        : IconButton(
            color: color,
            onPressed: () => widget.player.play(),
            icon: const Icon(Icons.play_circle_outline),
          );
  }

  Widget _buildLoader() {
    return const CircularProgressIndicator();
  }

  Widget _buildErrorMessage(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return Row(
      children: [
        Icon(
          Icons.error,
          color: color,
        ),
        Expanded(
          child: ErrorText(widget.texts.playerError),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return StreamBuilder(
      key: AudioPlayerWidget.playerKey,
      stream: widget.player.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        if (data == null || data.state() == InternalPlayerState.busy) {
          return _buildLoader();
        } else if (data.state() == InternalPlayerState.error) {
          return _buildErrorMessage(context);
        }
        return Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
            color: const Color(0xfff4f4f4),
            border: Border(
              top: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildPlayPauseButton(context, data),
              const SizedBox(width: 4),
              Expanded(
                child: ProgressBar(
                  timeLabelLocation: TimeLabelLocation.sides,
                  progress: data.position() ?? Duration.zero,
                  total: data.totalDuration() ?? Duration.zero,
                  onSeek: (position) => widget.player.seek(position),
                  progressBarColor: colors.secondary,
                  thumbColor: colors.secondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
