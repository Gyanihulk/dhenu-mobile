import 'dart:convert';
import 'dart:developer';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/api/exceptions/exceptions.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>> createDonation({
    required String token,
    required int cowShedId,
    required String donationType,
    required double amount,
    required int quantity,
    required String frequency,
    required String name,
    required List<DateTime> period,
  }) async {
    try {
      // Map donationType to constants
      const DOCTOR_SEVA = 'doctor_seva';
      const FOOD_SEVA = 'food_seva';
      const OTHER_SEVA = 'other_seva';

      String mappedDonationType;
      switch (donationType.toLowerCase()) {
        case 'food':
          mappedDonationType = FOOD_SEVA;
          break;
        case 'doctor':
          mappedDonationType = DOCTOR_SEVA;
          break;
        default:
          mappedDonationType = OTHER_SEVA;
      }

      // Format the period dates
      final String formattedPeriod = jsonEncode(
        period.map((date) => date.toIso8601String().split('T')[0]).toList(),
      );

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'cow_sheds_id': cowShedId,
        'donation_type': mappedDonationType,
        'amount': amount,
        'quantity': quantity,
        'frequency': frequency.toLowerCase(),
        'name': name,
        'period': formattedPeriod,
      });

      final Uri url =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.donationEndpoint}');
      logCurlCommand(url, 'POST', headers, body);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final donationResponse = jsonDecode(response.body);

        // Generate payment link
        final paymentLink = await generatePaymentLink(
          token: token,
          donationId: donationResponse['data']['id'],
          amount: amount,
        );

        return {
          'donation': donationResponse,
          'payment_link': paymentLink,
        };
      } else {
        throw Exception(
            'Failed to create donation: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in createDonation: $error');
      throw FetchDataException(message: error.toString());
    }
  }

  Future<String> generatePaymentLink({
    required String token,
    required int donationId,
    required double amount,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'donation_id': donationId,
        'amount': amount,
        'callback_url': 'gyani.dhenudharma://payment-callback',
      };

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final Uri url =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.paymentLinkEndpoint}');
      logCurlCommand(url, 'POST', headers, jsonEncode(body));

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final paymentResponse = jsonDecode(response.body);
        return paymentResponse['payment_link'];
      } else {
        throw Exception(
            'Failed to generate payment link: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      log('Error in generatePaymentLink: $error');
      throw FetchDataException(message: error.toString());
    }
  }

  /// Logs the equivalent curl command for an HTTP request.
  void logCurlCommand(
    Uri url,
    String method,
    Map<String, String> headers,
    String? body,
  ) {
    final curl = StringBuffer();
    curl.write("curl -X $method");

    // Add headers
    headers.forEach((key, value) {
      curl.write(' -H "$key: $value"');
    });

    // Add body
    if (body != null && body.isNotEmpty) {
      curl.write(" -d '${body.replaceAll("'", "\\'")}'");
    }

    // Add URL
    curl.write(" '$url'");
    print(curl.toString());
  }
}
