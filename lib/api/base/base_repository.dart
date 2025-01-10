// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dhenu_dharma/api/exceptions/network_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:path/path.dart';

import '../../utils/constants/api_constants.dart';
import '../exceptions/exceptions.dart';
import 'header_interceptor.dart';
import 'logging_interceptor.dart';
import 'url_query_parameters.dart';

enum RequestType { GET, POST, PUT, DELETE, PATCH }

class BaseRepository {
  late InterceptedClient httpClient;
  BaseRepository() {
    httpClient = InterceptedClient.build(interceptors: [
      HeaderInterceptor(),
      LoggingInterceptor(),
    ], requestTimeout: const Duration(seconds: 30));
  }

Future<http.Response> requestHttps(
  RequestType type,
  String endpoint,
  dynamic request, {
  String baseURL = ApiConstants.baseUrl,
  Map<String, String> queryParameters = const {},
  Map<String, String> headers = const {},
}) async {
  // Construct the full URI
  String uri = baseURL + endpoint + getQueryParameters(queryParameters);
  Uri validUri = Uri.parse(uri);
  http.Response response;

  // Ensure headers include Content-Type: application/json
  Map<String, String> updatedHeaders = {
    ...headers,
    ApiConstants.kContentType: ApiConstants.kApplictionJson,
  };

  // Convert the body to a JSON string if it's a Map or other dynamic object
  String? requestBody = request is String ? request : jsonEncode(request);

  // Generate and print the cURL command for debugging
  printCurlCommand(type, validUri, updatedHeaders, requestBody);

  // Send the HTTP request based on the request type
  try {
    switch (type) {
      case RequestType.GET:
        response = await httpClient.get(validUri, headers: updatedHeaders);
        break;
      case RequestType.POST:
        response =
            await httpClient.post(validUri, headers: updatedHeaders, body: requestBody);
        break;
      case RequestType.PUT:
        response =
            await httpClient.put(validUri, headers: updatedHeaders, body: requestBody);
        break;
      case RequestType.PATCH:
        response =
            await httpClient.patch(validUri, headers: updatedHeaders, body: requestBody);
        break;
      case RequestType.DELETE:
        response = await httpClient.delete(validUri, headers: updatedHeaders);
        break;
    }

    // Handle non-200 responses
    if (response.statusCode != 200) {
      defaultHandleResponse(requestBody, response);
    }
    return response;
  } catch (e) {
    // Catch network or other exceptions
    print("Error during HTTP request: $e");
    rethrow;
  }
}


  void printCurlCommand(
      RequestType type, Uri uri, Map<String, String> headers, dynamic body) {
    StringBuffer curlCmd =
        StringBuffer("curl -X ${type.toString().split('.').last}");

    // Add headers
    headers.forEach((key, value) {
      curlCmd.write(' -H "$key: $value"');
    });

    // Add body if applicable
    if (body != null &&
        (type == RequestType.POST ||
            type == RequestType.PUT ||
            type == RequestType.PATCH)) {
      if (body is String) {
        curlCmd.write(" --data-raw '${body}'");
      } else {
        curlCmd.write(" --data-raw '${jsonEncode(body)}'");
      }
    }

    // Add the URL
    curlCmd.write(" '${uri.toString()}'");

    // Print the cURL command
    print("Generated cURL Command:\n$curlCmd");
  }

  Future<http.Response> sendFile(
      String baseURL,
      String method,
      Map<String, String> queryParameters,
      Map<String, String> headers,
      File file) async {
    try {
      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      String uri = baseURL + method + getQueryParameters(queryParameters);
      Uri validUri = Uri.parse(uri);
      var request = http.MultipartRequest("POST", validUri);
      var multipartFileSign = http.MultipartFile('photo', stream, length,
          filename: basename(file.path));
      request.files.add(multipartFileSign);
      request.headers.addAll(headers);
      return await http.Response.fromStream(await request.send());
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw CustomTimeoutException();
    }
  }

  void printCurlCommand2({
    required String url,
    required String method,
    required Map<String, String> headers,
    required Map<String, dynamic>? body,
  }) {
    final buffer = StringBuffer("curl -X $method");

    // Add headers
    headers.forEach((key, value) {
      buffer.write(" -H \"$key: $value\"");
    });

    // Add body if present
    if (body != null && body.isNotEmpty) {
      buffer.write(" --data-raw '${jsonEncode(body)}'");
    }

    // Add URL
    buffer.write(" '$url'");

    // Print the cURL command
    print("Generated cURL Command:\n$buffer");
  }

  defaultHandleResponse(dynamic request, http.Response response) {
      print("Response Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");
    if (response.statusCode >= 500) {
      throw ServerErrorException(response.body.toString());
    }
    switch (response.statusCode) {
      case 400:
        throw MissRequestParamsException(
            getRequestJson(request), getResponseJson(response));
      case 404:
        throw NotFoundException();
      case 421:
        throw ExternalServicesFailException();
      case 401:
        throw LoginFailedException();
      case 403:
        throw TokenExpiredException();
    }
  }

  String getRequestJson(dynamic request) {
    return request != null ? json.encode(request) : "Empty";
  }

  String getResponseJson(http.Response response) {
    return response.body.toString();
  }

  String getQueryParameters(Map<String, String> queryParameters) {
    if (queryParameters != null && queryParameters.isNotEmpty) {
      URLQueryParams queryParams = URLQueryParams();
      queryParameters.forEach((key, value) {
        queryParams.append(key, value);
      });
      return "?${queryParams.toString()}";
    }
    return "";
  }
}
