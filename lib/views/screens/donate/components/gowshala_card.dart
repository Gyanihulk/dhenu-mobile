import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
class GowshalaCard extends StatelessWidget {
  final String image;
  final String name;
  final double distance;
  final int id;
  final bool isSelected; // New flag for highlighting

  const GowshalaCard({
    super.key,
    required this.image,
    required this.name,
    required this.distance,
    required this.id,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.yellow : Colors.white, // Highlight if selected
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 50.h,
            width: 50.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '${distance.toStringAsFixed(2)} km away',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
