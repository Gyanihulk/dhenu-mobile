import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';

class ConfirmationComponent extends StatefulWidget {
  final CowShedProvider cowShedProvider;
  final AppLocalizations localization;

  const ConfirmationComponent({
    super.key,
    required this.cowShedProvider,
    required this.localization,
  });

  @override
  State<ConfirmationComponent> createState() => _ConfirmationComponentState();
}

class _ConfirmationComponentState extends State<ConfirmationComponent> {
  @override
  Widget build(BuildContext context) {
    final donationDetails = widget.cowShedProvider.getDonationDetails();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 660.h, // Fixed height
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Details Header
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Text(
                widget.localization
                        .translate('donate_screen.complete_payment_details') ??
                    "Complete payment details",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                ),
              ),
            ),

            // Donation in the Name Of
            _buildDetailContainer(
              title: "Donation in the name of:",
              content: _buildNameDetail(donationDetails['name'] ?? 'N/A'),
            ),      SizedBox(height: 16.h),
  // Donation Type   SizedBox(height: 16.h),
            _buildDetailContainer(
              title: "Donation Type:",
              content: _buildDonationType(donationDetails['donationType'] ?? 'N/A')
            ),
            SizedBox(height: 16.h),

            // Donation Type
        

            // Price Breakdown
            _buildDetailContainer(
              title: "Price Breakdown (Monthly)",
              content: _buildPriceBreakdown(donationDetails),
            ),

            SizedBox(height: 16.h),

            // Cost per Donation
            _buildDetailContainer(
              title: "Cost per donation",
              content: _buildCostPerDonation(donationDetails),
              additionalInfo: "Amount will be deducted on the day of donation",
            ),
            SizedBox(height: 16.h), // Add spacing above the button if needed

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align button to the right
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: 8.w), // Add right padding for spacing
                  child: CustomButton(
                    width: 124.w,
                    text: widget.localization
                            .translate('donate_screen.complete_payment') ??
                        'Confirm',
                    onPressed: () async {
                      // validateAndConfirm();
                      try {
                        await widget.cowShedProvider.createDonation(context);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text("Please Complete the payment.")),
                        // );
                      } catch (error) {}
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual detail containers
  Widget _buildDetailContainer(
      {required String title,
      required Widget content,
      String? additionalInfo}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.title,
            ),
          ),
          SizedBox(height: 8.h),
          content,
          if (additionalInfo != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.info_outline,
                    color: AppColors.subtitle, size: 14.sp),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    additionalInfo,
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.subtitle),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNameDetail(String name) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
  Widget _buildDonationType(String type) {
    return Row(
      children: [
        Expanded(
          child: Text(
            type,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
  // Helper method to build price breakdown details with formatted dates
  Widget _buildPriceBreakdown(Map<String, dynamic> donationDetails) {
    List<String> dates = (donationDetails['selectedDates'] ?? [])
        .map<String>((date) => _formatDate(date))
        .take(4) // Only take the first 4 dates
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (donationDetails['donationType'] == 'Food')
          _buildRowDetail("Quantity of Bags:",
              donationDetails['quantity'].toString(), "₹ ${donationDetails['quantity'] != null ? (donationDetails['quantity'] * 500).toStringAsFixed(2) : '0.00'}"),
        _buildRowDetail("Donation Frequency:",
            donationDetails['donationFrequency'] ?? 'N/A',  donationDetails['amount']?.toStringAsFixed(2) ?? 'N/A'),
        ...dates.map((date) =>
            _buildRowDetail("Date:", date, "")), // Display each date in a row
      ],
    );
  }

  // Helper method to build cost per donation
  Widget _buildCostPerDonation(Map<String, dynamic> donationDetails) {
    String donationType = donationDetails['donationType'] ?? '';
    String cost = donationType == 'Food'
        ? "₹ ${donationDetails['quantity'] != null ? (donationDetails['quantity'] * 500).toStringAsFixed(2) : '0.00'}"
        : "₹ ${donationDetails['amount']?.toStringAsFixed(2) ?? '0.00'}";

    return Text(
      cost,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
    );
  }

  // Helper method to format date strings
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }

  // Helper method to build a row with a label and value
  Widget _buildRowDetail(String label, String value, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          if (price.isNotEmpty)
            Text(
              price,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
