import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/home/components/profile_background_component.dart';
import 'package:dhenu_dharma/views/screens/home/components/screen_label_component.dart';
import 'package:dhenu_dharma/views/screens/home/misson/component/bold_text_container.dart';
import 'package:dhenu_dharma/views/screens/home/misson/component/image_with_text.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.shareImg),
          _buildMissionContent(context),
          ScreenLabelComponent(
            label: localizations?.translate('main.aboutUs') ?? "About Us",
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
          color: Colors.white,
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                          Text(
                            localizations?.translate('about.intro_description') ??
          "Dhenu Dharma maintains hundreds of shelters for non-productive cows, ensuring their well-being, with proximity-based care. It emphasizes a seamless experience, prioritizing transparency. Donors can easily find nearby shelters and observe the conditions of supported cows via the platform.",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        AssetsConstants
                            .about1, // Replace with your image path
                        width: 140.w,
                        height: 190.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        AssetsConstants
                            .about2, // Replace with your image path
                        width: 140.w,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                          SizedBox(height: 8.h),
                          Text(
                            localizations
            ?.translate('about.virtual_meetings_description') ??
        "A unique aspect of Dhenu Dharma is its innovative approach to donor engagement. Donors have the opportunity to participate in virtual meetings, where they can observe how their contributions directly impact the welfare of the cows. This live interaction fosters a deeper connection between donors and the cause they support.",
                            style: TextStyle(
                              fontSize: 11.sp,
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
                  title: localizations?.translate('about.transparency_title') ??
                      'Transparency',
                  text: localizations
                          ?.translate('about.transparency_description') ??
                      "Donors receive receipts for their donations, ensuring complete clarity on how their contributions are utilized. Also, donations made to Dhenu Dharma are eligible for tax exemption of up to 50% under section 80G of the Income Tax Act, providing added incentives to support the cause.",
                  imagePath: AssetsConstants.about3,
                  isImageLeft: false,
                  textBackgroundColor:
                      Colors.yellow[300], // Light yellow background
                ),
                padding: EdgeInsets.zero, // No padding for this widget
              ),

              _buildWithPadding(
                ImageWithText(
                  title:
                      localizations?.translate('about.topic_title') ?? "Topic",
                  text: localizations?.translate('about.topic_description') ??
                      "To further enhance donor engagement, Dhenu Dharma provides timely reminders and updates on the impact of donations. Through regular communication and content sharing, donors stay informed about the progress of the organization and the welfare of the cows they support.",
                  imagePath: AssetsConstants.about4,
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
                  color: Color(0xFFEAE5D8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localizations?.translate('about.closing_description') ??
                          "Dhenu Dharma is not just an NGO but a platform that facilitates meaningful connections between donors and the cause of cow welfare. With its emphasis on transparency, experience, and tax benefits, Dhenu Dharma empowers individuals to make a positive impact on the lives of sacred cows.",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
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
    final description = localizations?.translate('about.intro_main_title') ??
        "Dhenu Dharma, an NGO initiative, is dedicated to the care and prosperity of sacred cows";

    return BoldTextContainer(
      text: description,
      boldIdentifier: 'sacred',
    );
  }



 

  
}
