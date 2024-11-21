// ignore_for_file: must_be_immutable

import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_colors.dart';

class ScreenLabelComponent extends StatelessWidget {
  String label;
  IconData icon;

  ScreenLabelComponent({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 134.h,
      left: 24.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.h,
            ),
            SizedBox(width: 6.w),
            CustomText(
              label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
