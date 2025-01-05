import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
class HelpAndFeedbackRepository extends BaseRepository {
  // Fetch FAQs
  Future<List<dynamic>> fetchFAQs({required String token}) async {
    try {
      final response = await requestHttps(
        RequestType.GET,
        ApiConstants.faqsEndpoint, // Add this endpoint to ApiConstants
        null,
        headers: {
          ApiConstants.kAuthorization: 'Bearer $token',
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] != null && responseData['data'] is List) {
          return List<dynamic>.from(responseData['data']);
        } else {
          throw Exception('Unexpected response format: ${response.body}');
        }
      } else {
        throw Exception(
            'Failed to fetch FAQs: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in fetchFAQs: $error');
      throw FetchDataException(message: error.toString());
    }
  }

  // Submit feedback
Future<void> submitFeedback({
    required String token,
    required int starCount,
    required String note,
  }) async {
  
final Uri url =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.feedbacksEndpoint}');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'star_counts': starCount,
          'note': note,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to submit feedback: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in submitFeedback: $error');
      throw FetchDataException(message: error.toString());
    }
  }
}
