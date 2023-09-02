// Mocks generated by Mockito 5.4.2 from annotations
// in fv1/test/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:fv1/models/progress.dart' as _i2;
import 'package:fv1/models/teaching_summary.dart' as _i5;
import 'package:fv1/services/audio_player/audio_player.dart' as _i6;
import 'package:fv1/services/data/data_service.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProgressModel_0 extends _i1.SmartFake implements _i2.ProgressModel {
  _FakeProgressModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AbstractDataService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbstractDataService extends _i1.Mock
    implements _i3.AbstractDataService {
  @override
  _i4.Future<void> sync() => (super.noSuchMethod(
        Invocation.method(
          #sync,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i2.ProgressModel>> loadProgresses() => (super.noSuchMethod(
        Invocation.method(
          #loadProgresses,
          [],
        ),
        returnValue:
            _i4.Future<List<_i2.ProgressModel>>.value(<_i2.ProgressModel>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.ProgressModel>>.value(<_i2.ProgressModel>[]),
      ) as _i4.Future<List<_i2.ProgressModel>>);
  @override
  _i4.Future<List<_i5.TeachingSummaryModel>> loadNewTeachings() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadNewTeachings,
          [],
        ),
        returnValue: _i4.Future<List<_i5.TeachingSummaryModel>>.value(
            <_i5.TeachingSummaryModel>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i5.TeachingSummaryModel>>.value(
                <_i5.TeachingSummaryModel>[]),
      ) as _i4.Future<List<_i5.TeachingSummaryModel>>);
  @override
  _i4.Future<_i2.ProgressModel> startTeaching(int? id) => (super.noSuchMethod(
        Invocation.method(
          #startTeaching,
          [id],
        ),
        returnValue: _i4.Future<_i2.ProgressModel>.value(_FakeProgressModel_0(
          this,
          Invocation.method(
            #startTeaching,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.ProgressModel>.value(_FakeProgressModel_0(
          this,
          Invocation.method(
            #startTeaching,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.ProgressModel>);
  @override
  _i4.Future<String> getAudioUrl(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getAudioUrl,
          [id],
        ),
        returnValue: _i4.Future<String>.value(''),
        returnValueForMissingStub: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
}

/// A class which mocks [AppAudioPlayer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppAudioPlayer extends _i1.Mock implements _i6.AppAudioPlayer {
  @override
  _i4.Stream<Duration> get position => (super.noSuchMethod(
        Invocation.getter(#position),
        returnValue: _i4.Stream<Duration>.empty(),
        returnValueForMissingStub: _i4.Stream<Duration>.empty(),
      ) as _i4.Stream<Duration>);
  @override
  _i4.Stream<Duration> get totalDuration => (super.noSuchMethod(
        Invocation.getter(#totalDuration),
        returnValue: _i4.Stream<Duration>.empty(),
        returnValueForMissingStub: _i4.Stream<Duration>.empty(),
      ) as _i4.Stream<Duration>);
  @override
  _i4.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> load(String? url) => (super.noSuchMethod(
        Invocation.method(
          #load,
          [url],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void play() => super.noSuchMethod(
        Invocation.method(
          #play,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void pause() => super.noSuchMethod(
        Invocation.method(
          #pause,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void seek(Duration? position) => super.noSuchMethod(
        Invocation.method(
          #seek,
          [position],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
