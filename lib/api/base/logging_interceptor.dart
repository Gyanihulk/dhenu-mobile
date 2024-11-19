import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    logRequest(request);
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    logResponse(response);
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }

  void logRequest(BaseRequest request) {
    log("\n----- Request Start -----");
    log("Method: ${request.method}");
    log("URL: ${request.url}");
    log("Headers: ${request.headers}");
    if (request is Request) {
      log("Body: ${request.body}");
    }
    log("----- Request End -----\n\n");
  }

  void logResponse(BaseResponse response) {
    log("\n----- Response Start -----");
    log("Method: ${response.request?.method}");
    log("URL: ${response.request?.url}");
    log("Status Code: ${response.statusCode}");
    log("Headers: ${response.headers}");
    log("Content Length: ${response.contentLength}");
    log("----- Response End -----\n");
  }
}
