import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

abstract class JustAudioPlayer extends AppAudioPlayer {
  final AudioPlayer _player = AudioPlayer();
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    if (!_isInitialized) {
      _isInitialized = true;
      await JustAudioBackground.init(
        androidNotificationChannelId: 'mg.fv1.fv1',
        androidNotificationChannelName: 'Fv1',
        androidNotificationOngoing: true,
      );
    }
  }

  @override
  void play() => _player.play();

  @override
  void pause() => _player.pause();

  @override
  void seek(Duration position) => _player.seek(position);

  @override
  Stream<Duration> get position => _player.positionStream;

  @override
  Stream<Duration> get totalDuration => _player.durationStream.map(
        (duration) => duration ?? Duration.zero,
      );

  @override
  Future<void> dispose() async {
    if (_isInitialized) {
      await _player.dispose();
    }
  }
}
