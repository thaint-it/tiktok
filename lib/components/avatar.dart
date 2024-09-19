import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.size, this.url, this.name = ""});
  final double size;
  final String? url;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
        width: size*2,
        height: size*2,
        child: Center(
          child: url != null
              ? ClipOval(
                  child: Image.asset(
                    url ?? "assets/icons/user.svg",
                    width: size*2,
                    height: size*2,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(
                  name!.isNotEmpty ? name![0].toUpperCase() : "",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 72),
                ),
        ));
  }
}
