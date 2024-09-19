import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerRight,
      child: IconButton(onPressed: ()=>{
        Navigator.of(context).pop()
      }, icon: Icon(Icons.close, weight: 16, color: blackColor)),
    );
  }
}
