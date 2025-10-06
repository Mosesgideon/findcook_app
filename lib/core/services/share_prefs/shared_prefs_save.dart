

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/authentication/data/models/AuthSuccessResponse.dart';

class SharedPreferencesClass {
  static const String keyValue = "user";
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  /// Save user data (convert object to JSON string)
  static Future<bool> setUserData(AuthSuccessResponse user) async {
    await init();
    final userJson = jsonEncode(user.toJson());
    return await _preferences!.setString(keyValue, userJson);
  }

  /// Get user data (convert JSON string back to object)
  static Future<AuthSuccessResponse?> getUserData() async {
    await init();
    final userString = _preferences?.getString(keyValue);
    if (userString == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return AuthSuccessResponse.fromJson(userMap);
  }

  /// Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    await init();
    return _preferences?.containsKey(keyValue) ?? false;
  }

  /// Clear user data (logout)
  static Future<bool> clearUserData() async {
    await init();
    return await _preferences!.remove(keyValue);
  }
}
//
// class SharedPreferencesClass{
// static const keyValue="user";
//   static SharedPreferences _preferences;
//
//   static Future init()async =>
//   _preferences=await SharedPreferences.getInstance();
//
//
//
//   static Future setUserData(String my_user) async =>
//       await _preferences.setString(keyValue, my_user);
//
//
//   static Future getUserData(String my_user)async=>await _preferences.setString(keyValue, my_user);
//
//
// }