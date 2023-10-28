import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';
import 'package:fv1/ui/widgets/audio_player.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AppAudioPlayer>()])
import 'audio_player_ui_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  testWidgets('UI reflects state', (tester) async {
    final streamData = JustAudioStreamData();
    final streamCtr = StreamController<PlayerStreamData>();
    final player = MockAppAudioPlayer();
    when(player.dataStream).thenAnswer((_) => streamCtr.stream);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AudioPlayerWidget(player: player, texts: mgTexts),
        ),
      ),
    );
    await tick(tester, 5);
    // Send data
    streamCtr.add(streamData);
    await tick(tester, 1);
    // Display
    expect(find.text(mgTexts.loadingAudio), findsOneWidget);
    // Error
    streamData.playerState = InternalPlayerState.error;
    streamCtr.add(streamData);
    await tick(tester, 1);
    expect(find.text(mgTexts.loadingAudio), findsOneWidget);
    // Playing
    streamData.playerState = InternalPlayerState.playing;
    streamData.playerTotalDuration = const Duration(seconds: 10);
    streamCtr.add(streamData);
    await tick(tester, 1);
    expect(find.byKey(const Key('PauseButton')), findsOneWidget);
    expect(find.byKey(const Key('PlayerProgressBar')), findsOneWidget);
    // Tap pause button
    verifyNever(player.pause());
    await tapByStringKey(tester, 'PauseButton');
    verify(player.pause()).called(1);
    // Paused
    streamData.playerState = InternalPlayerState.idle;
    streamCtr.add(streamData);
    await tick(tester, 1);
    expect(find.byKey(const Key('PlayButton')), findsOneWidget);
    // Tap play button
    verifyNever(player.play());
    await tapByStringKey(tester, 'PlayButton');
    verify(player.play()).called(1);
  });
}
