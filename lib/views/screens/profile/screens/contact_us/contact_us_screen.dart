import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../components/profile_background_component.dart';
import '../../components/screen_label_component.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildProfileContent(context),
          ScreenLabelComponent(label: "Contact Us", icon: Icons.phone)
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildProfileContent(BuildContext context) {
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
              "Get in touch",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0XFF3D3D3D),
            ),
            SizedBox(
              height: 4.h,
            ),
            const CustomText(
              "Please contact us via phone or email for any enquiries or assistance you need.",
              color: Color(0XFF393939),
              fontSize: 14,
            ),
            buildContactItemList(),
            const Spacer(),
            buildSocialItemList(),
          ],
        ),
      ),
    );
  }

  Column buildSocialItemList() {
    return Column(
      children: [
        const CustomText(
          "Follow us on",
          color: Color(0xFF6A6A6A),
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
                  FontAwesomeIcons.linkedin, Colors.blue[700], () {}),
              buildSocialIcon(
                  FontAwesomeIcons.squareInstagram, Colors.pink, () {}),
              buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue, () {}),
              buildSocialIcon(
                  FontAwesomeIcons.squareWhatsapp, Colors.green, () {}),
              buildSocialIcon(
                  FontAwesomeIcons.squareYoutube, Colors.red, () {}),
              buildSocialIcon(
                  FontAwesomeIcons.squareXTwitter, Colors.black, () {}),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector buildSocialIcon(
      IconData icon, Color? color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: FaIcon(
        icon,
        color: color,
        size: 32.h,
      ),
    );
    ;
  }

  Column buildContactItemList() {
    return Column(
      children: [
        buildContactItem("+91 1123456789", Icons.phone_outlined),
        buildContactItem("ask.dhenudharma@gmail.com", Icons.email_outlined),
        buildContactItem(
            "402 Lotus Towers, Vasant Vihar, New Delhi, Delhi 110057, India",
            Icons.location_on_outlined),
      ],
    );
  }

  Padding buildContactItem(label, icon) {
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
