import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int pageCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageCurrentIndex = index;
          setState(() {});
        },
        children: [
          buildOnboarding(
            bgImg: AssetsConstants.onboardingImg1,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentTitle(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Every ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'SEVA\n',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: 'matters',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                buildContentDescription(
                    "Every donation counts and helps us provide care and support to numerous cows in need."),
              ],
            ),
          ),
          buildOnboarding(
            bgImg: AssetsConstants.onboardingImg2,
            content: Column(
              children: [
                buildContentTitle(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'SAVE ',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    TextSpan(
                      text: 'lives and taxes',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                buildContentDescription(
                    "Track your donations in real-time and claim your tax savings easily and instantly.")
              ],
            ),
          ),
          buildOnboarding(
            bgImg: AssetsConstants.onboardingImg3,
            content: Column(
              children: [
                buildContentTitle(
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Connect with ',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'COWS',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                buildContentDescription(
                    "Meet the cows you save through live video calls and witness your kindness come to action.")
              ],
            ),
          )
        ],
      ),
    );
  }

  RichText buildContentTitle({required List<TextSpan> children}) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          fontSize: 32.h,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
        children: children,
      ),
    );
  }

  CustomText buildContentDescription(description) {
    return CustomText(
      description,
      fontSize: 14.h,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );
  }

  Stack buildOnboarding({bgImg, content}) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            bgImg,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h)
              .copyWith(bottom: 48.h),
          child: Column(
            children: [
              buildTop(),
              const Spacer(),
              content,
              SizedBox(height: 28.h),
              buildNextButton(),
              SizedBox(height: 20.h),
              buildIndicator(),
            ],
          ),
        )
      ],
    );
  }

  Row buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AssetsConstants.logoImg, height: 44.h),
        if (pageCurrentIndex != 2)
          GestureDetector(
            onTap: onCompleteOnboarding,
            child: CustomText(
              "SKIP",
              fontSize: 12.h,
              color: const Color(0xFFD6D6D6D1),
              fontWeight: FontWeight.w400,
            ),
          )
      ],
    );
  }

  CustomButton buildNextButton() {
    return CustomButton(
      text: "Next",
      backgroundColor: AppColors.primary,
      textColor: Colors.black,
      width: 120.h,
      onPressed: () {
        if (pageCurrentIndex == 2) {
          onCompleteOnboarding();
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void onCompleteOnboarding() {
    BlocProvider.of<OnboardingBloc>(context)
        .add(OnboardingCompleteEvent(context));
  }

  SmoothPageIndicator buildIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: ExpandingDotsEffect(
        expansionFactor: 8.w,
        dotWidth: 6.w,
        dotHeight: 6.h,
        activeDotColor: AppColors.secondary,
        dotColor: AppColors.secondaryGrey,
      ),
    );
  }
}
