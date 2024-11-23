import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';

class DonateTopContentComponent extends StatefulWidget {
  bool isBack;

  DonateTopContentComponent({super.key, this.isBack = true});

  @override
  State<DonateTopContentComponent> createState() =>
      _DonateTopContentComponentState();
}

class _DonateTopContentComponentState extends State<DonateTopContentComponent> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 250.h,
        color: const Color(0xff232122),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.h).copyWith(top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.isBack)
                      Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.h),
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryWhite,
                                  borderRadius: BorderRadius.circular(8.h)),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                      ),
                    Image.asset(
                      AssetsConstants.logoImg,
                      height: 50.h,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Wrap(
                  children: [
                    buildSearch(localization!),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFF353535),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSearch(AppLocalizations localization) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .75,
      height: 38.h,
      child: TextField(
        controller: searchController,
        style: GoogleFonts.inter(
            fontSize: 16, color: Colors.white, decoration: TextDecoration.none),
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            size: 16.h,
            color: const Color(0XFFAAAAAA),
          ),
          hintText: localization.translate('donate_screen.search_hint'),
          hintStyle: TextStyle(
            color: const Color(0XFFCCCCCC),
            fontSize: 14.sp,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          filled: true,
          fillColor: const Color(0XFF353535),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: const BorderSide(
              color: Color(0XFFCCCCCC),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
