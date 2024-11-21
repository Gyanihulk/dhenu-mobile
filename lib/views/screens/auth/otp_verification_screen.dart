import 'package:dhenu_dharma/api/base/resource.dart';
import 'package:dhenu_dharma/data/repositories/auth/sign_up_repository.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/views/screens/home/home_screen.dart';
import 'package:dhenu_dharma/views/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneOrEmail; // Phone or Email for verification

  const OtpVerificationScreen({
    super.key,
    required this.phoneOrEmail,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    // if (localization !=null) {
    //   print(
    //       'Response Body: ${localization}');
    // }
    return Scaffold(
        // appBar: buildAppBar(localization),
        body: SingleChildScrollView(
            child: Container(
      color: AppColors.secondaryBlack,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 460.h,
            child: Center(
              child: Image.asset(AssetsConstants.logoImg, height: 44.h),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondaryWhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(70.w),
              ),
            ),
            child: Column(
              children: [
                buildOtpInstruction(localization),
                buildOtpInputField(localization),
                buildVerifyButton(localization),
              ],
            ),
          ),
        ],
      ),
    )));
  }

  AppBar buildAppBar(AppLocalizations? localization) {
    return AppBar(
      title: Text(
        localization?.translate('otp_verification.title') ?? 'Verify OTP',
      ),
      backgroundColor: const Color.fromARGB(255, 244, 232, 238),
    );
  }

  Widget buildOtpInstruction(AppLocalizations? localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        CustomText(
          localization?.translate('otp_verification.enter_otp') ?? 'Enter OTP',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget buildOtpInputField(AppLocalizations? localization) {
    return CustomInputField(
      hint: localization?.translate('otp_verification.otp_hint') ??
          'Enter 6-digit OTP',
      controller: _otpController,
      inputType: TextInputType.number,
      prefixIcon: Icons.sms,
    );
  }

  Widget buildVerifyButton(AppLocalizations? localization) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: CustomButton(
        text: localization?.translate('otp_verification.verify_button') ??
            'Verify',
        onPressed: () async {
          
            await _verifyOtp(localization);
      
        },
      ),
    );
  }

  Future<void> _verifyOtp(AppLocalizations? localization) async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localization?.translate('otp_verification.invalid_otp') ??
                'Invalid OTP.',
          ),
        ),
      );
      return;
    }

    try {
      final signUpRepository = SignUpRepository();
      final response = await signUpRepository.verifyOtp(
        phoneOrEmail: widget.phoneOrEmail,
        otp: otp,
      );

      if (response.status == Status.SUCCESS) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              localization?.translate('otp_verification.success') ??
                  'OTP Verified Successfully.',
            ),
          ),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.exception?.message ??
                  localization?.translate('otp_verification.failure') ??
                  'OTP verification failed.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localization?.translate('otp_verification.failure') ??
                'An error occurred.',
          ),
        ),
      );
    }
  }
}
