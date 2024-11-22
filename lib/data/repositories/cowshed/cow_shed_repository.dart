import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';

class CowShedRepository extends BaseRepository {
  Future<Map<String, dynamic>> fetchCowSheds({
    required String token,
    String sortBy = 'name',
    String dir = 'DESC',
    int perPage = 5,
    String search = '',
    String filter = '',
    required double currentLatitude,
    required double currentLongitude,
    int distance = 15,
  }) async {
    try {
      // Create the request body
      final Map<String, dynamic> body = {
        'sort_by': sortBy,
        'dir': dir,
        'per_page': perPage,
        'search': search,
        'filter': filter,
        'currentLatitude': currentLatitude,
        'currentLongitude': currentLongitude,
        'distance': distance,
      };

      // Call the custom HTTP function from BaseRepository
      final response = await requestHttps(
        RequestType.GET,
        ApiConstants.cowShedEndpoint,
        jsonEncode(body), // Encode the body as JSON
        headers: {
          ApiConstants.kAuthorization: 'Bearer $token', // Add the auth token
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
        },
      );

      if (response.statusCode == 200) {
        // Parse and return the response body as a Map
        final responseData = jsonDecode(response.body);
        return responseData["data"];
      } else {
        throw Exception(
            'Failed to fetch cow sheds: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in fetchCowSheds: $error');
      throw FetchDataException(message: error.toString());
    }
  }
}
