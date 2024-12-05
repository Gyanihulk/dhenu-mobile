import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/data/models/login_response.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';


class AuthRepository extends BaseRepository {
  Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "username": username,
        "password": password,
        "is_mobile": true,
        "device_uuid": "unique1",
        "fcm_token": "fcm_1",
        "device_info": "information",
        "os_type": "android",
        "app_version": "v.1.0.0.1",
        "google_login": false 
      };

      const String fullUrl = ApiConstants.loginEndpoint;

      final response = await requestHttps(
        RequestType.POST,
        fullUrl,
        jsonEncode(requestBody), // Encode the body as JSON
        headers: {
          ApiConstants.kContentType: ApiConstants.kApplictionJson,
          // 'Cookie': 'XSRF-TOKEN=eyJpdiI6IlZFbXJ1...; laravel_session=eyJpdiI6ImRzRm5oU...', // Add the required cookies
        },
      );

      // print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response using LoginResponse
        final loginResponse = loginResponseFromJson(response.body);

        // Check for auth token
        if (loginResponse.data?.authToken == null) {
          throw Exception("Auth token is null or missing");
        }

        // Store the auth token
        await TokenStorageService.storeAuthToken(
            loginResponse.data!.authToken!);

        // Return the UserModel
        return loginResponse.data;
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during login: $error');
      rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    Map<String, String> body = {
      "first_name": name,
      "last_name": name,
      "phone": phone,
      "email": email,
      "password": password,
    };

    Response response = await requestHttps(
        RequestType.POST, ApiConstants.registerEndpoint, body);

    log("response statuscode: ${response.statusCode}");

    if (response.statusCode == 401) {
      throw LoginFailedException();
    }

    defaultHandleResponse(body, response);

    if (response.statusCode == 200) {
      log("register sucess");
      // return UserModel.fromJson(json.decode(response.body));
    }
  }
}
