import 'dart:developer';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/profile/components/profile_background_component.dart';
import 'package:dhenu_dharma/views/screens/profile/components/screen_label_component.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context); // Access localization

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildShareContent(context, localization!),
          ScreenLabelComponent(
            label: localization.translate('share.title'),
            icon: Icons.share,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildShareContent(BuildContext context, AppLocalizations localization) {
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
        child: SingleChildScrollView( // Added scrollable content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                localization.translate('share.share_with_friends'),
                fontSize: 18.sp, // Responsive font size
                fontWeight: FontWeight.w500,
                color: const Color(0XFF3D3D3D),
              ),
              SizedBox(height: 4.h),
              CustomText(
                localization.translate('share.description'),
                fontSize: 14.sp, // Responsive font size
                color: const Color(0XFF393939),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
                child: Image.asset(AssetsConstants.shareImg),
              ),
              CustomText(
                localization.translate('share.together_message'),
                fontSize: 16.sp, // Responsive font size
                fontWeight: FontWeight.w500,
                color: const Color(0XFF393939),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: localization.translate('share.button_text'),
                onPressed: () {
                  shareApp(localization);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareApp(AppLocalizations localization) async {
    try {
      await Share.share(localization.translate('share.share_message'));
    } catch (e) {
      log("Error sharing app: $e");
    }
  }
}
