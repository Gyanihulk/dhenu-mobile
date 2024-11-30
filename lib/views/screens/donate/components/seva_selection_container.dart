import 'dart:ui';

import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
class SevaSelectionContainer extends StatefulWidget {
  final Function(String sevaType) onSelect; // Callback for selection
  const SevaSelectionContainer({super.key, required this.onSelect});

  @override
  State<SevaSelectionContainer> createState() => _SevaSelectionContainerState();
}

class _SevaSelectionContainerState extends State<SevaSelectionContainer> {
  String? selectedSeva; // Tracks the selected seva type

  final List<Map<String, String>> sevaOptions = [
    {"title": "Doctors", "image": AssetsConstants.sevaImg1},
    {"title": "Medicine", "image": AssetsConstants.sevaImg3},
    {"title": "Food", "image": AssetsConstants.sevaImg2},
    {"title": "Others", "image": AssetsConstants.sevaImg4},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSevaCards(context),
        ],
      ),
    );
  }

  GridView buildSevaCards(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two cards in one row
        crossAxisSpacing: 8.w, // Spacing between cards horizontally
        mainAxisSpacing: 8.h, // Spacing between cards vertically
        childAspectRatio: 1.1, // Adjust card aspect ratio as needed
      ),
      itemCount: sevaOptions.length,
      physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
      shrinkWrap: true, // Allow GridView to size itself based on content
      itemBuilder: (context, index) {
        final seva = sevaOptions[index];
        return GestureDetector(
          onTap: () {
            // Update the selected seva
            setState(() {
              selectedSeva = seva['title'];
            });

            // Trigger the onSelect callback
            widget.onSelect(selectedSeva!);
          },
          child: buildSevaCard(
            title: seva['title'] ?? '',
            img: seva['image'] ?? '',
            isSelected: selectedSeva == seva['title'], // Highlight selected card
          ),
        );
      },
    );
  }

  // Main buildSevaCard method
  Wrap buildSevaCard({
    required String title,
    required String img,
    required bool isSelected,
  }) {
    return Wrap(
      children: [
        Container(
          width: 152.w,
          height: 110.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? AppColors.primary : const Color(0xff272727), // Highlight selected card
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  img,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 24.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 2.h,
                  color: Colors.yellow,
                ),
              ),
              buildBlurOverlay(title),
            ],
          ),
        ),
      ],
    );
  }

  // Function for creating the blur overlay with text and icon
  Widget buildBlurOverlay(String title) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 32.h,
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
