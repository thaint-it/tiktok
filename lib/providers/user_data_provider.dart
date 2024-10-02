import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';

class UserProvider with ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  void setUser(UserData? newUser) {
    _user = newUser;
    notifyListeners();
  }

  // Method to watch changes
  void watchUserChange(Function(UserData?) callback) {
    // This method will invoke the callback with the new user data whenever setUser is called.
    callback(_user);
    addListener(() {
      callback(_user);
    });
  }
}
