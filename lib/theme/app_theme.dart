// ignore_for_file: unused_import

import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/theme/button_theme.dart';
import 'package:tiktok_clone/theme/input_decoration_theme.dart';
import 'package:tiktok_clone/theme/theme_data.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: "Tiktok",
      // primarySwatch: primaryMaterialColor,
      primaryColor: whiteColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: blackColor),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
      textTheme: const TextTheme(
      
      ),
      // elevatedButtonTheme: elevatedButtonThemeData,
      // textButtonTheme: textButtonThemeData,
      // outlinedButtonTheme: outlinedButtonTheme(),
      // inputDecorationTheme: inputDecorationTheme,
      // checkboxTheme: checkboxThemeData.copyWith(
      //   side: const BorderSide(color: blackColor40),
      // ),
      // appBarTheme: appBarLightTheme,
      // scrollbarTheme: scrollbarThemeData,
      // dataTableTheme: dataTableLightThemeData,
    );
  }
}
