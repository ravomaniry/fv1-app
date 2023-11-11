import 'dart:convert';

import 'package:fv1/models/login_response.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/models/user_tokens.dart';
import 'package:http/http.dart';

typedef ParserFn<T> = T Function(dynamic data);

abstract class DtoParser<T> {
  final ParserFn<T> _parser;

  DtoParser(this._parser);

  Future<T> parse(Future<Response> futureResp) async {
    final resp = await futureResp;
    return _parser(jsonDecode(resp.body));
  }
}

abstract class ListDtoParser<T> extends DtoParser<List<T>> {
  ListDtoParser(ParserFn<T> parser)
      : super((dynamic data) {
          return data is Iterable && data.isNotEmpty
              ? List<T>.from(data.map((d) => parser(d)))
              : [];
        });
}

class GetProgressDto extends ListDtoParser<ProgressModel> {
  GetProgressDto() : super((dynamic data) => ProgressModel.fromJson(data));
}

class StartTeachingDto extends DtoParser<ProgressModel> {
  StartTeachingDto() : super((dynamic d) => ProgressModel.fromJson(d));
}

class GetAudioUrlDto extends DtoParser<String> {
  GetAudioUrlDto() : super((dynamic d) => d['url']);
}

class GetNewTeachingsDto extends ListDtoParser<TeachingSummaryModel> {
  GetNewTeachingsDto() : super((dynamic d) => TeachingSummaryModel.fromJson(d));
}

class LoginDto extends DtoParser<LoginResponseModel> {
  LoginDto() : super((dynamic d) => LoginResponseModel.fromJson(d));
}

class RefreshTokenDto extends DtoParser<UserTokens> {
  RefreshTokenDto() : super((dynamic d) => UserTokens.fromJson(d));
}
