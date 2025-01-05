import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/profile/components/profile_background_component.dart';
import 'package:dhenu_dharma/views/screens/profile/components/screen_label_component.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/my_donations/upcoming_donation_detail_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dhenu_dharma/data/models/donation_model.dart';


import 'past_donation_detail_screen.dart';

final List<Donation> donations = [
  Donation(
    name: "Kanha Aashray Gaushala",
    donor: "Aakash Singh",
    amount: "2,000",
    date: "10 March, 2024",
    time: "2:00 pm",
    imagePath: AssetsConstants.onboardingImg1,
    address: "ABC Nagar, Near Temple, City Center",
    contact: "9876543210",
    distance: "15 km",
    isPast: false,
  ),
  Donation(
    name: "Shree Gopal Gaushala",
    donor: "Rohit Sharma",
    amount: "3,500",
    date: "15 March, 2024",
    time: "3:00 pm",
    imagePath: AssetsConstants.onboardingImg2,
    address: "XYZ Colony, Main Road, Downtown",
    contact: "8765432109",
    distance: "25 km",
    isPast: false,
  ),
  Donation(
    name: "Kanha Aashray Gaushala",
    donor: "Vikram Jain",
    amount: "1,000",
    date: "05 March, 2024",
    time: "12:00 pm",
    imagePath: AssetsConstants.onboardingImg1,
    address: "123 Street, Near Park, Suburb",
    contact: "7654321098",
    distance: "20 km",
    isPast: true,
  ),
  Donation(
    name: "Shree Gopal Gaushala",
    donor: "Sonia Verma",
    amount: "5,000",
    date: "02 March, 2024",
    time: "11:00 am",
    imagePath: AssetsConstants.onboardingImg2,
    address: "456 Avenue, Opposite Mall, Uptown",
    contact: "6543210987",
    distance: "18 km",
    isPast: true,
  ),
];


class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildMyDonationsContent(context, localization),
          ScreenLabelComponent(
            label: localization.translate('my_donations_screen.title'),
            icon: FontAwesomeIcons.wallet,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        pageIndex: 2,
      ),
    );
  }

  Positioned buildMyDonationsContent(
      BuildContext context, AppLocalizations localization) {
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
              buildUpcomingDonations(localization),
              buildPastDonations(localization),
              buildLifetimeDonations(localization),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLifetimeDonations(AppLocalizations localization) {
    return Padding(
      padding: EdgeInsets.only(top: 28.h, bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            localization.translate('my_donations_screen.lifetime_donations'),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xff3d3d3d),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      localization
                          .translate('my_donations_screen.total_donation'),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "₹ 15,000",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2a2a2a),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      localization
                          .translate('my_donations_screen.number_of_donations'),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "34",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2a2a2a),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      localization
                          .translate('my_donations_screen.impact_highlights'),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5b5b5b),
                    ),
                    CustomText(
                      "164 Cows",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2a2a2a),
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
                  child: Column(
                    children: [
                      CustomText(
                        localization.translate('my_donations_screen.thank_you'),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff2a2a2a),
                      ),
                      CustomText(
                        localization
                            .translate('my_donations_screen.thank_you_message'),
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        localization
                            .translate('my_donations_screen.impact_message'),
                        color: const Color(0xff6a6a6a),
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

  Widget buildUpcomingDonations(AppLocalizations localization) {
    final upcomingDonations =
        donations.where((donation) => !donation.isPast).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          localization.translate('my_donations_screen.upcoming_donations'),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xff3d3d3d),
        ),
        SizedBox(height: 8.h),
        ...upcomingDonations.map((donation) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: buildDonationCard(context, donation),
            )),
      ],
    );
  }

  Widget buildPastDonations(AppLocalizations localization) {
    final pastDonations =
        donations.where((donation) => donation.isPast).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              localization.translate('my_donations_screen.past_donations'),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff3d3d3d),
            ),
            // Wrap(
            //   children: [
            //     CustomText(
            //       localization.translate('my_donations_screen.sort_by'),
            //       color: const Color(0xff3d3d3d),
            //       fontWeight: FontWeight.w600,
            //     ),
            //     const Icon(Icons.keyboard_arrow_down),
            //   ],
            // )
          ],
        ),
        SizedBox(height: 8.h),
        ...pastDonations.map((donation) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: buildDonationCard(context, donation),
            )),
      ],
    );
  }

  GestureDetector buildDonationCard(BuildContext context, Donation donation) {
    return GestureDetector(
      onTap: () {
        CustomNavigator(
          context: context,
          screen: donation.isPast
              ?  PastDonationDetailScreen(donation: donation)
              :  UpcomingDonationDetailScreen(donation: donation),
        ).push();
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: donation.isPast ? Colors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          border: donation.isPast ? Border.all() : null,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    donation.name,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff2a2a2a),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          CustomText(
                            "${AppLocalizations.of(context)!.translate('my_donations_screen.donor')} ${donation.donor}",
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            "₹ ${donation.amount}",
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          CustomText(
                            donation.date,
                            color: const Color(0xff6f6f6f),
                          ),
                          CustomText(
                            donation.time,
                            color: const Color(0xff6f6f6f),
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
                  image: DecorationImage(
                    image: AssetImage(donation.imagePath),
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
