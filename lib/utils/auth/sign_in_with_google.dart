import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:flutter/services.dart'; 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
Future<User?> signInWithGoogle() async {
  try {
     final GoogleSignIn googleSignIn = GoogleSignIn();
    // Trigger the Google sign-in flow
     await googleSignIn.disconnect();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }

    // Obtain the Google authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential for Firebase
    final credential = GoogleAuthProvider.credential(
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
