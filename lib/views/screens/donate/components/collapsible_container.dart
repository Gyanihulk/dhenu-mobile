import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';

class CollapsibleContainer extends StatelessWidget {
  final int index;
  final bool isExpanded;
  final String title;
  final String subtitle;
  final Widget content;
  final VoidCallback onToggle;

  const CollapsibleContainer({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.onToggle,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isExpanded
            ? index == 2 
                ? 260.h
                : index==3?660.h:340.h
            : 80.h,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          color: isExpanded ? AppColors.primary : AppColors.lightYellow,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                index == 0 ? Icons.location_on_outlined : Icons.receipt,
                size: 28.h,
                color: isExpanded ? AppColors.title : Colors.black87,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.w500,
                  color: isExpanded ? AppColors.title : Colors.black,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.h,
                  color: isExpanded ? AppColors.title : Colors.black54,
                ),
              ),
              trailing: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: isExpanded ? AppColors.title : Colors.black87,
              ),
            ),
            if (isExpanded) content,
          ],
        ),
      ),
    );
  }
}
