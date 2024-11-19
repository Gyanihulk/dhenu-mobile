import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../widgets/custom_text.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class HelpAndFeedbackScreen extends StatefulWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  State<HelpAndFeedbackScreen> createState() => _HelpAndFeedbackScreenState();
}

class _HelpAndFeedbackScreenState extends State<HelpAndFeedbackScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildHelpFeedbackContent(context),
          ScreenLabelComponent(
              label: "Help & Feedback", icon: Icons.help_outline)
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildHelpFeedbackContent(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearch(),
              buildTopQuestion(),
              buildFeedback(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "How can we help you today?",
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0XFF3D3D3D),
        ),
        SizedBox(height: 4.h),
        CustomInputField(
          hint: "",
          controller: searchController,
          prefixIcon: FontAwesomeIcons.magnifyingGlass,
          prefixIconColor: const Color(0XFFAAAAAA),
        ),
      ],
    );
  }

  Padding buildTopQuestion() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Top Questions",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0XFF3D3D3D),
          ),
          SizedBox(height: 4.h),
          buildTopQuestionCardList(),
        ],
      ),
    );
  }

  Column buildFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Feedback",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0XFF3D3D3D),
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "We appreciate your feedback",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0XFF3D3D3D),
        ),
        SizedBox(height: 4.h),
        const CustomText(
          "We are always looking for ways to improve your experience. Please take a moment to evaluate and tell us what you think.",
          fontSize: 14,
          color: Color(0XFF393939),
        ),
        SizedBox(height: 16.h),
        const Row(
          children: [
            Icon(Icons.star_outline_rounded, size: 34),
            Icon(Icons.star_outline_rounded, size: 34),
            Icon(Icons.star_outline_rounded, size: 34),
            Icon(Icons.star_outline_rounded, size: 34),
            Icon(Icons.star_outline_rounded, size: 34),
          ],
        ),
        SizedBox(height: 4.h),
        CustomInputField(
          hint: "What we can do to improve your experience?",
          controller: feedbackController,
          maxLines: 4,
        ),
        SizedBox(height: 8.h),
        CustomButton(borderRadius: 8, text: "Submit", onPressed: () {}),
        SizedBox(height: 20.h)
      ],
    );
  }

  buildTopQuestionCardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildTopQuestionCard(
              question:
                  "Are there volunteer opportunities available through this app?",
              answer:
                  "Yes, the app provides listings of volunteer opportunities at cow sanctuaries, farms, and NGOs focused on animal welfare."),
          buildTopQuestionCard(
              question:
                  "How does the app vet the products and services listed?",
              answer:
                  "They are vetted through a strict criteria assessing ethical sourcing, environmental impact, and the welfare standards of the farms involved."),
        ],
      ),
    );
  }

  Container buildTopQuestionCard(
      {required String question, required String answer}) {
    return Container(
      width: 276.w,
      height: 130.h,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0XFF353535),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          CustomText(
            question,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          CustomText(
            answer,
            color: const Color(0xFFC0C0C0),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
