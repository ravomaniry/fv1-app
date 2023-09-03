enum InternalPlayerState {
  playing,
  busy,
  idle,
}

abstract class PlayerStreamData {
  InternalPlayerState state();
  Duration? totalDuration();
  Duration? position();
  double volume();
}

class JustAudioStreamData implements PlayerStreamData {
  InternalPlayerState playerState = InternalPlayerState.busy;
  Duration? playerTotalDuration = Duration.zero;
  Duration? playerPosition = Duration.zero;
  double playerVolume = 0;

  @override
  Duration? position() => playerPosition;

  @override
  InternalPlayerState state() => playerState;

  @override
  Duration? totalDuration() => playerTotalDuration;

  @override
  double volume() => playerVolume;
}
