import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';

class HomeRepository extends BaseRepository {
  Future<Map<String, dynamic>> fetchHomeData({
    required String token,
  }) async {
    try {
      // Call the custom HTTP function from BaseRepository
      final response = await requestHttps(
        RequestType.GET,
        ApiConstants.metricsEndpoint, // Add this endpoint to ApiConstants
        null, // No body required for GET requests
        headers: {
          ApiConstants.kAuthorization: 'Bearer $token', // Add the auth token
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the response body as a Map
        final responseData = jsonDecode(response.body);

        if (responseData['data'] != null && responseData['data'] is Map) {
          return Map<String, dynamic>.from(responseData['data']);
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to fetch home data: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in fetchHomeData: $error');
      throw FetchDataException(message: error.toString());
    }
  }
}
