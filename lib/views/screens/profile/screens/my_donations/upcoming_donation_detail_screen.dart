import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../widgets/custom_text.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class UpcomingDonationDetailScreen extends StatefulWidget {
  const UpcomingDonationDetailScreen({super.key});

  @override
  State<UpcomingDonationDetailScreen> createState() =>
      _UpcomingDonationDetailScreenState();
}

class _UpcomingDonationDetailScreenState
    extends State<UpcomingDonationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildUpcomingDonationDetailContent(context),
          ScreenLabelComponent(
            label: "My Donations",
            icon: FontAwesomeIcons.wallet,
          )
        ],
      ),
    );
  }

  Positioned buildUpcomingDonationDetailContent(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                "Upcoming Donations",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff3d3d3d),
              ),
              SizedBox(height: 6.h),
              buildDonationDetail()
            ],
          ),
        ),
      ),
    );
  }

  Container buildDonationDetail() {
    return Container(
      width: double.infinity,
      height: 350.h,
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
            height: 294,
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
                    SizedBox(height: 30.h),
                    Center(
                      child: CustomButton(
                          width: 150.w,
                          height: 36.h,
                          text: "Cancel",
                          onPressed: () {
                            buildCancelSure();
                          }),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  buildCancelSure() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: CustomText(
            "Are you sure you want to cancel?",
            fontSize: 16.h,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 98.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(16.h),
                      ),
                      child: const Center(
                        child: CustomText(
                          "Yes",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 98.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16.h),
                      ),
                      child: const Center(
                        child: CustomText(
                          "No",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
