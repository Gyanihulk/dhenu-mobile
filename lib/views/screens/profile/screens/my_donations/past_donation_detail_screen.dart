import 'package:dhenu_dharma/views/screens/profile/components/profile_background_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../widgets/custom_text.dart';
import '../../components/screen_label_component.dart';

class PastDonationDetailScreen extends StatelessWidget {
  const PastDonationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildPastDonationDetailContent(context),
          ScreenLabelComponent(
            label: "My Donations",
            icon: FontAwesomeIcons.wallet,
          )
        ],
      ),
    );
  }

  Positioned buildPastDonationDetailContent(BuildContext context) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 44.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomText(
                "Upcoming Donations",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff3d3d3d),
              ),
              buildDonationDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDonationDetail() {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        "Kanha Aashray",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2a2a2a),
                      ),
                      const CustomText(
                        "Gaushala",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2a2a2a),
                      ),
                      SizedBox(height: 4.h),
                      const CustomText(
                        "15 km away",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff595959),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 90.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.h),
                      bottomLeft: Radius.circular(40.h),
                      topRight: Radius.circular(8.h),
                      bottomRight: Radius.circular(30.h),
                    ),
                    image: const DecorationImage(
                      image: AssetImage(AssetsConstants.onboardingImg1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 20.h,
                    child: const Icon(Icons.person),
                  ),
                  title: const CustomText(
                    'ABC Nagar',
                    fontSize: 14,
                  ),
                  subtitle: const CustomText(
                    'xyz colony - 834004',
                    fontSize: 10,
                  ),
                  trailing: Container(
                    width: 112.w,
                    height: 36.h,
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16.h,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        const CustomText(
                          "1234567891",
                          color: Color(0xff595959),
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Donor : Aakash Singh",
                      fontSize: 14.h,
                      fontWeight: FontWeight.w600,
                    ),
                    const CustomText(
                      "Donation Amount:  ₹ 2,000",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 12.h),
                    const CustomText(
                      "Date : 10 March, 2024",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    const CustomText(
                      "Time : 2:00 pm",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Divider(height: 28.h),
                    buildReceipts()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildReceipts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          "Receipts",
          fontSize: 16.h,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 4.h),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Caring Contributor Receipt",
              color: Color(0xff3b3b3b),
            ),
            Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Dhenu Dharma Donation Aknowledgment",
              color: Color(0xff3b3b3b),
            ),
            Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Dhenu Dharma Philonthropy Proof",
              color: Color(0xff3b3b3b),
            ),
            Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
      ],
    );
  }
}
