// Mocks generated by Mockito 5.4.2 from annotations
// in fv1/test/api_client_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i5;
import 'dart:typed_data' as _i6;

import 'package:fv1/models/user.dart' as _i9;
import 'package:fv1/models/user_tokens.dart' as _i8;
import 'package:fv1/services/api_client/http_client.dart' as _i3;
import 'package:fv1/services/storage/storage_service.dart' as _i7;
import 'package:http/http.dart' as _i2;
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

class _FakeStreamedResponse_0 extends _i1.SmartFake
    implements _i2.StreamedResponse {
  _FakeStreamedResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CustomHttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomHttpClient extends _i1.Mock implements _i3.CustomHttpClient {
  @override
  _i4.Future<_i2.StreamedResponse> send(_i2.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i4.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_0(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_0(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i4.Future<_i2.StreamedResponse>);
  @override
  _i4.Future<_i2.Response> postJson(
    Uri? uri,
    Map<String, dynamic>? body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postJson,
          [
            uri,
            body,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #postJson,
            [
              uri,
              body,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #postJson,
            [
              uri,
              body,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> putJson(
    Uri? uri,
    Map<String, dynamic>? body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #putJson,
          [
            uri,
            body,
          ],
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #putJson,
            [
              uri,
              body,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #putJson,
            [
              uri,
              body,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);
  @override
  _i4.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<String>.value(''),
        returnValueForMissingStub: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<_i6.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
        returnValueForMissingStub:
            _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [StorageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageService extends _i1.Mock implements _i7.StorageService {
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
  _i4.Future<_i8.UserTokens?> getTokens() => (super.noSuchMethod(
        Invocation.method(
          #getTokens,
          [],
        ),
        returnValue: _i4.Future<_i8.UserTokens?>.value(),
        returnValueForMissingStub: _i4.Future<_i8.UserTokens?>.value(),
      ) as _i4.Future<_i8.UserTokens?>);
  @override
  void saveTokens(_i8.UserTokens? tokens) => super.noSuchMethod(
        Invocation.method(
          #saveTokens,
          [tokens],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveUser(_i9.UserModel? user) => super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void deleteToken() => super.noSuchMethod(
        Invocation.method(
          #deleteToken,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void deleteUser() => super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool isHelpViewed() => (super.noSuchMethod(
        Invocation.method(
          #isHelpViewed,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void setIsHelpViewed() => super.noSuchMethod(
        Invocation.method(
          #setIsHelpViewed,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
