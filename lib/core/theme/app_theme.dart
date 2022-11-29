import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData build() {
    return ThemeData(
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.materialPrimary,
      toggleableActiveColor: AppColors.primary,
      indicatorColor: AppColors.accent,
      fontFamily: "Poppins",
      brightness: Brightness.light,
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          statusBarColor: AppColors.primary,
        ),
      ),
    );
  }
  
  static TextTheme textTheme() {
    return const TextTheme(
      headline1: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      // Navbar
      headline2: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),
      // Banner
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      // Normal
      headline4: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
      headline5: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      bodyText1: TextStyle(fontSize: 14),
      bodyText2: TextStyle(fontSize: 12),
    );
  }
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}