import 'dart:convert';
import 'package:dhenu_dharma/data/models/user_model.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/about_us/about_us_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/help_and_feedback/help_and_feedback_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/language/languages_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/legal/legal_screen.dart';
import 'package:dhenu_dharma/views/screens/profile/screens/my_donations/my_donations_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_text.dart';
import 'components/profile_background_component.dart';
import 'screens/contact_us/contact_us_screen.dart';
import 'screens/documents/documents_screen.dart';
import 'screens/share/share_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user; // Fetch user info dynamically
    final localization = AppLocalizations.of(context)!;
    print("user =======");
    print(jsonEncode(user?.toJson()));
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(
            bgImg: AssetsConstants.userProfileBgImg1,
            isBack: false,
          ),
          buildProfileContent(context, user, localization),
          buildProfilePicture(),
        ],
      ),
    );
  }
Positioned buildProfileContent(
    BuildContext context, UserModel? user, AppLocalizations localization) {
  return Positioned(
    top: 150.h,
    left: 0,
    right: 0,
    bottom: 0,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondaryWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(70.w),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // Smooth scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildUserProfile(user, localization),
                  SizedBox(height: 20.h),
                  buildProfileItemList(localization),
                ],
              ),
            ),
          ),
          buildSignOutButton(context, localization),
          SizedBox(height: 16.h), // Bottom spacing for padding
        ],
      ),
    ),
  );
}


  Padding buildSignOutButton(
      BuildContext context, AppLocalizations localization) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: CustomButton(
          text: localization.translate("profile.signOut"),
          onPressed: () {
            CustomNavigator(context: context, screen: const LoginScreen())
                .pushAndRemoveUntil();
          }),
    );
  }

  Positioned buildProfilePicture() {
    return Positioned(
      top: 120.h,
      left: 8.h,
      child: SizedBox(
        height: 50.h,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryBlack,
              width: 2.h,
            ),
          ),
          child: CircleAvatar(
            radius: 40.h,
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.person_rounded,
              size: 36.h,
            ),
          ),
        ),
      ),
    );
  }

Padding buildProfileItemList(AppLocalizations localization) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h)
        .copyWith(top: 20.h),
    child: SingleChildScrollView(
      child: Column(
        children: [
          buildProfileListItem(
            icon: FontAwesomeIcons.wallet,
            label: localization.translate("profile.myDonations"),
            screen: const MyDonationsScreen(),
          ),
          buildProfileListItem(
            icon: Icons.insert_drive_file_outlined,
            label: localization.translate("profile.documents"),
            screen: const DocumentsScreen(),
          ),
          buildProfileListItem(
            icon: Icons.balance,
            label: localization.translate("profile.legal"),
            screen: const LegalScreen(),
          ),
          buildProfileListItem(
            icon: Icons.help,
            label: localization.translate("profile.helpFeedback"),
            screen: const HelpAndFeedbackScreen(),
          ),
          buildProfileListItem(
            icon: FontAwesomeIcons.handHoldingHeart,
            label: localization.translate("profile.aboutUs"),
            screen: const AboutUsScreen(),
          ),
          buildProfileListItem(
            icon: Icons.share,
            label: localization.translate("profile.share"),
            screen: const ShareScreen(),
          ),
          buildProfileListItem(
            icon: Icons.phone,
            label: localization.translate("profile.contactUs"),
            screen: const ContactUsScreen(),
          ),
          buildProfileListItem(
            icon: Icons.language,
            label: localization.translate("profile.languages"),
            screen: const LanguagesScreen(),
          ),
        ],
      ),
    ),
  );
}


  GestureDetector buildProfileListItem(
      {required IconData icon, required String label, required screen}) {
    return GestureDetector(
      onTap: () {
        CustomNavigator(context: context, screen: screen).push();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16.h,
            ),
            SizedBox(width: 20.w),
            CustomText(
              label,
              fontSize: 14.h,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 8.h)
          ],
        ),
      ),
    );
  }

  Padding buildUserProfile(UserModel? user, AppLocalizations localization) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h).copyWith(left: 80.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                user != null
                    ? "${user.firstName ?? ''} ${user.lastName ?? ''}"
                        .trim() // Combine first and last name
                    : localization.translate(
                        "profile.userName"), // Fallback if user is null
                fontSize: 16.h,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.edit,
                size: 16.h,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: CustomText(
              user?.phone ??
                  localization.translate(
                      "profile.phoneNumber"), // Fallback if user.phone is null
              color: AppColors.secondaryGrey,
            ),
          ),
        ],
      ),
    );
  }
}
