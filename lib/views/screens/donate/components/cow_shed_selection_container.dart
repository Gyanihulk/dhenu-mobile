import 'dart:math';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'gowshala_card.dart'; // Import GowshalaCard widget

class CowShedSelectionContainer extends StatelessWidget {
  final AppLocalizations localization;
  final Function(int cowShedId) onSelect; // Callback for selection

  const CowShedSelectionContainer({
    super.key,
    required this.localization,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final List<String> images = [
      AssetsConstants.onboardingImg1,
      AssetsConstants.onboardingImg2,
      AssetsConstants.onboardingImg3,
    ];

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
          // Location Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLocationFilterTab(
                  label: localization.translate('donate_screen.need_based'),
                  isActive: true,
                ),
                buildLocationFilterTab(
                  label: localization.translate('donate_screen.within_10_km'),
                ),
                buildLocationFilterTab(
                  label: localization.translate('donate_screen.nearest'),
                ),
                buildLocationFilterTab(
                  label: localization.translate('donate_screen.most_review'),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // Cow Shed Cards
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<CowShedProvider>(
                builder: (context, cowShedProvider, child) {
                  return Column(
                    children: cowShedProvider.cowSheds.map((cowShed) {
                      final randomImage =
                          images[random.nextInt(images.length)];
                      return GestureDetector(
                        onTap: () {
                          onSelect(cowShed['id']); // Trigger the callback
                        },
                        child: GowshalaCard(
                          image: cowShed['picture'] ??randomImage,
                          name: cowShed['name'] ?? 'Unknown',
                          distance: cowShed['distance'] ?? 0,
                          id: cowShed['id'],
                          isSelected: cowShedProvider.selectedCowShedId ==
                              cowShed['id'], // Optional highlighting
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLocationFilterTab({
    required String label,
    bool isActive = false,
  }) {
    return Container(
      height: 34.h,
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(18.h),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.h,
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
