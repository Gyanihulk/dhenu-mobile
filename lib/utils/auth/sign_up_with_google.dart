import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/service/app_info.dart';
import 'package:dhenu_dharma/service/fmc_service.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:dhenu_dharma/data/models/login_response.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';

Future<UserModel?> signUpWithGoogle(BuildContext context) async {
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
  final appInfo = AppInfo();
    if (user != null) {
      print("[Firebase Auth] Firebase user signed in: ${user.email}");

      // Retrieve ID token
      print("[Firebase Auth] Retrieving Firebase ID token...");
      final String? idToken = await user.getIdToken();
      final String? fcmToken = await FcmService.getToken();

      if (idToken == null) {
        print("[Firebase Auth] Failed to retrieve ID token.");
        throw Exception("Failed to retrieve ID token.");
      }

      // print("[Firebase Auth] ID Token retrieved: $idToken FcmToken :$fcmToken");
      print("FcmToken :$fcmToken");
      print("Version: ${appInfo.version}");
      print("deviceUUID: ${appInfo.deviceUUID}");
      // Prepare request body for backend API
      final Map<String, dynamic> requestBody = {
        "first_name": user.displayName?.split(' ').first ?? "Unknown",
        "last_name": user.displayName?.split(' ').last ?? "Unknown",
        "email": user.email,
        "phone": null,
        "google_secret": "google-secret", // Use the Google idToken as secret
        "google_login": true,
        "is_mobile": true,
        "device_uuid": appInfo.deviceUUID,
        "fcm_token": fcmToken,
         "app_version": appInfo.version,
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
          ApiConstants.kContentType: ApiConstants.kApplictionJson
        },
      );

      // Handle the response
      
      if (response.statusCode == 200) {
        print("User registered in backend: ${response.body}");
ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'SuccessFully Registered. Please log in Now.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
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
        if (response.statusCode == 422) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Email already registered. Please log in instead.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          final Map<String, dynamic> requestBody = {
            "username": user.email,
            "is_mobile": true,
            "device_uuid": appInfo.deviceUUID,
        "fcm_token": fcmToken,
            "device_info": "information",
            "os_type": "android",
            "app_version": appInfo.version,
            "google_secret": idToken,
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
            print("User logged in backend: ${response.body}");
            final loginResponse = loginResponseFromJson(response.body);

            // Check for auth token
            if (loginResponse.data?.authToken == null) {
              throw Exception("Auth token is null or missing");
            }

            // Parse user details from response
            final Map<String, dynamic> responseBody = jsonDecode(response.body);

// Parse user details from response
            final userModel = UserModel.fromJson(responseBody['data']);
            print("Parsed UserModel: $userModel");

            // Store the auth token
            await TokenStorageService.storeAuthToken(userModel.authToken!);

            return userModel;
          }
          return null;
        }
      }
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
