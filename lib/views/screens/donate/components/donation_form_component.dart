import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';

class DonationFormComponent extends StatelessWidget {
  final String
      donationType; // Determines whether to show quantity or amount input
  final Function(String) onInputChange;
  final int? quantity; // For quantity-based donation
  final double? amount; // For amount-based donation
  final Function(int)? onQuantityChange; // Callback for increment/decrement
  final AppLocalizations localization;

  const DonationFormComponent({
    Key? key,
    required this.donationType,
    required this.onInputChange,
    this.quantity,
    this.amount,
    this.onQuantityChange,
    required this.localization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          donationType.toLowerCase() == "food"
              ? _buildFoodDonation(context)
              : _buildAmountDonation(context),
        ],
      ),
    );
  }

  // Function to build Food Donation UI
  Widget _buildFoodDonation(BuildContext context) {
    // Calculate the number of cows fed based on the quantity of bags
    final int cowsFed = (quantity ?? 0) * 4; // 1 bag feeds 4 cows

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.subtitle, size: 16.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                localization.translate('donate_screen.food_details') ??
                    "1 bag costs ₹500 & feeds 4 cows",
                style: TextStyle(fontSize: 12.sp, color: AppColors.subtitle),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        color: Colors.black, // Set the border color
                        width: 2.0, // Set the border width
                      ),
                    ),
                    backgroundColor: AppColors.white,
                  ),
                  child: Text(
                    localization
                            .translate('donate_screen.action_label_quantity') ??
                        "QUANTITY OF BAGS",
                    style: TextStyle(fontSize: 12.sp, color: AppColors.title),
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (onQuantityChange != null &&
                                (quantity ?? 0) > 0) {
                              onQuantityChange!(quantity! - 1);
                            }
                          },
                          icon:
                              Icon(Icons.remove_circle, color: AppColors.title),
                        ),
                        Text(
                          "${quantity ?? 0}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.title,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (onQuantityChange != null) {
                              onQuantityChange!(quantity! + 1);
                            }
                          },
                          icon: const Icon(Icons.add_circle,
                              color: AppColors.title),
                        ),
                      ],
                    ),
                    
                    Text(
                      "${localization.translate('donate_screen.cows_fed')} ${cowsFed == 1 ? "$cowsFed ${localization.translate('donate_screen.cows')}" : "$cowsFed ${localization.translate('donate_screen.cows')}"}" ??
                          "Feeding $cowsFed cows", // Dynamically show cows fed
                      style:
                          TextStyle(fontSize: 12.sp, color: AppColors.subtitle),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          localization.translate('donate_screen.total_price') ?? "Total Price",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.title,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "₹ ${quantity != null ? quantity! * 500 : 0}.00", // Dynamically calculate total price
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
      ],
    );
  }

  // Function to build Amount Donation UI
  Widget _buildAmountDonation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                    color: Colors.black, // Set the border color
                    width: 2.0, // Set the border width
                  ),
                ),
                backgroundColor: AppColors.white,
              ),
              child: Text(
                localization.translate('donate_screen.action_label_amount') ??
                    "ENTER AMOUNT",
                style: TextStyle(fontSize: 12.sp, color: AppColors.title),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText:
                      localization.translate('donate_screen.enter_amount') ??
                          "Enter an amount",
                  border: const UnderlineInputBorder(),
                ),
                onChanged: onInputChange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          localization.translate('donate_screen.total_price') ?? "Total Price",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.title,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "₹ ${amount?.toStringAsFixed(2) ?? "0.00"}",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
      ],
    );
  }
}
