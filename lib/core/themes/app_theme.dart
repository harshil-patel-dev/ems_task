import 'package:ems_task/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.blue,
        foregroundColor: Colors.white,
        titleTextStyle: AppStyles.title(color: Colors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
