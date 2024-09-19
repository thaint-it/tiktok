import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';

class UserProvider with ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  void setUser(UserData? newUser) {
    _user = newUser;
    notifyListeners();
  }
}
