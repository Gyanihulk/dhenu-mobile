import 'dart:math';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_label_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_top_content_component.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dhenu_dharma/utils/common/url_launcher_util.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  int expandedContainerIndex = 0;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch initial cow shed data immediately without async gap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cowShedProvider =
          Provider.of<CowShedProvider>(context, listen: false);
      cowShedProvider
          .fetchCowSheds(
        currentLatitude: 12.971598,
        currentLongitude: 77.594566,
      )
          .then((_) {
        if (mounted) {
          print('Fetched Cow Sheds: ${cowShedProvider.cowSheds}');
        }
      }).catchError((error) {
        if (mounted) {
          print('Error fetching Cow Sheds: $error');
        }
      });
    });
  }

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
                buildCollapsibleContainer(
                  index: 0,
                  isExpanded: expandedContainerIndex == 0,
                  title: localization.translate('donate_screen.card1title'),
                  subtitle: localization.translate('donate_screen.card1subtitle'),
                  content: buildLocationFilter(localization),
                  onToggle: () {
                    setState(() {
                      expandedContainerIndex = expandedContainerIndex == 0 ? -1 : 0;
                    });
                  },
                ),
                  buildCollapsibleContainer(
                  index: 1,
                  isExpanded: expandedContainerIndex == 1,
                  title: localization.translate('donate_screen.card2title'),
                  subtitle: localization.translate('donate_screen.card2subtitle'),
                  content: buildLocationFilter(localization),
                  onToggle: () {
                    setState(() {
                      expandedContainerIndex = expandedContainerIndex == 1 ? -1 : 1;
                    });
                  },
                ),
                
                SizedBox(height: 30.h),
                CustomButton(
                  width: 124.w,
                  text: localization.translate('donate_screen.next'),
                  onPressed:  () {
                    setState(() {
                      if (expandedContainerIndex == 0) {
                        expandedContainerIndex = 1;
                      } else {
                        expandedContainerIndex = 0;
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCollapsibleContainer({
    required int index,
    required bool isExpanded,
    required String title,
    required String subtitle,
    required Widget content,
    required VoidCallback onToggle,
  }) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isExpanded ? 340.h : 80.h, // Adjust height dynamically
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          color: isExpanded ? AppColors.primary : AppColors.lightYellow,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                size: 28.h,
                color: isExpanded ? AppColors.title: Colors.black87,
              ),
              title: CustomText(
                title,
                fontSize: 14.h,
                fontWeight: FontWeight.w500,
                color: isExpanded ? AppColors.title : Colors.black,
              ),
              subtitle: CustomText(
                subtitle,
                fontSize: 12.h,
                color: isExpanded ? AppColors.title : Colors.black54,
              ),
              trailing: Icon(
                isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: isExpanded ? AppColors.title : Colors.black87,
              ),
            ),
            if (isExpanded) ...[
              // Show content only if expanded
              content,
            ],
          ],
        ),
      ),
    );
  }
  Container buildLocationFilter(AppLocalizations localization) {
    // List of available images
    final List<String> images = [
      AssetsConstants.onboardingImg1,
      AssetsConstants.onboardingImg2,
      AssetsConstants.onboardingImg3,
    ];
    final random = Random();

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
                    label:
                        localization.translate('donate_screen.within_10_km')),
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
              child: Consumer<CowShedProvider>(
                builder: (context, cowShedProvider, child) {
                  // Dynamically create cards for each cow shed
                  return Column(
                    children: cowShedProvider.cowSheds.map((cowShed) {
                      final randomImage = images[random.nextInt(images.length)];
                      return buildGowshala(
                        image: randomImage,
                        name: cowShed['name'] ?? 'Unknown',
                        distance: cowShed['distance'] ?? 0,
                        id: cowShed['id'],
                        cowShedProvider: cowShedProvider,
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

  Widget buildGowshala({
    required String name,
    required int distance,
    required String image,
    required int id,
    required CowShedProvider cowShedProvider,
  }) {
    final isSelected = cowShedProvider.selectedCowShedId ==
        id; // Check if the card is selected

    return GestureDetector(
      onTap: () {
        cowShedProvider
            .updateSelectedCowShedId(id); // Update selected cow shed ID
      },
      child: Container(
        height: 58.h,
        margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.selected
              : AppColors.secondaryWhite, // Highlight selected card
          border: Border.all(
            color: isSelected
                ? AppColors.selectedBorder
                : AppColors.secondaryWhite,
          ),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84.w,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
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
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w600,
                          ),
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
                      children: [
                        Text(
                          "$distance km away",
                          style: TextStyle(
                            fontSize: 12.w,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
