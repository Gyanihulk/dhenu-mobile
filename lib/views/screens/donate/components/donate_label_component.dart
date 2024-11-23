import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonateLabelComponent extends StatelessWidget {
  const DonateLabelComponent({super.key});

  @override
  Widget build(BuildContext context) {
        final localization = AppLocalizations.of(context);
    return Positioned(
      top: 142.h,
      left: 16.h,
      child: Card(
        color: AppColors.primary,
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.h)),
        child: SizedBox(
          width: 112.w,
          height: 40.h,
          child:  Center(
            child: CustomText(
              localization?.translate('donate_screen.donate') ?? 'Donate',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
