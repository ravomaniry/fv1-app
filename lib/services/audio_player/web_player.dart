import 'package:fv1/services/audio_player/just_audio_player.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class WebAudioPlayer extends JustAudioPlayer {
  @override
  Future<void> loadAndPlay(String url) async {
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(id: url, title: 'Fitiavana voalohany'),
      ),
    );
    player.play();
  }
}
