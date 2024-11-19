import 'dart:convert';
import '../base/base_exception.dart';

class ServerException extends BaseException {
  ServerException([int? code, String? message])
      : super(code,
            "Server Error : ${json.decode(message!)["message"] ?? message.toString()}");
}
