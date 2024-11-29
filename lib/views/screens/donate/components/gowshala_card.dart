import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';

class GowshalaCard extends StatelessWidget {
  final String name;
  final int distance;
  final String image;
  final int id;
  final CowShedProvider cowShedProvider;

  const GowshalaCard({
    super.key,
    required this.name,
    required this.distance,
    required this.image,
    required this.id,
    required this.cowShedProvider,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = cowShedProvider.selectedCowShedId == id;

    return GestureDetector(
      onTap: () => cowShedProvider.updateSelectedCowShedId(id),
      child: Container(
        height: 58.h,
        margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selected : AppColors.secondaryWhite,
          border: Border.all(
            color: isSelected ? AppColors.selectedBorder : AppColors.secondaryWhite,
          ),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84.w,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 164.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.info_outline, size: 16.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 160.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$distance km away",
                          style: TextStyle(
                            fontSize: 12.w,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
