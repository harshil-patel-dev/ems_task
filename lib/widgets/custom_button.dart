import 'package:ems_task/core/themes/app_colors.dart';
import 'package:ems_task/core/themes/app_styles.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: _getButtonColor(context),
      shape: _getButtonShape(),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: 12,
      ),
      minWidth: 0,
      height: 0,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      child: Text(
        text,
        style: AppStyles.buttonText(
          color:
              type == ButtonType.primary
                  ? AppColors.secondary
                  : AppColors.primary,
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return AppColors.primary;
      case ButtonType.secondary:
        return AppColors.secondary;
    }
  }

  ShapeBorder _getButtonShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
  }
}
