// ignore_for_file: must_be_immutable

import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBackgroundComponent extends StatelessWidget {
  String bgImg;
  bool isBack;

  ProfileBackgroundComponent({
    super.key,
    required this.bgImg,
    this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImg),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      if (isBack)
        Positioned(
          top: 24.h,
          left: 16.h,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              backgroundColor: AppColors.secondaryWhite,
              child: Icon(Icons.arrow_back),
            ),
          ),
        )
    ]);
  }
}
