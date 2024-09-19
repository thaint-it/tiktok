import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/models/auth/user.dart';

class StorageService {
  // ValueNotifier to listen for token changes
  ValueNotifier<String?> authTokenNotifier = ValueNotifier<String?>(null);

  ValueNotifier<String?> rfTokenNotifier = ValueNotifier<String?>(null);
  ValueNotifier<String?> userTokenNotifier = ValueNotifier<String?>(null);

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    authTokenNotifier.value = token;
  }

  Future<void> setRFToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rf_token', token);
    rfTokenNotifier.value = token;
  }

  Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = jsonEncode(user.toJson());
    await prefs.setString('user', userStr);
    userTokenNotifier.value = userStr;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    rfTokenNotifier.value = token;
    return token;
  }

  Future<String?> getRFToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('rf_token');
    authTokenNotifier.value = token;
    return token;
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Get the user JSON string
    String? userJson = prefs.getString('user');
    if (userJson == null) {
      return null; // Return null if there's no user data stored
    }
    userTokenNotifier.value = userJson;
    // Parse the JSON and return the UserModel
    Map<String, dynamic> userMap = jsonDecode(userJson);

    final user = User.fromJson(userMap);
    print("userdecode ${user.userId}");
    return user;
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will clear all data in SharedPreferences
  }
}
