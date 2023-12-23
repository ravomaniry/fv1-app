// Mocks generated by Mockito 5.4.2 from annotations
// in fv1/test/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:fv1/models/login_data.dart' as _i11;
import 'package:fv1/models/progress.dart' as _i2;
import 'package:fv1/models/register_data.dart' as _i12;
import 'package:fv1/models/teaching_summary.dart' as _i6;
import 'package:fv1/models/user.dart' as _i3;
import 'package:fv1/services/api_client/auth_service.dart' as _i10;
import 'package:fv1/services/audio_player/audio_player.dart' as _i7;
import 'package:fv1/services/audio_player/player_stream_data.dart' as _i8;
import 'package:fv1/services/data/data_service.dart' as _i4;
import 'package:fv1/services/datetime/datetime_service.dart' as _i9;
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

class _FakeDateTime_1 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserModel_2 extends _i1.SmartFake implements _i3.UserModel {
  _FakeUserModel_2(
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
    implements _i4.AbstractDataService {
  @override
  _i5.Future<void> sync() => (super.noSuchMethod(
        Invocation.method(
          #sync,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<List<_i2.ProgressModel>> loadProgresses() => (super.noSuchMethod(
        Invocation.method(
          #loadProgresses,
          [],
        ),
        returnValue:
            _i5.Future<List<_i2.ProgressModel>>.value(<_i2.ProgressModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i2.ProgressModel>>.value(<_i2.ProgressModel>[]),
      ) as _i5.Future<List<_i2.ProgressModel>>);
  @override
  _i5.Future<List<_i6.TeachingSummaryModel>> loadNewTeachings() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadNewTeachings,
          [],
        ),
        returnValue: _i5.Future<List<_i6.TeachingSummaryModel>>.value(
            <_i6.TeachingSummaryModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i6.TeachingSummaryModel>>.value(
                <_i6.TeachingSummaryModel>[]),
      ) as _i5.Future<List<_i6.TeachingSummaryModel>>);
  @override
  _i5.Future<_i2.ProgressModel> startTeaching(int? id) => (super.noSuchMethod(
        Invocation.method(
          #startTeaching,
          [id],
        ),
        returnValue: _i5.Future<_i2.ProgressModel>.value(_FakeProgressModel_0(
          this,
          Invocation.method(
            #startTeaching,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.ProgressModel>.value(_FakeProgressModel_0(
          this,
          Invocation.method(
            #startTeaching,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.ProgressModel>);
  @override
  _i5.Future<String> getAudioUrl(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getAudioUrl,
          [id],
        ),
        returnValue: _i5.Future<String>.value(''),
        returnValueForMissingStub: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  _i5.Future<void> saveProgress(_i2.ProgressModel? progress) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveProgress,
          [progress],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [AppAudioPlayer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppAudioPlayer extends _i1.Mock implements _i7.AppAudioPlayer {
  @override
  set dataStream(_i5.Stream<_i8.PlayerStreamData>? _dataStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #dataStream,
          _dataStream,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadAndPlay(String? url) => (super.noSuchMethod(
        Invocation.method(
          #loadAndPlay,
          [url],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
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
  _i5.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void onPlayerUnmounted() => super.noSuchMethod(
        Invocation.method(
          #onPlayerUnmounted,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DateTimeService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTimeService extends _i1.Mock implements _i9.DateTimeService {
  @override
  DateTime now() => (super.noSuchMethod(
        Invocation.method(
          #now,
          [],
        ),
        returnValue: _FakeDateTime_1(
          this,
          Invocation.method(
            #now,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeDateTime_1(
          this,
          Invocation.method(
            #now,
            [],
          ),
        ),
      ) as DateTime);
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i10.AuthService {
  @override
  _i5.Future<_i3.UserModel> login(_i11.LoginData? data) => (super.noSuchMethod(
        Invocation.method(
          #login,
          [data],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #login,
            [data],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #login,
            [data],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<_i3.UserModel> register(_i12.RegisterData? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [data],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #register,
            [data],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #register,
            [data],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<_i3.UserModel> registerGuest() => (super.noSuchMethod(
        Invocation.method(
          #registerGuest,
          [],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #registerGuest,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #registerGuest,
            [],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  void logOut() => super.noSuchMethod(
        Invocation.method(
          #logOut,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<String> getAccessToken() => (super.noSuchMethod(
        Invocation.method(
          #getAccessToken,
          [],
        ),
        returnValue: _i5.Future<String>.value(''),
        returnValueForMissingStub: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
}
