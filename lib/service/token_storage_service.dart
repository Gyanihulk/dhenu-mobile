import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  // Instance of FlutterSecureStorage
  static const _storage = FlutterSecureStorage();

  // Keys for tokens
  static const _authTokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';

  // Store the authentication token
  static Future<void> storeAuthToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  // Retrieve the authentication token
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: _authTokenKey);
  }

  // Store the refresh token (optional)
  static Future<void> storeRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  // Retrieve the refresh token (optional)
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Clear all stored tokens (optional)
  static Future<void> clearTokens() async {
    await _storage.delete(key: _authTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
