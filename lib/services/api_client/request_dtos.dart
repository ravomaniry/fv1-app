import 'package:fv1/models/progress.dart';

class RequestDto {
  final Map<String, dynamic> data;

  RequestDto(this.data);
}

class SaveProgressReqDto extends RequestDto {
  SaveProgressReqDto(ProgressModel progress)
      : super({
          'scores': progress.scores,
          'clientTimestamp': progress.clientTimestamp,
        });
}
