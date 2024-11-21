import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/app_assets.dart';
import '../../widgets/custom_navigator.dart';
import '../profile/screens/my_donations/upcoming_donation_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          buildTopContainer(localization),
          buildHomeContent(localization),
        ],
      ),
    );
  }

  Positioned buildHomeContent(AppLocalizations? localization) {
    return Positioned(
      top: 232.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.h),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h)
              .copyWith(bottom: 8.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildActionBoxList(localization),
                buildUpcomingDonations(localization),
                buildRealTimeMetrics(localization),
                buildSupportersSay(localization),
                buildImageGallery(localization),
                buildAboutUs(localization),
                buildWhatWeProvide(localization),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildWhatWeProvide(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
          child:  CustomText(
            localization?.translate("main.provide_title") ?? "What we provide",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xff3d3d3d),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildProvideCard(),
              buildProvideCard(),
              buildProvideCard(),
            ],
          ),
        ),
      ],
    );
  }

  Container buildProvideCard() {
    return Container(
      width: 150.w,
      height: 100.h,
      margin: EdgeInsets.only(right: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.h),
        image: const DecorationImage(
          image: AssetImage(AssetsConstants.galleryImg2),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          color: Colors.black.withOpacity(0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Doctors",
              color: Colors.white,
              fontSize: 12.h,
            ),
            const CustomText(
              "Lorem ipsum dolor sit amet",
              color: Colors.white,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(12.h)),
              child: const CustomText(
                "Read more",
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildAboutUs(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 20.h),
          child:  CustomText(
            localization?.translate("main.about_us_title") ??
                "About Us",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xff3d3d3d),
          ),
        ),
        Image.asset(AssetsConstants.aboutUsImg),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(
              width: 200.w,
              child: CustomText(
                  localization?.translate("main.about_us_description") ?? "Description",
                fontSize: 12.w,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 4.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(55.w),
              child: Image.asset(
                width: 110.w,
                height: 110.w,
                AssetsConstants.galleryImg2,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        SizedBox(height: 20.h),
        Center(
          child: SizedBox(
            width: 120.w,
            child: CustomButton(text:  localization?.translate("main.know_more") ?? "Know More", onPressed: () {}),
          ),
        )
      ],
    );
  }

  Column buildImageGallery(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 6.h),
          child:  CustomText(
            localization?.translate("main.image_gallery") ?? "Image Gallery",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xff3d3d3d),
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: Image.asset(
                    width: 150.w,
                    height: 240.h,
                    AssetsConstants.galleryImg1,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: Image.asset(
                    width: 150.w,
                    height: 100.h,
                    AssetsConstants.galleryImg2,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.h),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: Image.asset(
                    width: 150.w,
                    height: 100.h,
                    AssetsConstants.galleryImg3,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.h),
                  child: Image.asset(
                    width: 150.w,
                    height: 240.h,
                    AssetsConstants.galleryImg4,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.h),
              child: Image.asset(
                width: 170.w,
                height: 100.h,
                AssetsConstants.galleryImg5,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.h),
              child: Image.asset(
                width: 130.w,
                height: 100.h,
                AssetsConstants.galleryImg6,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Center(
            child:
                CustomButton(width: 120.w, text:  localization?.translate("main.view_more") ?? "View More", onPressed: () {}))
      ],
    );
  }

  Column buildSupportersSay(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 6.h),
          child:  CustomText(
            localization?.translate("main.supporters_say_title") ?? "What our supporters say",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xff3d3d3d),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildSupporter(),
              buildSupporter(),
              buildSupporter(),
              buildSupporter(),
            ],
          ),
        )
      ],
    );
  }

  Container buildSupporter() {
    return Container(
      width: 150.w,
      height: 128.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.h),
        image: const DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1541872705-1f73c6400ec9?q=80&w=3032&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30.h,
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white.withOpacity(0.8),
              size: 32.h,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: 168.w,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.h),
                  bottomRight: Radius.circular(16.h),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h)
                          .copyWith(left: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            "Sitaraman Bhosale",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w,
                          ),
                          const CustomText(
                            "Animal Activist",
                            color: Colors.white,
                          ),
                          CustomText(
                            "Our Green Guardians",
                            color: Colors.white,
                            fontSize: 12.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildRealTimeMetrics(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
         CustomText(
          localization?.translate("main.real_time_metrics_title") ?? "Real Time Metrics",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: const Color(0xff3d3d3d),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              buildMetric(title: "₹ 11 cr", subtitle: localization?.translate("main.total_donation") ?? "Total Donation"),
              buildMetric(title: "300", subtitle: localization?.translate("main.total_gowshala") ?? "Total Gowshala"),
              buildMetric(title: "45,000", subtitle: localization?.translate("main.cows_helped") ?? "Cows Helped"),
              buildMetric(title: "7000", subtitle: localization?.translate("main.people_connected") ?? "People Connected"),
            ],
          ),
        )
      ],
    );
  }

  Container buildMetric({required String title, required String subtitle}) {
    return Container(
      width: 150.w,
      height: 90.h,
      decoration: BoxDecoration(
          color: const Color(0xff2d2d2d),
          borderRadius: BorderRadius.circular(8.h)),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            CustomText(
              title,
              fontSize: 20.h,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            SizedBox(height: 8.h),
            CustomText(
              subtitle,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Column buildUpcomingDonations(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        CustomText(
          localization?.translate("main.upcoming_donations_title") ??
              "Upcoming donations",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: const Color(0xff3d3d3d),
        ),
        SizedBox(height: 8.h),
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            return buildDonationCard();
          },
          options: CarouselOptions(
            height: 100,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 12.h),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? const Color(0xff353535)
                : const Color(0xffd9d9d9),
          ),
        );
      }),
    );
  }

  GestureDetector buildDonationCard() {
    return GestureDetector(
      onTap: () {
        CustomNavigator(
          context: context,
          screen: const UpcomingDonationDetailScreen(),
        ).push();
      },
      child: Container(
        width: double.infinity,
        height: 90.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
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

  Row buildActionBoxList(AppLocalizations? localization) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildActionBox(
          title: localization?.translate("main.mission") ?? "Mission",
          img: AssetsConstants.missionImg,
        ),
        buildActionBox(
          title: localization?.translate("main.donate") ?? "Donate",
          img: AssetsConstants.donateImg,
        ),
        buildActionBox(
          title: localization?.translate("main.authentication") ??
              "Authentication",
          img: AssetsConstants.authenticationImg,
        ),
        buildActionBox(
          title: localization?.translate("main.receipts") ?? "Receipts",
          img: AssetsConstants.receiptsImg,
        ),
      ],
    );
  }

  Wrap buildActionBox({required String title, required String img}) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          img,
          width: 60.h,
        ),
        CustomText(
          title,
          color: const Color(0xff3d3d3d),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Positioned buildTopContainer(AppLocalizations? localization) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 260.h,
        color: const Color(0xff232122),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.h).copyWith(top: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AssetsConstants.logoImg,
                  height: 50.h,
                ),
                SizedBox(height: 14.h),
                Wrap(
                  children: [
                    buildSearch(),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFF353535),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            '“',
                            color: AppColors.primary,
                            fontSize: 24.h,
                          ),
                          SizedBox(width: 2.w),
                          CustomText(
                            'गोरक्षा धर्मस्य मूलं',
                            color: Colors.white,
                            fontSize: 24.h,
                          ),
                          SizedBox(width: 2.w),
                          CustomText(
                            '”',
                            color: AppColors.primary,
                            fontSize: 24.h,
                          ),
                        ],
                      ),
                      const CustomText(
                        'The value of our duty is protecting cows',
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSearch() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .75,
      height: 38.h,
      child: TextField(
        controller: searchController,
        style: GoogleFonts.inter(
            fontSize: 16, color: Colors.white, decoration: TextDecoration.none),
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 16.h,
            color: const Color(0XFFAAAAAA),
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: const Color(0XFFCCCCCC),
            fontSize: 14.sp,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          filled: true,
          fillColor: const Color(0XFF353535),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: const BorderSide(
              color: Color(0XFFCCCCCC),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
