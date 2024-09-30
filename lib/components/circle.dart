import 'package:flutter/material.dart';

class Cirlce extends StatelessWidget {
  const Cirlce({super.key, this.size = 100, this.color});
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Diameter of the circle
      height: size, // Diameter of the circle
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color?? Colors.lightGreenAccent.shade400, // Circle color
      ),
    );
  }
}
