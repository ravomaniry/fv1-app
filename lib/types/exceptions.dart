import 'package:fv1/models/texts.dart';

abstract class AppException {
  String getMessage(AppTexts texts);
}

class InternetErrorException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorInternet;
}

class AudioPlayerErrorException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorAudioPlayer;
}

class InvalidCredentialException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorInvalidCredentials;
}

class NotConnectedException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorNotConnected;
}

class DuplicateUsernameException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorDuplicateUsername;
}

class WeakPasswordException extends AppException {
  @override
  String getMessage(AppTexts texts) => texts.errorWeakPassword;
}
