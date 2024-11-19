import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double height;
  final double width;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.black,
    this.textColor = AppColors.primary,
    this.borderRadius = 24.0,
    this.elevation = 2.0,
    this.height = 48.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: CustomText(
          text,
          fontSize: 12.h,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
