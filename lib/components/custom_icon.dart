import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, this.isLightTheme = false});
  final bool? isLightTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            width: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                250,
                45,
                108,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            width: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                32,
                211,
                234,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: isLightTheme == true ? blackColor : whiteColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.add,
                color: isLightTheme == true ? whiteColor : blackColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
