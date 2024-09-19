import 'package:tiktok_clone/entry_point.dart';
import 'package:tiktok_clone/route/route_constants.dart';
import 'package:tiktok_clone/screens/auth/views/login.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/profile/views/profile.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPointScreen(),
      );
    case postScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
    case loginScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case profileScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
  }
}
