import 'package:fv1/services/audio_player/player_stream_data.dart';

abstract class AppAudioPlayer {
  Future<void> init();
  Future<void> loadAndPlay(String url);
  void play();
  void pause();
  void seek(Duration position);
  Future<void> dispose();
  void onPlayerUnmounted() {}

  Stream<PlayerStreamData>? dataStream;
}
