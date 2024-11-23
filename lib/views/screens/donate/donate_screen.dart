import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_label_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_top_content_component.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}
class _DonateScreenState extends State<DonateScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          DonateTopContentComponent(
            isBack: false,
          ),
          buildDonateContent(localization!),
          const DonateLabelComponent()
        ],
      ),
    );
  }

  Positioned buildDonateContent(AppLocalizations localization) {
    return Positioned(
      top: 162.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 340.h,
                  margin: EdgeInsets.only(top: 16.h),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16.h)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          size: 28.h,
                        ),
                        title: CustomText(
                          localization.translate('donate_screen.title'),
                          fontSize: 14.h,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: CustomText(
                          localization.translate('donate_screen.subtitle'),
                          fontSize: 12.h,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_up),
                      ),
                      buildLocationFilter(localization),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  width: 124.w,
                  text: localization.translate('donate_screen.next'),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLocationFilter(AppLocalizations localization) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.h),
      height: 272.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLocationFilterTab(
                    label: localization.translate('donate_screen.need_based'),
                    isActive: true),
                buildLocationFilterTab(
                    label: localization.translate('donate_screen.within_10_km')),
                buildLocationFilterTab(
                    label: localization.translate('donate_screen.nearest')),
                buildLocationFilterTab(
                    label: localization.translate('donate_screen.most_review')),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildGowshala(
                    image: AssetsConstants.onboardingImg1,
                    name: "Ashray Gowshala",
                    distance: 10,
                  ),
                  buildGowshala(
                    image: AssetsConstants.onboardingImg3,
                    name: "Gopal Dham",
                    distance: 15,
                  ),
                  buildGowshala(
                    image: AssetsConstants.onboardingImg2,
                    name: "Gau Raksha Kendra",
                    distance: 18,
                  ),
                  buildGowshala(
                    image: AssetsConstants.onboardingImg1,
                    name: "Kamadhenu Ashram",
                    distance: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildGowshala(
      {required String name, required int distance, required String image}) {
    return Container(
      height: 58.h,
      margin: EdgeInsets.only(bottom: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 84.w,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.h),
                bottomLeft: Radius.circular(12.h),
                topRight: Radius.circular(12.h),
                bottomRight: Radius.circular(12.h),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 164.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        name,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.info_outline,
                        size: 16.h,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 160.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        "$distance km away",
                        fontSize: 12.w,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 4.h,
                            color: Colors.red,
                          ),
                          Container(
                            width: 20.w,
                            height: 4.h,
                            color: Colors.yellow,
                          ),
                          Container(
                            width: 20.w,
                            height: 4.h,
                            color: Colors.green,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildLocationFilterTab(
      {required String label, bool isActive = false}) {
    return Container(
      height: 34.h,
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(18.h)),
      child: CustomText(
        label,
        fontSize: 10.h,
        fontWeight: FontWeight.w500,
        color: isActive ? AppColors.primary : Colors.black,
      ),
    );
  }
}
