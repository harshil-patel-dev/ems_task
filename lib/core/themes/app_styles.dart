import 'package:ems_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle title({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black,
    );
  }

  static TextStyle subtitle({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black,
    );
  }

  static TextStyle bodyText({Color? color}) {
    return TextStyle(fontSize: 16, color: color ?? Colors.black);
  }

  static TextStyle hintText({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textHint,
    );
  }

  static TextStyle descText({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textHint,
    );
  }

  static TextStyle buttonText({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.white,
    );
  }
}
