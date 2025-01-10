import 'dart:convert';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/base/resource.dart';
import 'package:dhenu_dharma/api/base/base_exception.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';

class ForgetPasswordRepository extends BaseRepository {
  
  // Method to send OTP
  Future<Resource> sendOtp({
    required String phoneOrEmail,
  }) async {
    try {
      final queryParams = {
        'username': phoneOrEmail,
      };

      print('Sending OTP to: $phoneOrEmail');

      final response = await requestHttps(
        RequestType.POST,
        ApiConstants.sendOtpEndpoint, // Add this endpoint in your constants
        queryParams,
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
        return Resource.success(jsonDecode(response.body));
      } else {
        return Resource.error(BaseException(
          response.statusCode,
          'Failed to send OTP',
          response: response.body,
        ));
      }
    } catch (error, stackTrace) {
      print('Exception type: ${error.runtimeType}');
      print('Error: $error');
      print('Stack Trace: $stackTrace');
      return Resource.error(null);
    }
  }

  // Method to verify OTP
 Future<Resource> resetPasswordWithOtp({
  required String phoneOrEmail,
  required String otp,
  required String newPassword,
}) async {
  try {
    final requestBody = {
      "username": phoneOrEmail,
      "code": otp,
      "new_password": newPassword,
      "confirm_new_password": newPassword,
    };

    final headers = {
      ApiConstants.kAccept: ApiConstants.kApplictionJson,
      ApiConstants.kContentType: ApiConstants.kApplictionJson,
    };

    print('Resetting password for: $phoneOrEmail with OTP: $otp');

    final response = await requestHttps(
      RequestType.POST,
      ApiConstants.resetPasswordEndpoint,
      jsonEncode(requestBody),
      baseURL: ApiConstants.baseUrl,
      headers: headers,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return Resource.success(jsonDecode(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'] ?? 'Failed to reset password';
      return Resource.error(BaseException(
        response.statusCode,
        errorMessage,
        request: jsonEncode(requestBody),
        response: response.body,
      ));
    }
  } catch (error, stackTrace) {
    print('Exception type: ${error.runtimeType}');
    print('Error: $error');
    print('Stack Trace: $stackTrace');
    return Resource.error(BaseException(
      500,
      'An error occurred while resetting the password.',
      request: 'POST ${ApiConstants.resetPasswordEndpoint}',
      response: error.toString(),
    ));
  }
}


}
