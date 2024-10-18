import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/models/activities/activities.dart';
import 'package:tiktok_clone/utils/utils.dart';

class NoticationService {
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotificationWithAttachment(
      Activity activity) async {
    final filePath = Utils.resolveUrl(Endpoints.baseURL, activity.post!.thumbnail!);

    Uri uri = Uri.parse(filePath);
    final fielName = uri.pathSegments.last;

    final String bigPicturePath =
        await _downloadAndSaveFile(filePath, fielName);

    final DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      attachments: <DarwinNotificationAttachment>[
        DarwinNotificationAttachment(
          bigPicturePath,
          hideThumbnail: false,
        )
      ],
    );
    final NotificationDetails notificationDetails = NotificationDetails(
        iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id, 'TIKTOK', Utils.getActivityMessage(activity), notificationDetails, payload: activity.post!.id!.toString());
  }
}
