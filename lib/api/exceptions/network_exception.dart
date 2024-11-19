import '../base/base_exception.dart';

class NetworkException extends BaseException {
  NetworkException()
      : super(null,
            "No internet connection found.\nCheck your connection and try again");
}
