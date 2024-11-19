import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildDocumentsContent(context),
          ScreenLabelComponent(
            label: "Documents",
            icon: Icons.insert_drive_file_outlined,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildDocumentsContent(BuildContext context) {
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
              "My Documents",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xff3d3d3d),
            ),
            SizedBox(height: 12.h),
            Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              children: [
                buildDocument(title: "PAN", img: AssetsConstants.docImg),
                buildDocument(
                    title: "Aadhaar", img: AssetsConstants.aadhaarImg),
                buildDocument(
                    title: "Onboarding", img: AssetsConstants.logoImg2),
                buildDocument(
                    title: "80G Certificate", img: AssetsConstants.docImg),
                buildDocument(
                    title: "Donation Certificate",
                    img: AssetsConstants.logoImg2),
              ],
            )
          ],
        ),
      ),
    );
  }

  Wrap buildDocument({required String title, required String img}) {
    return Wrap(
      children: [
        Container(
          width: 152.w,
          height: 110.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xff272727),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Center(
                  child: Image.asset(
                img,
                height: 32.h,
              )),
              const Spacer(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0)
                    .copyWith(bottom: 12, top: 4),
                child: CustomText(
                  title,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
