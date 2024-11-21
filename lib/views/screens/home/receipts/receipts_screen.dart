import 'package:dhenu_dharma/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../components/profile_background_component.dart';
import '../components/screen_label_component.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ProfileBackgroundComponent(bgImg: AssetsConstants.userProfileBgImg1),
          buildReceiptsContent(context),
          ScreenLabelComponent(
            label: "Receipts",
            icon: Icons.receipt_outlined,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 2),
    );
  }

  Positioned buildReceiptsContent(BuildContext context) {
    return Positioned(
      top: 150.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 44.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(70.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              "Sample Receipts",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xff3d3d3d),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView(
                children: [
                  buildReceiptRow(
                    leftTitle: "Receipt #1",
                    leftDate: "10 Nov, 2024",
                    leftAmount: "₹5000",
                    rightTitle: "Receipt #2",
                    rightDate: "15 Oct, 2024",
                    rightAmount: "₹2500",
                  ),
                  SizedBox(height: 12.h),
                  buildReceiptRow(
                    leftTitle: "Receipt #3",
                    leftDate: "20 Sep, 2024",
                    leftAmount: "₹1000",
                    rightTitle: "Receipt #4",
                    rightDate: "05 Sep, 2024",
                    rightAmount: "₹750",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildReceiptRow({
    required String leftTitle,
    required String leftDate,
    required String leftAmount,
    required String rightTitle,
    required String rightDate,
    required String rightAmount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildReceiptCard(title: leftTitle, date: leftDate, amount: leftAmount),
        buildReceiptCard(title: rightTitle, date: rightDate, amount: rightAmount),
      ],
    );
  }

  Container buildReceiptCard({
    required String title,
    required String date,
    required String amount,
  }) {
    return Container(
      width: 152.w,
      height: 110.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xfff2f2f2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: CustomText(
              title,
              color: const Color(0xff3d3d3d),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomText(
              date,
              color: const Color(0xff6f6f6f),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          // const Divider(color: Color(0xffd9d9d9)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: CustomText(
              amount,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
