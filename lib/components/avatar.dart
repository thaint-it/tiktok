import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.size, this.url});
  final double size;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: url != null ? AssetImage(url!) : null
    );
  }
}
