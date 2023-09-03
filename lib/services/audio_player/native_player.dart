import 'package:fv1/services/audio_player/just_audio_player.dart';

class NativeAudioPlayer extends JustAudioPlayer {
  @override
  Future<void> load(String url) async {
    await init();
    // Download
    // Load from local disk
  }
}
