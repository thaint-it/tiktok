import 'package:tiktok_clone/route/route_constants.dart';
import 'package:tiktok_clone/screens/auth/views/login.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case postScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
     case loginScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
  }
}
