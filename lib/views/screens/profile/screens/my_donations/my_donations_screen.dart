import 'package:dhenu_dharma/views/screens/profile/screens/my_donations/upcoming_donation_detail_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';
import 'past_donation_detail_screen.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildMyDonationsContent(context),
          ScreenLabelComponent(
            label: "My Donations",
            icon: FontAwesomeIcons.wallet,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        pageIndex: 2,
      ),
    );
  }

  Positioned buildMyDonationsContent(BuildContext context) {
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
              buildUpcomingDonations(),
              buildPastDonations(),
              buildLifetimeDonations(),
            ],
          ),
        ),
      ),
    );
  }

  buildLifetimeDonations() {
    return Padding(
      padding: EdgeInsets.only(top: 28.h, bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Lifetime Donations",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff3d3d3d),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Total Donation:",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "₹ 15,000",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2a2a2a),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "No. of Donations:",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "34",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2a2a2a),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "Impact Highlights:",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "164 Cows",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2a2a2a),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Column(
                    children: [
                      CustomText(
                        "Thank You!",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2a2a2a),
                      ),
                      CustomText(
                        "For your generous donation",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        "It has significantly improved the lives and welfare of numerous cows under our care.",
                        color: Color(0xff6a6a6a),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildUpcomingDonations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Upcoming Donations",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xff3d3d3d),
        ),
        SizedBox(height: 8.h),
        buildDonationCard(),
        SizedBox(height: 12.h),
        buildDonationCard(),
        SizedBox(height: 28.h),
      ],
    );
  }

  Column buildPastDonations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              "Past Donations",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff3d3d3d),
            ),
            Wrap(
              children: [
                CustomText(
                  "Sort by",
                  color: Color(0xff3d3d3d),
                  fontWeight: FontWeight.w600,
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            )
          ],
        ),
        SizedBox(height: 8.h),
        buildDonationCard(isPast: true),
        SizedBox(height: 12.h),
        buildDonationCard(isPast: true),
      ],
    );
  }

  GestureDetector buildDonationCard({bool isPast = false}) {
    return GestureDetector(
      onTap: () {
        CustomNavigator(
          context: context,
          screen: isPast
              ? const PastDonationDetailScreen()
              : const UpcomingDonationDetailScreen(),
        ).push();
      },
      child: Container(
        width: double.infinity,
        height: 90.h,
        decoration: BoxDecoration(
            color: isPast ? Colors.white : AppColors.primary,
            borderRadius: BorderRadius.circular(8),
            border: isPast ? Border.all() : null),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Kanha Aashray Gaushala",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2a2a2a),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Wrap(
                        direction: Axis.vertical,
                        children: [
                          CustomText(
                            "Donor: Aakash Singh",
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            "₹ 2,000",
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      const Wrap(
                        direction: Axis.vertical,
                        children: [
                          CustomText(
                            "10 March, 2024",
                            color: Color(0xff6f6f6f),
                          ),
                          CustomText(
                            "2:00 pm",
                            color: Color(0xff6f6f6f),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.h),
                    bottomLeft: Radius.circular(44.h),
                    topRight: const Radius.circular(8),
                    bottomRight: const Radius.circular(8),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(AssetsConstants.onboardingImg1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
