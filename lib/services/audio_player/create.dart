import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/native_player.dart';

AppAudioPlayer createAudioPlayer() {
  return NativeAudioPlayer();
}
