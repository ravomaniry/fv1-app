import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/web_player.dart';

AppAudioPlayer createAudioPlayer() {
  return WebAudioPlayer();
}
