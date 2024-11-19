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
      final queryParams = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

      final fullUrl = ApiConstants.baseUrl +
          ApiConstants.registerEndpoint +
          Uri(queryParameters: queryParams).toString();
      print('Register url: ${fullUrl}');
      final response = await requestHttps(
        RequestType.POST,
        ApiConstants.registerEndpoint,
        null, // No request body needed
        baseURL: ApiConstants.baseUrl,
        queryParameters: queryParams,
        headers: {
          ApiConstants.kContentType: ApiConstants.kApplictionJson,
        },
      );

      // Log the response status code and body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Access the auth_token from the data field
        final authToken =
            responseData['data']['auth_token']; // Adjust based on API response

        // Ensure authToken is not null before storing it
        if (authToken != null) {
          // Store the token using TokenStorageService
          await TokenStorageService.storeAuthToken(authToken);
          return Resource.success(null);
        } else {
          return Resource.error(BaseException(
            response.statusCode,
            'Auth token not found in the response',
          ));
        }
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

  
}
