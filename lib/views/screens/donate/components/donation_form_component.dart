import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';

class DonationFormComponent extends StatefulWidget {
  final String
      donationType; // Determines whether to show quantity or amount input
  final Function(String) onInputChange;
  final int? quantity; // For quantity-based donation
  final double? amount; // For amount-based donation
  final Function(int)? onQuantityChange; // Callback for increment/decrement
  final AppLocalizations localization;
  final Function(String) onConfirm; // Callback for confirming the selection
  final String? errorMessage;

  const DonationFormComponent({
    Key? key,
    required this.donationType,
    required this.onInputChange,
    this.quantity,
    this.amount,
    this.onQuantityChange,
    required this.localization,
    required this.onConfirm,
    this.errorMessage,
  }) : super(key: key);

  @override
  _DonationFormComponentState createState() => _DonationFormComponentState();
}

class _DonationFormComponentState extends State<DonationFormComponent> {
  late String donationType;
  late int quantity;
  late double amount;
  late String? errorMessage;
  late AppLocalizations localization;

  @override
  void initState() {
    super.initState();
    donationType = widget.donationType;
    quantity = widget.quantity ?? 0;
    amount = widget.amount ?? 0.0;
    errorMessage = widget.errorMessage;
    localization = widget.localization;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow outside Stack
        children: [
          // Main content (Row with donation form)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: donationType.toLowerCase() == "food"
                        ? _buildFoodDonation(context)
                        : _buildAmountDonation(context),
                  ),
                  SizedBox(width: 4.w),
                ],
              ),
            ],
          ),

          // Positioned IconButton on top layer
          Positioned(
            top: 70.h, // Adjust vertical position as needed
            right: 45.w, // Adjust horizontal position as needed
            child: IconButton(
              onPressed: () {
                print('Confirm button pressed in DonationFormComponent');
                widget.onConfirm("test");
              },
              icon: const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 40, // Increase size if needed
              ),
              tooltip:
                  localization.translate('donate_screen.confirm') ?? "Confirm",
            ),
          ),

          // Positioned Error Message
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
        ],
      ),
    );
  }

  // Function to build Food Donation UI
  Widget _buildFoodDonation(BuildContext context) {
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
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                backgroundColor: AppColors.white,
              ),
              child: Text(
                localization.translate('donate_screen.action_label_quantity') ??
                    "QUANTITY OF BAGS",
                style: TextStyle(fontSize: 12.sp, color: AppColors.title),
              ),
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (widget.onQuantityChange != null &&
                        (quantity ?? 0) > 0) {
                      setState(() {
                        quantity -= 1;
                      });

                      // Calculate amount based on updated quantity and convert to string
                      String calculatedValue = "${(quantity ?? 0) * 500}";
                      print('$calculatedValue -1');

                      widget.onQuantityChange!(
                          quantity!); // Pass updated quantity
                      widget.onInputChange(
                          calculatedValue); // Update the amount as string
                    }
                  },
                  icon: const Icon(Icons.remove_circle, color: AppColors.title),
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
                    if (widget.onQuantityChange != null) {
                      setState(() {
                        quantity += 1;
                      });

                      // Calculate amount based on updated quantity and convert to string
                      String calculatedValue = "${(quantity ?? 0) * 500}";
                      print('$calculatedValue +1');

                      widget.onQuantityChange!(
                          quantity!); // Pass updated quantity
                      widget.onInputChange(
                          calculatedValue); // Update the amount as string
                    }
                  },
                  icon: const Icon(Icons.add_circle, color: AppColors.title),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "${localization.translate('donate_screen.cows_fed')} $cowsFed",
          style: TextStyle(fontSize: 12.sp, color: AppColors.subtitle),
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
          "₹ ${quantity != null ? quantity! * 500 : 0}.00",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.title,
          ),
        ),
      ],
    );
  }
@override
void didUpdateWidget(covariant DonationFormComponent oldWidget) {
  super.didUpdateWidget(oldWidget);
  // Update local amount state when the prop changes
  if (widget.amount != oldWidget.amount) {
    setState(() {
      amount = widget.amount ?? 0.0;
    });
  }
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
                    color: Colors.black,
                    width: 2.0,
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
                onChanged: (value) {
                widget.onInputChange(value);
              },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Text(
              localization.translate('donate_screen.total_price') ??
                  "Total Price",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.title,
              ),
            ),
          ],
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
