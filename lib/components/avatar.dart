import 'package:flutter/material.dart';
import 'package:tiktok_clone/api/enpoints.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.size,
      this.url,
      this.name = "",
      this.isNetwork});
  final double size;
  final String? url;
  final String? name;
  final bool? isNetwork;
  @override
  Widget build(BuildContext context) {
    String resolveUrl(baseUrl, url) {
      final baseURL = Uri.parse(baseUrl);
      return baseURL.resolve(url).toString();
    }

    return Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
        width: size * 2,
        height: size * 2,
        child: Center(
          child: url != null
              ? ClipOval(
                  child: isNetwork == true
                      ? Image.network(resolveUrl(Endpoints.baseURL, url))
                      : Image.asset(
                          url ?? "assets/icons/user.svg",
                          width: size * 2,
                          height: size * 2,
                          fit: BoxFit.cover,
                        ),
                )
              : Text(
                  name!.isNotEmpty ? name![0].toUpperCase() : "",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: size),
                ),
        ));
  }
}
