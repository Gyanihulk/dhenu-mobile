import 'package:dhenu_dharma/data/models/donation_model.dart';
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



class PastDonationDetailScreen extends StatelessWidget {
  final Donation donation;

  const PastDonationDetailScreen({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildPastDonationDetailContent(context, localization),
          ScreenLabelComponent(
            label: localization.translate('my_donations_screen.title'),
            icon: FontAwesomeIcons.wallet,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildPastDonationDetailContent(
      BuildContext context, AppLocalizations localization) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 44.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomText(
                localization.translate('my_donations_screen.past_donations'),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3d3d3d),
              ),
              buildDonationDetail(context,localization),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDonationDetail( BuildContext context,AppLocalizations localization) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        donation.name,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff2a2a2a),
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        "${localization.translate('my_donations_screen.distance')}: ${donation.distance}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff595959),
                      ),
                    ],
                  ),
                ),
                Container(
                   width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    image: DecorationImage(
                      image: AssetImage(donation.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 20.h,
                    child: const Icon(Icons.person),
                  ),
                  title: CustomText(
                    donation.address,
                    fontSize: 14.sp,
                  ),
                  subtitle: CustomText(
                    donation.contact,
                    fontSize: 12.sp,
                  ),
                ),
                const Divider(),
                CustomText(
                  "${localization.translate('my_donations_screen.donor')}: ${donation.donor}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  "${localization.translate('my_donations_screen.donation_amount')}: ₹ ${donation.amount}",
                  fontSize: 12.sp,
                ),
                CustomText(
                  "${localization.translate('my_donations_screen.date')}: ${donation.date}",
                  fontSize: 12.sp,
                ),
                CustomText(
                  "${localization.translate('my_donations_screen.time')}: ${donation.time}",
                  fontSize: 12.sp,
                ),
                Divider(height: 28.h),
                buildReceipts(localization),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildReceipts(AppLocalizations localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          localization.translate('my_donations_screen.receipts'),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              localization.translate(
                  'my_donations_screen.caring_contributor_receipt'),
              color: const Color(0xff3b3b3b),
            ),
            const Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              localization.translate(
                  'my_donations_screen.donation_acknowledgment'),
              color: const Color(0xff3b3b3b),
            ),
            const Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              localization.translate('my_donations_screen.philanthropy_proof'),
              color: const Color(0xff3b3b3b),
            ),
            const Icon(
              Icons.file_download_outlined,
              size: 28,
              color: Color(0xff3b3b3b),
            ),
          ],
        ),
      ],
    );
  }
}
