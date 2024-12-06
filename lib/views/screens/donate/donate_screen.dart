import 'dart:math';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/views/screens/donate/components/calendar_selection.dart';
import 'package:dhenu_dharma/views/screens/donate/components/collapsible_container.dart';
import 'package:dhenu_dharma/views/screens/donate/components/cow_shed_selection_container.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_label_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_top_content_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donation_form_component.dart';
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
  int expandedContainerIndex = 2;
  String? errorMessage;
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
    final cowShedProvider = Provider.of<CowShedProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          DonateTopContentComponent(
            isBack: false,
          ),
          buildDonateContent(localization!, cowShedProvider),
          const DonateLabelComponent()
        ],
      ),
    );
  }

  Positioned buildDonateContent(
      AppLocalizations localization, CowShedProvider cowShedProvider) {
    void toggleExpandedIndex(int index) {
      setState(() {
        expandedContainerIndex = expandedContainerIndex == index ? -1 : index;
      });
    }

    void validateAndConfirm() {
      setState(() {
        if (cowShedProvider.donationType == "food" &&
            (cowShedProvider.quantity == null ||
                cowShedProvider.quantity == 0)) {
          errorMessage = "Please select at least one bag.";
        } else if (cowShedProvider.donationType != "food" &&
            (cowShedProvider.amount == null || cowShedProvider.amount == 0)) {
          errorMessage = "Please enter a valid amount.";
        } else {
          errorMessage = null; // Clear error if validation passes
          toggleExpandedIndex(3); // Move to the next step
        }
      });
    }

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
                  content: CowShedSelectionContainer(
                    localization: localization,
                    onSelect: (selectedCowShedId) {
                      print('Selected Cow Shed ID: $selectedCowShedId');

                      cowShedProvider.updateSelectedCowShedId(
                          selectedCowShedId); // Update provider
                      toggleExpandedIndex(1);
                    },
                  ),
                  onToggle: () => toggleExpandedIndex(0),
                ),
                CollapsibleContainer(
                  index: 1,
                  isExpanded: expandedContainerIndex == 1,
                  title: localization.translate('donate_screen.card2title'),
                  subtitle:
                      localization.translate('donate_screen.card2subtitle'),
                  content: SevaSelectionContainer(
                    onSelect: (selectedSeva) {
                      print('Selected Seva: $selectedSeva');
                      cowShedProvider.updateDonationType(selectedSeva);
                      toggleExpandedIndex(2); // Handle selected seva type
                    },
                  ),
                  onToggle: () => toggleExpandedIndex(1),
                ),
                CollapsibleContainer(
                  index: 2,
                  isExpanded: expandedContainerIndex == 2,
                  title: localization.translate('donate_screen.card3title'),
                  subtitle:
                      localization.translate('donate_screen.card3subtitle'),
                  content: DonationFormComponent(
                      donationType: cowShedProvider.donationType ??
                          "Other", // Use donationType from provider
                      quantity: cowShedProvider.quantity,
                      onInputChange: (amount) {
                        cowShedProvider
                            .updateAmount(double.tryParse(amount) ?? 0);
                        print("Entered Amount: $amount");
                        
                      },
                      onQuantityChange: (newQuantity) {
                        cowShedProvider.updateQuantity(newQuantity);
                        print("Selected Quantity: $newQuantity");
                      },
                      onConfirm: validateAndConfirm,
                       errorMessage: errorMessage, 
                      localization: localization),
                  onToggle: () => toggleExpandedIndex(2),
                ),
                CollapsibleContainer(
                  index: 3,
                  isExpanded: expandedContainerIndex == 3,
                  title: localization.translate('donate_screen.card4title'),
                  subtitle:
                      localization.translate('donate_screen.card4subtitle'),
                  content: DonationFrequency(
                    onNameChange: (name) {
                      print("Donor Name: $name");
                    },
                    onAmountChange: (amount) {
                      print("Total Donation Amount: $amount");
                    },
                  ),
                  onToggle: () => toggleExpandedIndex(3),
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  width: 124.w,
                  text: localization.translate('donate_screen.next'),
                  onPressed: () {
                    final donationDetails =
                        cowShedProvider.getDonationDetails();

                    // Log the donation details
                    print("Donation Details:");
                    print(
                        "Selected Cow Shed ID: ${donationDetails['selectedCowShedId']}");
                    print("Donation Type: ${donationDetails['donationType']}");
                    print("Quantity: ${donationDetails['quantity']}");
                    print("Amount: ${donationDetails['amount']}");
                    print(
                        "Related Fields: ${donationDetails['relatedFields']}");
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
