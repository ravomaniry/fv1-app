import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

abstract class JustAudioPlayer extends AppAudioPlayer {
  bool _isInitialized = false;
  late AudioPlayer _player;
  AudioPlayer get player => _player;

  final _dataStreamController = StreamController<PlayerStreamData>();
  final _streamData = JustAudioStreamData();

  late Stream<PlayerStreamData>? _dataStream;
  @override
  Stream<PlayerStreamData>? get dataStream => _dataStream;

  JustAudioPlayer() {
    _dataStream = _dataStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> init() async {
    if (!_isInitialized) {
      _isInitialized = true;
      await JustAudioBackground.init(
        androidNotificationChannelId: 'mg.fv1.fv1',
        androidNotificationChannelName: 'Fv1',
        androidNotificationOngoing: true,
      );
      _player = AudioPlayer();
      _initStreamData();
    }
  }

  _initStreamData() {
    _player.playerStateStream.listen((state) {
      _streamData.playerState = _mapState(state);
      _dataStreamController.add(_streamData);
      // Reset seeker to make the play buttons replay the audio from the start
      if (state.playing && state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
    _player.durationStream.listen((d) {
      _streamData.playerTotalDuration = d;
      _dataStreamController.add(_streamData);
    });
    _player.positionStream.listen((pos) {
      _streamData.playerPosition = pos;
      _dataStreamController.add(_streamData);
    });
    _player.volumeStream.listen((vol) {
      _streamData.playerVolume = vol;
      _dataStreamController.add(_streamData);
    });
  }

  InternalPlayerState _mapState(PlayerState state) {
    if (state.playing) {
      return InternalPlayerState.playing;
    }
    switch (state.processingState) {
      case ProcessingState.completed:
      case ProcessingState.idle:
      case ProcessingState.ready:
        return InternalPlayerState.idle;
      default:
        return InternalPlayerState.busy;
    }
  }

  @protected
  Future<void> handleError(Future<void> Function() fn) async {
    try {
      await fn();
    } catch (e) {
      _streamData.playerState = InternalPlayerState.error;
      _dataStreamController.add(_streamData);
    }
  }

  @override
  void play() => handleError(() => _player.play());

  @override
  void pause() => handleError(() => _player.pause());

  @override
  void seek(Duration position) => handleError(() => _player.seek(position));

  @override
  void onPlayerUnmounted() {
    _player.stop();
  }

  @override
  Future<void> dispose() async {
    if (_isInitialized) {
      await _player.dispose();
    }
  }
}
