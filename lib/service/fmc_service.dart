import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize FCM and retrieve the token
  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("Retrieved FCM Token: $token");
      return token;
    } catch (e) {
      print("Error retrieving FCM token: $e");
      return null;
    }
  }

  // Example: Send the FCM token to the backend
  static Future<void> sendTokenToBackend(String token) async {
    print("Sending FCM token to backend: $token");
    // Add your backend integration logic here
  }
}
