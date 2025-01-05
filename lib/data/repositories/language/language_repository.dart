import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class LanguageRepository {
  Future<List<Map<String, dynamic>>> fetchLanguages({
    required String token,
  }) async {
    try {
      // Construct the URL dynamically
      final Uri url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.languageEndpoint}');
      
      // Make the HTTP GET request
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['data'] != null && responseData['data'] is List) {
          return List<Map<String, dynamic>>.from(responseData['data']);
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to fetch languages: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in fetchLanguages: $error');
      throw FetchDataException(message: error.toString());
    }
  }

  Future<Map<String, dynamic>> fetchTranslations({
    required String languageId,
    required String token,
  }) async {
    try {
      // Construct the URL dynamically
      final Uri url = Uri.parse('${ApiConstants.baseUrl}/api/languages/$languageId/translations');

      // Make the HTTP GET request
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to fetch translations: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in fetchTranslations: $error');
      throw FetchDataException(message: error.toString());
    }
  }
}
