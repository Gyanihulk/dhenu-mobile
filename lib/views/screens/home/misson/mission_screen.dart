import 'package:dhenu_dharma/views/screens/home/misson/component/bold_text_container.dart';
import 'package:dhenu_dharma/views/screens/home/misson/component/image_with_text.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/localization/app_localizations.dart';
import '../components/profile_background_component.dart';
import '../components/screen_label_component.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.hugcow),
          _buildMissionContent(context),
          ScreenLabelComponent(
            label: localizations?.translate('main.mission') ?? "Mission",
            icon: FontAwesomeIcons.handHoldingHeart,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  /// Helper function to add dynamic padding
  Widget _buildWithPadding(Widget child, {EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
              horizontal: 24.w), // Default padding if none provided
      child: child,
    );
  }

  Positioned _buildMissionContent(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Positioned(
      top: 250.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.zero.copyWith(top: 44.h),
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
              _buildWithPadding(_buildDescription(context),
                  padding: EdgeInsets.symmetric(horizontal: 16.w)),
              _buildWithPadding(_buildProblemWithImage(context),
                  padding: EdgeInsets.symmetric(horizontal: 16.w)),
              _buildWithPadding(_buildSolution(context),
                  padding: EdgeInsets.symmetric(horizontal: 16.w)),
              _buildWithPadding(
                BoldTextContainer(
                  text: localizations?.translate('mission.impact') ??
                      'Imagine being able to witness the impact of your donation in real-time, receiving timely receipts, and gentle reminders to continue your support.',
                  boldIdentifier: 'real-time',
                ),
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 16.h, bottom: 16.h),
              ),
              _buildWithPadding(
                Center(
                  child: Image.asset(
                    AssetsConstants
                        .mission2, // Replace with the appropriate image asset
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              _buildWithPadding(
                ImageWithText(
                  title:
                      localizations?.translate('mission.mission') ?? 'Mission',
                  text: localizations
                          ?.translate('mission.missionDescription') ??
                      'Imagine being able to witness the impact of your donation in real-time, receiving timely receipts, and gentle reminders to continue your support.',
                  imagePath: AssetsConstants.mission3,
                  isImageLeft: false,
                  textBackgroundColor:
                      Colors.yellow[300], // Light yellow background
                ),
                padding: EdgeInsets.zero, // No padding for this widget
              ),
              Container(
                color: Colors.yellow[100], // Set the background color
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w, // Horizontal padding
                  vertical: 18.h, // Add top and bottom padding
                ),
                child: Center(
                  child: Text(
                    localizations?.translate('mission.impact') ??
                        'Your contributions, no matter how big or small, make a difference in the lives of these vulnerable animals',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D3D3D)), // Make text bold
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        AssetsConstants
                            .mission4, // Replace with your image path
                        width: 120.w,
                        height: 170.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            localizations
                                    ?.translate('mission.howWeWorkTitle') ??
                                "How we work?",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3D3D3D),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            localizations?.translate(
                                    'mission.howWeWorkDescription') ??
                                "Your donation goes towards providing essential care for these cows, ensuring they have access to food, shelter, and medical attention. With Dhenu Dharma, you can rest assured that your contribution is making a tangible impact on the lives of these gentle creatures.",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildWithPadding(
                ImageWithText(
                  title: localizations?.translate('mission.whyTrustUsTitle') ??
                      "Why trust us?",
                  text: localizations
                          ?.translate('mission.whyTrustUsDescription') ??
                      "Dhenu Dharma stands out with its unwavering transparency. With live feeds, witness shelter conditions and cow well-being firsthand. Detailed donation receipts provide peace of mind, ensuring full clarity on where your contributions are utilized.",
                  imagePath: AssetsConstants.mission5,
                  isImageLeft: true,
                  textBackgroundColor:
                      const Color(0xFF3D3D3D), // Background color #3D3D3D
                  fontColor: Colors.white, // Light yellow background
                ),
                padding: EdgeInsets.zero, // No padding for this widget
              ),
              // Second Container

              // Third Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localizations
                          ?.translate('mission.footerText1') ??"Join Dhenu Dharma today, championing a movement to honor and care for our sacred cows.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D3D3D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      localizations
                          ?.translate('mission.footerText2') ??"Together, let's uphold values of compassion and kindness, ensuring they receive the respect they deserve.",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF3D3D3D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final description = localizations?.translate('mission.description') ??
        'In the ancient teachings of Sanatan Dharma, cows hold a position of utmost reverence, often likened to that of a mother.';

    return BoldTextContainer(
      text: description,
      boldIdentifier: 'mother',
    );
  }

  Widget _buildProblemStatement(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Text(
      localizations?.translate('mission.solution') ??
          'Dhenu Dharma introduces a platform to connect caring individuals with shelters...',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _buildProblemWithImage(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final problemText = localizations?.translate('mission.problem') ??
        'Unfortunately, many of these sacred animals face a grim fate once they stop producing milk. They either end up slaughtered or left to wander helplessly. Dhenu Dharma aims to change this narrative.';

    return ImageWithText(
      text: problemText,
      imagePath: AssetsConstants.mission1, // Replace with the correct image URL
      isImageLeft: false, // Set to true if the image should appear on the left
    );
  }

  Widget _buildSolution(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final description = localizations?.translate('mission.solution') ??
        'In the ancient teachings of Sanatan Dharma, cows hold a position of utmost reverence, often likened to that of a mother.';

    // return BoldTextContainer(
    //   text: description,
    //   boldIdentifier: 'transparency',
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        textAlign: TextAlign.left, // Ensure left alignment
      ),
    );
  }
}
