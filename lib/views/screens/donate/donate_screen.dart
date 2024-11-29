import 'dart:math';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/views/screens/donate/components/collapsible_container.dart';
import 'package:dhenu_dharma/views/screens/donate/components/docation_order_card.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_label_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_top_content_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/seva_selection_container.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
                CollapsibleContainer(
                  index: 0,
                  isExpanded: expandedContainerIndex == 0,
                  title: localization.translate('donate_screen.card1title'),
                  subtitle:
                      localization.translate('donate_screen.card1subtitle'),
                  content:
                      CowShedSelectionContainer(localization: localization),
                  onToggle: () {
                    setState(() {
                      expandedContainerIndex =
                          expandedContainerIndex == 0 ? -1 : 0;
                    });
                  },
                ),
                CollapsibleContainer(
                  index: 1,
                  isExpanded: expandedContainerIndex == 1,
                  title: localization.translate('donate_screen.card2title'),
                  subtitle:
                      localization.translate('donate_screen.card2subtitle'),
                  content: SevaSelectionContainer(
                    onSelect: (selectedSeva) {
                      print(
                          'Selected Seva: $selectedSeva'); // Handle selected seva type
                    },
                  ),
                  onToggle: () {
                    setState(() {
                      expandedContainerIndex =
                          expandedContainerIndex == 1 ? -1 : 1;
                    });
                  },
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  width: 124.w,
                  text: localization.translate('donate_screen.next'),
                  onPressed: () {
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
}
