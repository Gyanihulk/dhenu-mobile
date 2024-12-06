import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';

class InputWithConfirmation extends StatelessWidget {
  final Widget child; // Custom input field or widget
  final VoidCallback onConfirm; // Confirm button action
  final String? errorMessage; // Optional error message
  final String? confirmTooltip; // Tooltip for confirm button

  const InputWithConfirmation({
    Key? key,
    required this.child,
    required this.onConfirm,
    this.errorMessage,
    this.confirmTooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: child), // Custom input field or widget
            IconButton(
              onPressed: onConfirm, // Trigger confirm action
              icon: Icon(Icons.check_circle, color: AppColors.success),
              tooltip: confirmTooltip ?? "Confirm",
            ),
          ],
        ),
        if (errorMessage != null) // Show error message if provided
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              errorMessage!,
              style: TextStyle(fontSize: 12.sp, color: AppColors.danger),
            ),
          ),
      ],
    );
  }
}
