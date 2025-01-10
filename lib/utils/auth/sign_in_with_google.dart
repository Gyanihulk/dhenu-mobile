import 'dart:convert';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dhenu_dharma/data/models/login_response.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';


Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Trigger the Google sign-in flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      print("Google sign-Up canceled by the user.");
      return null;
    }

    // Obtain Google authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create Firebase credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print('${UserCredential}');
    final User? user = userCredential.user;

    if (user != null) {
      // Prepare request body for backend API
      final Map<String, dynamic> requestBody = {
        "username": user.email,
        "is_mobile": true,
        "device_uuid": "uniqueandroid",
        "fcm_token": "fcm_1",
        "device_info": "information",
        "os_type": "android",
        "app_version": "v.1.0.0.1",
        "google_secret": "google-secret",
        "google_login": true
      };

      // Call your custom requestHttps function
      final baseRepository = BaseRepository();

      // Call your custom requestHttps function
      final response = await baseRepository.requestHttps(
        RequestType.POST,
        ApiConstants.loginEndpoint,
        jsonEncode(requestBody), // Encode the body as JSON
        baseURL: ApiConstants.baseUrl,
        headers: {
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
          ApiConstants.kContentType: ApiConstants.kApplictionJson
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("User Loged in backend: ${response.body}");
        final loginResponse = loginResponseFromJson(response.body);

        // Check for auth token
        if (loginResponse.data?.authToken == null) {
          throw Exception("Auth token is null or missing");
        }

        // Store the auth token
        await TokenStorageService.storeAuthToken(
            loginResponse.data!.authToken!);
      } else {
        print("Failed to register user in backend: ${response.statusCode}");
        print("Response: ${response.body}");
      }

      return user;
    } else {
      print("Google sign-in failed: No user found.");
      return null;
    }
  } catch (e) {
    print('Error during Google sign-in: $e');
    return null;
  }
}
