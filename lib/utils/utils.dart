import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:tiktok_clone/models/activities/activities.dart';

class Utils {
  // Static method to calculate the square of a number
  static String resolveUrl(baseUrl, url) {
    final baseURL = Uri.parse(baseUrl);
    return baseURL.resolve(url).toString();
  }

  static final List<String> localUrls = [
    "assets/videos/default.mp4",
    "assets/videos/6a253240-a8b3-491e-a830-3399c3279678.MOV",
    "assets/videos/7e1c37e6-8f1f-4499-9303-002b09fbdc69.MOV",
    "assets/videos/0355ec77-98b9-4648-8342-3815b85efece.MOV",
    "assets/videos/b1b337b1-a2eb-46ee-b5ef-5c13530ee9cc.MOV",
    "assets/videos/e87243ec-7372-47b0-bee0-512e503a0768.MOV",
    "assets/videos/ecb9c7df-3b17-4b14-a462-aa65c541d78b.MOV",
   
  ];

  static String getUrl(url) {
    final fileName = path.basename(url);
    // Tìm localUrl có chứa fileName
    final localUrl = localUrls.firstWhere(
      (url) => url.contains(fileName),
      orElse: () => '', // Hoặc một giá trị mặc định khác
    );

    // Kiểm tra và trả về giá trị
    return localUrl.isNotEmpty
        ? localUrl
        : localUrls[0]; // Nếu không tìm thấy, trả về localUrls[0]
  }

  static String calculateTimeDifference(DateTime? createdAt) {
    if (createdAt == null) return '';

    // Get the current time
    final now = DateTime.now();

    // Calculate the difference
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m'; // minutes
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h'; // hours
    } else if (difference.inDays <= 3) {
      return '${difference.inDays}d'; // days
    } else {
      // Format as 'month-day' (e.g., '10-9' for Oct 9)
      return '${createdAt.month}-${createdAt.day}';
    }
  }

  static String getActivityMessage(Activity activity ) {
    switch (activity.action) {
      case "LIKE":
        return "${activity.user!.firstName} liked your video.";
      case "FAVORITE":
        return "${activity.user!.firstName} added your video to Favorites.";
      case "COMMENT":
        return "commented: ${activity.content}";
      case "REPLY_COMMENT":
        return "replied comment: ${activity.content}";
    }
    return "";
  }
}
