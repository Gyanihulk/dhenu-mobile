import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildLanguagesContent(context),
          ScreenLabelComponent(
            label: "Languages",
            icon: Icons.language,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildLanguagesContent(BuildContext context) {
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
              "Select Language",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff3d3d3d),
            ),
            buildLanguageList(),
            const Spacer(),
            CustomButton(text: "Done", onPressed: () {}),
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }

  Column buildLanguageList() {
    return Column(
      children: [
        SizedBox(height: 10.h),
        buildLanguage(name: "English", engLabel: "", isActive: true),
        buildLanguage(name: "Hindi", engLabel: "(Hindi)", isActive: false),
        buildLanguage(name: "Gujrati", engLabel: "(Gujrati)", isActive: false),
        buildLanguage(name: "Marathi", engLabel: "(Marathi)", isActive: false),
        buildLanguage(name: "Punjabi", engLabel: "(Punjabi)", isActive: false),
      ],
    );
  }

  ListTile buildLanguage({
    required String name,
    required String engLabel,
    required bool isActive,
  }) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        title: Row(
          children: [
            CustomText(
              name,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 4.w),
            CustomText(
              engLabel,
              fontSize: 16,
            ),
          ],
        ),
        trailing: isActive
            ? CircleAvatar(
                radius: 10.h,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 14.h,
                ),
              )
            : null);
  }
}
