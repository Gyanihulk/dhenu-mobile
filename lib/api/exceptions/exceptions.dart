import '../base/base_exception.dart';

class MissRequestParamsException extends BaseException {
  MissRequestParamsException(String request, String response)
      : super(400, "Something is wrong", request: request, response: response);
}

class InvalidTokenException extends BaseException {
  InvalidTokenException() : super(401, "Access token is missing or invalid.");
}

class NotFoundException extends BaseException {
  NotFoundException() : super(404, "The requested resource not found.");
}

class LoginFailedException extends BaseException {
  LoginFailedException()
      : super(401, "You have entered an invalid phone or password");
}

class TokenExpiredException extends BaseException {
  TokenExpiredException() : super(401, "Token is expired");
}

class CustomTimeoutException extends BaseException {
  CustomTimeoutException() : super(null, "Operation timed out.");
}

class ExternalServicesFailException extends BaseException {
  ExternalServicesFailException()
      : super(421, "Cannot be done because of external service failure.");
}

class ParseErrorException extends BaseException {
  String error;

  ParseErrorException(this.error)
      : super(null, "Server replied with an error.");
}

class ServerErrorException extends BaseException {
  String error;

  ServerErrorException(this.error)
      : super(
          500,
          "Internal server error.",
        );
  @override
  String toString() {
    return "Internal server error.";
  }
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException({this.message = 'Error During Communication'});

  @override
  String toString() {
    return "FetchDataException: $message";
  }
}
