import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:dhenu_dharma/data/models/login_response.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';



import 'package:dhenu_dharma/utils/constants/api_constants.dart';

Future<User?> signUpWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Trigger the Google sign-in flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      print("Google sign-in canceled by the user.");
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

    // Sign in to Firebase with the Google credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("User google data: $userCredential");
    final User? user = userCredential.user;

    if (user != null) {
      // Prepare request body for backend API
      final Map<String, dynamic> requestBody = {
        "first_name": user.displayName?.split(' ').first ?? "Unknown",
        "last_name": user.displayName?.split(' ').last ?? "Unknown",
        "email": user.email,
        "phone": null,
        "google_secret": "google-secret", // Use the Google idToken as secret
        "google_login": true,
      };

      // Call your custom requestHttps function
      final baseRepository = BaseRepository();

      // Call your custom requestHttps function
      final response = await baseRepository.requestHttps(
        RequestType.POST,
        ApiConstants.registerEndpoint,
        jsonEncode(requestBody), // Encode the body as JSON
        baseURL: ApiConstants.baseUrl,
        headers: {
          ApiConstants.kAccept: ApiConstants.kApplictionJson,
          ApiConstants.kContentType:ApiConstants.kApplictionJson
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("User registered in backend: ${response.body}");

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
    if (e is FirebaseAuthException) {
      print("Firebase Auth Exception: ${e.message}");
    } else if (e is PlatformException) {
      print("Platform Exception: ${e.message}");
    } else {
      print('Error during Google sign-up: $e');
    }
    return null;
  }
}
