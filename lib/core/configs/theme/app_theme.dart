import 'package:flutter/material.dart';
import 'package:newzen/core/configs/theme/app_color.dart';

class AppTheme {
  static final lighttheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(15))),
    ),
  );
}
