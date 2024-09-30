import 'dart:math';

import 'package:path/path.dart' as path;

class Utils {
  // Static method to calculate the square of a number
  static String resolveUrl(baseUrl, url) {
    final baseURL = Uri.parse(baseUrl);
    return baseURL.resolve(url).toString();
  }

  static final List<String> localUrls = [
    "assets/videos/d5649e78-35a0-4e67-a99f-abd41462755f.mp4",
    "assets/videos/0a4a04aa-7836-456c-8ac0-3b26dbdabcc2.mp4",
    "assets/videos/ecb9c7df-3b17-4b14-a462-aa65c541d78b.MOV",
    "assets/videos/e87243ec-7372-47b0-bee0-512e503a0768.MOV",
    "assets/videos/b1b337b1-a2eb-46ee-b5ef-5c13530ee9cc.MOV",
    "assets/videos/7e1c37e6-8f1f-4499-9303-002b09fbdc69.MOV",
    "assets/videos/6a253240-a8b3-491e-a830-3399c3279678.MOV",
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
}
