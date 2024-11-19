import 'dart:developer';

import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../widgets/custom_text.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildShareContent(context),
          ScreenLabelComponent(label: "Share", icon: Icons.share)
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildShareContent(BuildContext context) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 44.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              "Share with friends",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0XFF3D3D3D),
            ),
            SizedBox(height: 4.h),
            const CustomText(
              "Share our app with friends and family to amplify our collective impcat for a great cause",
              fontSize: 14,
              color: Color(0XFF393939),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
              child: Image.asset(AssetsConstants.shareImg),
            ),
            const CustomText(
              "Together, we can extend our reach and make a meaningful difference in the lives we aim to support.",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0XFF393939),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              text: "Share",
              onPressed: () {
                shareApp();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> shareApp() async {
    try {
      await Share.share('https://www.dhenudharmafoundation.org/');
    } catch (e) {
      log("Error share app: $e");
    }
  }
}
