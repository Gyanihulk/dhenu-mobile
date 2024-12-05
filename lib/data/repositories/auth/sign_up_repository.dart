import 'dart:convert';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/base/resource.dart';
import 'package:dhenu_dharma/api/base/base_exception.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';

class SignUpRepository extends BaseRepository {
  Future<Resource<void>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      // Prepare query parameters
      final Map<String, dynamic> requestBody = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "google_login": false, // Include google_login if required by the API
      };

      final String fullUrl = ApiConstants.registerEndpoint;

      final response = await requestHttps(
        RequestType.POST,
        fullUrl,
        jsonEncode(requestBody), // Encode request body as JSON
        baseURL: ApiConstants.baseUrl,
        headers: {
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
          ApiConstants.kContentType:
              ApiConstants.kApplictionJson, // Set Content-Type
        },
      );

      // Log the response status code and body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final authToken =
            responseData['data']['auth_token']; // Adjust based on API response
        return Resource.success(null);
        // Ensure authToken is not null before storing it
        // if (authToken != null) {
        //   // Store the token using TokenStorageService
        //   await TokenStorageService.storeAuthToken(authToken);
        //   return Resource.success(null);
        // } else {
        //   return Resource.error(BaseException(
        //     response.statusCode,
        //     'Auth token not found in the response',
        //   ));
        // }
      } else {
        return Resource.error(BaseException(
          response.statusCode,
          'Registration failed',
          response: response.body,
        ));
      }
    } catch (error) {
      print('Error: $error');
      return Resource.error(BaseException(
        null,
        error.toString(),
      ));
    }
  }

  Future<Resource> verifyOtp({
    required String phoneOrEmail,
    required String otp,
  }) async {
    try {
      final queryParams = {
        'username': phoneOrEmail,
        'code': otp,
      };
      print(queryParams);
      final response = await requestHttps(
        RequestType.POST,
        ApiConstants.verifyOtpEndpoint,
        queryParams, // No request body needed
        baseURL: ApiConstants.baseUrl,
        queryParameters: queryParams,
        headers: {
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
        },
      );

      // Log the response status code and body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final authToken =
            responseData['data']['auth_token']; // Adjust based on API response
        return Resource.success(null);
        // Ensure authToken is not null before storing it
        // if (authToken != null) {
        //   // Store the token using TokenStorageService
        //   await TokenStorageService.storeAuthToken(authToken);
        //   return Resource.success(null);
        // } else {
        //   return Resource.error(BaseException(
        //     response.statusCode,
        //     'Auth token not found in the response',
        //   ));
        // }
      } else {
        return Resource.error(BaseException(
          response.statusCode,
          'Otp Verification failed',
          response: response.body,
        ));
      }
    } catch (error, stackTrace) {
      print('Exception type: ${error.runtimeType}');
      print('Error: $error'); // Calls toString() implicitly
      print('Stack Trace: $stackTrace');
      return Resource.error(null);
    }
  }
}
