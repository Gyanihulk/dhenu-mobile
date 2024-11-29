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
          // Grid of Seva Options
          buildSevaCards(context),
        ],
      ),
    );
  }

  SingleChildScrollView buildSevaCards(BuildContext context) {
  return SingleChildScrollView(
    child: 
        GridView.builder(
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
            return buildSevaCard(
              title: seva['title'] ?? '',
              img: seva['image'] ?? '',
            );
          },
        ),
      
   
  );
}

// Main buildSevaCard method
Wrap buildSevaCard({required String title, required String img}) {
  return Wrap(
    children: [
      Container(
        width: 152.w,
        height: 110.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff272727), // Main card color
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Background image with curved edges
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Curved edges
              child: Image.asset(
                img,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover, // Fills the container
              ),
            ),

            // Divider line (Yellow)
            Positioned(
              bottom: 24.h, // Above the overlay container
              left: 0,
              right: 0,
              child: Container(
                height: 2.h,
                color: Colors.yellow, // Yellow divider color
              ),
            ),

            // Overlay (Blur container with text and icon)
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
    bottom: 0, // Align to the bottom of the card
    left: 0,
    right: 0,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
        child: Container(
          height: 32.h, // Increased height for the overlay
          color: Colors.black.withOpacity(0.5), // Semi-transparent black overlay
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h), // Adjusted vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp, // Slightly larger font for better readability
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Icon
              Icon(
                Icons.info,
                color: Colors.white,
                size: 20.sp, // Slightly larger icon size
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


}
