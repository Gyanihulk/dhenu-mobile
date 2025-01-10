import 'dart:math';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/views/screens/donate/components/calendar_selection.dart';
import 'package:dhenu_dharma/views/screens/donate/components/collapsible_container.dart';
import 'package:dhenu_dharma/views/screens/donate/components/confirmation_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/cow_shed_selection_container.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_label_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donate_top_content_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/donation_form_component.dart';
import 'package:dhenu_dharma/views/screens/donate/components/seva_selection_container.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
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
  String? errorMessage;
  TextEditingController searchController = TextEditingController();
  bool showConfirmation = false;

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
        // Reset error message initially
        errorMessage = null;

        // Log current donation details for debugging
        print("Validation Debug Log:");
        print("Selected Cow Shed ID: ${cowShedProvider.selectedCowShedId}");
        print("Donation Type: ${cowShedProvider.donationType}");
        print("Quantity: ${cowShedProvider.quantity}");
        print("Amount: ${cowShedProvider.amount}");
        print("Name: ${cowShedProvider.name}");
        print("Dates: ${cowShedProvider.selectedDates}");
        print("Frequency: ${cowShedProvider.donationFrequency}");
        String? dynamicErrorMessage;

        // Check if cow shed is not selected
        if (cowShedProvider.selectedCowShedId == null) {
          dynamicErrorMessage = "Please select a cow shed.";
          expandedContainerIndex = 0; // Open the first container
          print("Error: No cow shed selected.");
        }
        // Check if donation type is not selected
        else if (cowShedProvider.donationType == null) {
          dynamicErrorMessage = "Please select a donation type.";
          expandedContainerIndex = 1; // Open the second container
          print("Error: No donation type selected.");
        }
        // Check if name is not provided
        else if (cowShedProvider.name == null ||
            cowShedProvider.name!.isEmpty) {
          dynamicErrorMessage = "Please enter your name.";
          expandedContainerIndex = 3; // Open the fourth container
          print("Error: No name provided.");
        }
        // If donation type is 'Food', validate quantity
        else if (cowShedProvider.donationType == "Food" &&
            (cowShedProvider.quantity == null ||
                cowShedProvider.quantity == 0)) {
          dynamicErrorMessage =
              "Please select at least one bag for food donation.";
          expandedContainerIndex = 2; // Open the third container
          print("Error: Quantity for food donation is not valid.");
        }
        // If donation type is not 'Food', validate amount
        else if (cowShedProvider.donationType != "Food" &&
            (cowShedProvider.amount == null || cowShedProvider.amount == 0)) {
          dynamicErrorMessage = "Please enter a valid amount for the donation.";
          expandedContainerIndex = 2; // Open the third container
          print("Error: Amount for donation is not valid.");
        }

        // Show dynamic error message in SnackBar if there's an error
        if (dynamicErrorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(dynamicErrorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          // If all validations pass, proceed to confirmation
          showConfirmation = true;
          print("Validation Passed: Proceeding to confirmation.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("All details are valid. Proceeding to confirmation."),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
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
            child: showConfirmation
                ? ConfirmationComponent(
                    cowShedProvider: cowShedProvider,
                    localization: localization!)
                : Column(
                    children: [
                      CollapsibleContainer(
                        index: 0,
                        isExpanded: expandedContainerIndex == 0,
                        title:
                            localization.translate('donate_screen.card1title'),
                        subtitle: localization
                            .translate('donate_screen.card1subtitle'),
                        content: CowShedSelectionContainer(
                          localization: localization,
                          onSelect: (selectedCowShedId) {
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
                        title:
                            localization.translate('donate_screen.card2title'),
                        subtitle: localization
                            .translate('donate_screen.card2subtitle'),
                        content: SevaSelectionContainer(
                          onSelect: (selectedSeva) {
                            cowShedProvider.updateDonationType(selectedSeva);
                            toggleExpandedIndex(2); // Handle selected seva type
                          },
                        ),
                        onToggle: () => toggleExpandedIndex(1),
                      ),
                      CollapsibleContainer(
                        index: 2,
                        isExpanded: expandedContainerIndex == 2,
                        title:
                            localization.translate('donate_screen.card3title'),
                        subtitle: localization
                            .translate('donate_screen.card3subtitle'),
                        content: DonationFormComponent(
                            donationType: cowShedProvider.donationType ??
                                "Other", // Use donationType from provider
                            quantity: cowShedProvider.quantity,
                            onInputChange: (amount) {
                              cowShedProvider
                                  .updateAmount(double.tryParse(amount) ?? 0);
                            },
                            onQuantityChange: (newQuantity) {
                              cowShedProvider.updateQuantity(newQuantity);
                            },
                            onConfirm: (amount) {
                              final donationDetails =
                                  cowShedProvider.getDonationDetails();

                              toggleExpandedIndex(3);
                            },
                            amount: cowShedProvider.amount,
                            errorMessage: errorMessage,
                            localization: localization),
                        onToggle: () => toggleExpandedIndex(2),
                      ),
                      CollapsibleContainer(
                        index: 3,
                        isExpanded: expandedContainerIndex == 3,
                        title:
                            localization.translate('donate_screen.card4title'),
                        subtitle: localization
                            .translate('donate_screen.card4subtitle'),
                        content: DonationFrequency(
                          onNameChange: (name) {
                            cowShedProvider.updateName(name);
                          },
                          onAmountChange: (amount) {},
                          onConfirm: (selectedFilter, selectedDates) {
                            cowShedProvider
                                .updateDonationFrequency(selectedFilter);
                            cowShedProvider.updateSelectedDates(selectedDates);

                            // validateAndConfirm();
                          },
                          donationPerDay:cowShedProvider.amount,
                        ),
                        
                        onToggle: () => toggleExpandedIndex(3),
                      ),
                      SizedBox(height: 30.h),
                      if (errorMessage != null)
                        Positioned(
                          top: 50.h, // Position it below the IconButton
                          right: 0.w, // Align it to the right
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            color: Colors.white,
                            child: Text(
                              errorMessage!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.danger,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      CustomButton(
                        width: 124.w,
                        text: localization
                                .translate('donate_screen.complete_payment') ??
                            'Confirm',
                        onPressed: () async {
                          validateAndConfirm();
                          try {
                            // await cowShedProvider.createDonation();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content:
                            //           Text("Please Complete the payment.")),
                            // );
                          } catch (error) {}
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
