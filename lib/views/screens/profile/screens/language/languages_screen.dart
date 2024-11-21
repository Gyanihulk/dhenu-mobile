import 'package:dhenu_dharma/utils/providers/locale_provider.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildLanguagesContent(context),
          ScreenLabelComponent(
            label: "Languages",
            icon: Icons.language,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Widget buildLanguagesContent(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              "Select Language",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff3d3d3d),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildLanguageOption(context, const Locale('en', ''), 'English'),
                  buildLanguageOption(context, const Locale('hi', ''), 'हिंदी'),
                ],
              ),
            ),
            
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }

  Widget buildLanguageOption(BuildContext context, Locale locale, String language) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return ListTile(
          title: Text(language, style: TextStyle(fontSize: 18.h)),
          trailing: localeProvider.locale == locale
              ? Icon(Icons.check_circle, color: Colors.green)
              : null,
          onTap: () {
            localeProvider.setLocale(locale);
          },
        );
      },
    );
  }

}
