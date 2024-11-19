import 'package:dhenu_dharma/api/base/base_exception.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomDialog {
  static void showLoader(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 72.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 44.h),
              child: LoadingAnimationWidget.dotsTriangle(
                color: AppColors.secondary,
                size: 40,
              ),
            ),
          );
        });
  }

  static void showErrorDialog(BuildContext context, [dynamic exception]) {
    String? errorMsg = "Something went wrong!";
    if (exception is BaseException) {
      errorMsg = exception.message;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 44.h),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
          title: Center(
            child: Icon(
              Icons.warning,
              color: Colors.red,
              size: 32.h,
            ),
          ),
          content: CustomText(
            errorMsg ?? "Something went wrong!",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: CustomButton(
                text: "Close",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
