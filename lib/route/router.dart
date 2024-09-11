import 'package:tiktok_clone/route/route_constants.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case tiktokScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PostScreen(),
      );
  }
}
