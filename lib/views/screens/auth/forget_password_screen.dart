import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_button.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailPhoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _currentStep = 0; // 0 for email/phone, 1 for OTP, 2 for password reset

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.secondaryBlack,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 300.h,
                child: Center(
                  child: CustomText(
                    localization?.translate('forget_password.title') ??
                        'Forgot Password',
                    fontSize: 24,
                    color: AppColors.secondaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
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
                    if (_currentStep == 0) buildEmailPhoneStep(localization),
                    if (_currentStep == 1) buildOtpVerificationStep(localization),
                    if (_currentStep == 2) buildPasswordResetStep(localization),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailPhoneStep(AppLocalizations? localization) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        CustomText(
          localization?.translate('forget_password.enter_email_or_phone') ??
              'Enter your email or phone number to reset your password.',
          fontSize: 14,
          color: AppColors.title,
        ),
        SizedBox(height: 12.h),
        CustomInputField(
          hint: localization?.translate('forget_password.email_phone_hint') ??
              'Enter email or phone number',
          controller: _emailPhoneController,
          inputType: TextInputType.text,
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: localization?.translate('forget_password.send_code') ??
              'Send Verification Code',
          onPressed: () {
            if (_emailPhoneController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization?.translate('forget_password.empty_field_error') ??
                        'Please enter a valid email or phone number.',
                  ),
                ),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localization?.translate('forget_password.code_sent') ??
                      'Verification code sent!',
                ),
              ),
            );
            setState(() {
              _currentStep = 1;
            });
          },
        ),
      ],
    );
  }

  Widget buildOtpVerificationStep(AppLocalizations? localization) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        CustomText(
          localization?.translate('forget_password.enter_otp') ??
              'Enter the verification code sent to your email/phone.',
          fontSize: 14,
          color: AppColors.title,
        ),
        SizedBox(height: 12.h),
        CustomInputField(
          hint: localization?.translate('forget_password.otp_hint') ??
              'Enter verification code',
          controller: _otpController,
          inputType: TextInputType.number,
          prefixIcon: Icons.sms,
          
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: localization?.translate('forget_password.verify_code') ??
              'Verify Code',
          onPressed: () {
            if (_otpController.text.trim().length != 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization?.translate('forget_password.invalid_otp') ??
                        'Please enter a valid 6-digit OTP.',
                  ),
                ),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localization?.translate('forget_password.otp_verified') ??
                      'OTP Verified!',
                ),
              ),
            );
            setState(() {
              _currentStep = 2;
            });
          },
        ),
      ],
    );
  }

  Widget buildPasswordResetStep(AppLocalizations? localization) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        CustomText(
          localization?.translate('forget_password.enter_new_password') ??
              'Set your new password.',
          fontSize: 14,
          color: AppColors.title,
        ),
        SizedBox(height: 12.h),
        CustomInputField(
          hint: localization?.translate('forget_password.new_password_hint') ??
              'Enter new password',
          controller: _newPasswordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        CustomInputField(
          hint: localization?.translate('forget_password.confirm_password_hint') ??
              'Confirm new password',
          controller: _confirmPasswordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: localization?.translate('forget_password.reset_button') ??
              'Reset Password',
          onPressed: () {
            if (_newPasswordController.text.trim().isEmpty ||
                _newPasswordController.text != _confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization?.translate('forget_password.password_mismatch') ??
                        'Passwords do not match or are empty.',
                  ),
                ),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localization?.translate('forget_password.success') ??
                      'Password reset successfully!',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
