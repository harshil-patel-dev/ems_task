import 'package:ems_task/core/themes/app_colors.dart';
import 'package:ems_task/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool obscureText;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingIconTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? errorText;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.leadingIcon,
    this.trailingIcon,
    this.obscureText = false,
    this.onTap,
    this.onTrailingIconTap,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines = 1,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: AppStyles.hintText(),
        errorText: errorText,
        prefixIcon:
            leadingIcon != null
                ? Icon(leadingIcon, color: AppColors.primary)
                : null,
        suffixIcon:
            trailingIcon != null
                ? IconButton(
                  icon: Icon(trailingIcon, color: AppColors.primary),
                  onPressed: onTrailingIconTap,
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.greyLight),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
