import 'dart:convert';
import 'package:dhenu_dharma/api/base/base_repository.dart';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dhenu_dharma/data/models/login_response.dart';
import 'package:dhenu_dharma/service/token_storage_service.dart';
import 'package:dhenu_dharma/service/fmc_service.dart';
import 'package:flutter/widgets.dart';


Future<UserModel?> signInWithGoogle(BuildContext context) async {
  try {
    print("[Google Sign-In] Starting the sign-in process...");

    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Trigger the Google sign-in flow
    print("[Google Sign-In] Attempting Google sign-in...");
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      print("[Google Sign-In] Sign-in canceled by the user.");
      throw Exception("Google sign-in canceled by the user.");
    }

    print("[Google Sign-In] Google user details: ${googleUser.email}");

    // Obtain Google authentication details
    print("[Google Sign-In] Fetching Google authentication details...");
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    print("[Google Sign-In] GoogleAuth obtained: AccessToken: ${googleAuth.accessToken}, IdToken: ${googleAuth.idToken}");

    // Create Firebase credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print("[Firebase Auth] Signing in with Google credential...");
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print("[Firebase Auth] UserCredential obtained: $userCredential");

    final User? user = userCredential.user;

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
      // Prepare request body for backend API
      final Map<String, dynamic> requestBody = {
        "username": user.email,
        "is_mobile": true,
        "device_uuid": "uniqueandroid",
        "fcm_token": fcmToken,
        "device_info": "information",
        "os_type": "android",
        "app_version": "v.1.0.0.1",
        "google_secret": idToken,
        "google_login": true
      };

      print("[Backend API] Sending login request to backend...");
      final baseRepository = BaseRepository();
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

      print("[Backend API] Response status code: ${response.statusCode}");
      print("[Backend API] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody['status'] == true) {
          print("[Backend API] Login successful.");
          final userModel = UserModel.fromJson(responseBody['data']);
          print("[Backend API] Parsed UserModel: $userModel");

          await TokenStorageService.storeAuthToken(userModel.authToken!);
          print("[Token Storage] Auth token stored successfully.");

          return userModel;
        } else {
          // API-specific error message
          final errorMessage = responseBody['message'] ?? 'Unknown error occurred.';
          print("[Backend API] Login failed: $errorMessage");
          throw Exception(errorMessage);
        }
      } else {
        // HTTP status code errors
        print("[Backend API] HTTP Error: ${response.statusCode}");
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } else {
      print("[Firebase Auth] Google sign-in failed: No user found.");
      throw Exception("Google sign-in failed: No user found.");
    }
  } catch (e) {
    print("[Error] An error occurred during sign-in: $e");
    rethrow; // Propagate the error to the calling function
  }
}
