import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageProvider with ChangeNotifier {
  List<User>? _users;
  int _notifyCount = 0;
  WebSocketChannel? _channel;

  List<User>? get users => _users;
  int get notifyCount => _notifyCount;
  WebSocketChannel? get channel => _channel;

  void setUser(List<User>? newUsers) {
    _users = newUsers;
    notifyListeners();
  }

  void setChannel(WebSocketChannel? channel) {
    _channel = channel;
    notifyListeners();
  }

  void setNotifyCount(int count) {
    _notifyCount = count;
    notifyListeners();
  }

  // Method to update isOnline status
  void updateUserOnlineStatus(int userId, bool isOnline) {
    if (_users != null) {
      // Find the index of the user to update
      int index = _users!.indexWhere((user) => user.id == userId);
      if (index != -1) {
        // Update the user in the list
        _users![index].isOnline = isOnline;
        // Notify listeners about the change
        notifyListeners();
      }
    }
  }
}
