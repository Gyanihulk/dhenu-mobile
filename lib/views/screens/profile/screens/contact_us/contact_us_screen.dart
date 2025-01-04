import 'package:dhenu_dharma/utils/common/url_launcher_util.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/profile/components/profile_background_component.dart';
import 'package:dhenu_dharma/views/screens/profile/components/screen_label_component.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context); // Access localization

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildProfileContent(context, localization!),
          ScreenLabelComponent(
            label: localization.translate('contact.contact_us'),
            icon: Icons.phone,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildProfileContent(BuildContext context, AppLocalizations localization) {
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
            CustomText(
              localization.translate('contact.get_in_touch'),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF3D3D3D),
            ),
            SizedBox(height: 4.h),
            CustomText(
              localization.translate('contact.contact_us_message'),
              color: const Color(0XFF393939),
              fontSize: 14,
            ),
            buildContactItemList(localization),
            const Spacer(),
            buildSocialItemList(context, localization),
          ],
        ),
      ),
    );
  }

  Column buildSocialItemList(BuildContext context, AppLocalizations localization) {
    return Column(
      children: [
        CustomText(
          localization.translate('contact.follow_us_on'),
          color: const Color(0xFF6A6A6A),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w)
              .copyWith(top: 8.h, bottom: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSocialIcon(
                FontAwesomeIcons.linkedin,
                Colors.blue[700],
                'https://www.linkedin.com/company/dhenu-dharma-foundation/',
                context,
              ),
              buildSocialIcon(
                FontAwesomeIcons.squareInstagram,
                Colors.pink,
                'https://www.instagram.com/dhenudharmafoundation',
                context,
              ),
              buildSocialIcon(
                FontAwesomeIcons.twitter,
                Colors.blue,
                'https://x.com/DhenuDharma',
                context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector buildSocialIcon(
    IconData icon,
    Color? color,
    String url,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () async {
        // Launch the URL when the icon is tapped
        await launchURL(context, url);
      },
      child: FaIcon(
        icon,
        color: color,
        size: 32.h,
      ),
    );
  }

  Column buildContactItemList(AppLocalizations localization) {
    return Column(
      children: [
        buildContactItem(
          localization.translate('contact.phone_label'),
          Icons.phone_outlined,
        ),
        buildContactItem(
          localization.translate('contact.email_label'),
          Icons.email_outlined,
        ),
        buildContactItem(
          localization.translate('contact.address_label'),
          Icons.location_on_outlined,
        ),
      ],
    );
  }

  Padding buildContactItem(String label, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.h,
            backgroundColor: Colors.black,
            child: Icon(
              size: 16.h,
              icon,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: CustomText(
              label,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0XFF3D3D3D),
            ),
          ),
        ],
      ),
    );
  }
}
