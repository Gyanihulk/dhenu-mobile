import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/providers/help_and_feedback.dart';
import 'package:dhenu_dharma/views/screens/profile/components/profile_background_component.dart';
import 'package:dhenu_dharma/views/screens/profile/components/screen_label_component.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_input_field.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class HelpAndFeedbackScreen extends StatefulWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  State<HelpAndFeedbackScreen> createState() => _HelpAndFeedbackScreenState();
}

class _HelpAndFeedbackScreenState extends State<HelpAndFeedbackScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  int selectedStars = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch FAQs after the widget is built
      context.read<HelpAndFeedbackProvider>().fetchFAQs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HelpAndFeedbackProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildHelpFeedbackContent(context, provider),
          ScreenLabelComponent(
            label: "Help & Feedback",
            icon: Icons.help_outline,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildHelpFeedbackContent(
      BuildContext context, HelpAndFeedbackProvider provider) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 30.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearch(),
              SizedBox(height: 16.h),
              buildTopQuestion(provider),
              SizedBox(height: 16.h),
              buildFeedback(provider),
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
        CustomText(
          "How can we help you today?",
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0XFF3D3D3D),
        ),
        SizedBox(height: 8.h),
        CustomInputField(
          hint: "Search",
          controller: searchController,
          prefixIcon: FontAwesomeIcons.magnifyingGlass,
          prefixIconColor: const Color(0XFFAAAAAA),
        ),
      ],
    );
  }

  Padding buildTopQuestion(HelpAndFeedbackProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "Top Questions",
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0XFF3D3D3D),
          ),
          SizedBox(height: 8.h),
          provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : buildTopQuestionCardList(provider.faqs),
        ],
      ),
    );
  }

  Widget buildTopQuestionCardList(List<dynamic> faqs) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: faqs
            .map(
              (faq) => buildTopQuestionCard(
                question: faq['question'] ?? '',
                answer: faq['answer'] ?? '',
              ),
            )
            .toList(),
      ),
    );
  }

  Container buildTopQuestionCard(
      {required String question, required String answer}) {
    return Container(
      width: 280.w,
      height: 200.h,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0XFF353535),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            question,
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          CustomText(
            answer,
            color: const Color(0xFFC0C0C0),
            fontSize: 14.sp,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Column buildFeedback(HelpAndFeedbackProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          "Feedback",
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0XFF3D3D3D),
        ),
        SizedBox(height: 8.h),
        CustomText(
          "We appreciate your feedback",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0XFF3D3D3D),
        ),
        SizedBox(height: 8.h),
        CustomText(
          "We are always looking for ways to improve your experience. Please take a moment to evaluate and tell us what you think.",
          fontSize: 14.sp,
          color: const Color(0XFF393939),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            5,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedStars = index + 1;
                });
              },
              child: Icon(
                index < selectedStars
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 34.w,
                color: index < selectedStars
                    ? Colors.amber
                    : const Color(0XFFAAAAAA),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        CustomInputField(
          hint: "What we can do to improve your experience?",
          controller: feedbackController,
          maxLines: 4,
        ),
        SizedBox(height: 12.h),
        CustomButton(
          borderRadius: 8.r,
          text: "Submit",
          onPressed: () async {
            await provider.submitFeedback(selectedStars, feedbackController.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  provider.errorMessage.isNotEmpty
                      ? provider.errorMessage
                      : "Feedback submitted!",
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
