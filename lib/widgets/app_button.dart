import 'package:ems_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        color: _getButtonColor(context),
        shape: _getButtonShape(),
        elevation: 0,
        highlightElevation: 0,
        disabledColor: Colors.grey[300],
        child: Text(text, style: _getTextStyle()),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return Theme.of(context).primaryColor;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  ShapeBorder _getButtonShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color:
          type == ButtonType.primary ? AppColors.secondary : AppColors.primary,
    );
  }
}
