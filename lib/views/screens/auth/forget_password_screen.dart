import 'package:dhenu_dharma/data/repositories/auth/forgot_password_repository.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
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

  String? _emailOrPhone; // Store email/phone for use across steps
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
                    if (_currentStep == 1) buildPasswordResetStep(localization),
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
          onPressed: () async {
            final input = _emailPhoneController.text.trim();
            if (input.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization
                            ?.translate('forget_password.empty_field_error') ??
                        'Please enter a valid email or phone number.',
                  ),
                ),
              );
              return;
            }

            _emailOrPhone = input; // Store the email/phone for later use

            final repository = ForgetPasswordRepository();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localization?.translate('forget_password.sending_code') ??
                      'Sending verification code...',
                ),
              ),
            );

            try {
              final result = await repository.sendOtp(phoneOrEmail: input);
              // setState(() {
              //   _currentStep = 1; // Move to the next step
              // });
              if (result.exception == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      localization?.translate('forget_password.code_sent') ??
                          'Verification code sent!',
                    ),
                  ),
                );
                setState(() {
                  _currentStep = 1; // Move to the next step
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      localization?.translate(
                              'forget_password.error_sending_code') ??
                          'Failed to send the verification code. Please try again.',
                    ),
                  ),
                );
              }
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization?.translate('forget_password.error_occurred') ??
                        'An error occurred while sending the verification code.',
                  ),
                ),
              );
              print('Error: $error');
            }
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
          hint: localization?.translate('forget_password.otp_hint') ??
              'Enter verification code',
          controller: _otpController,
          inputType: TextInputType.number,
          prefixIcon: Icons.sms,
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
        SizedBox(height: 12.h),
        CustomInputField(
          hint: localization
                  ?.translate('forget_password.confirm_password_hint') ??
              'Confirm ew password',
          controller: _confirmPasswordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: localization?.translate('forget_password.reset_button') ??
              'Reset Password',
          onPressed: () async {
            final newPassword = _newPasswordController.text.trim();
            final confirmPassword = _confirmPasswordController.text.trim();

            // Regular expression for password validation
            final passwordRegEx =
                RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[a-zA-Z]).{8,}$');

            // Validate new password
            if (newPassword.isEmpty || !passwordRegEx.hasMatch(newPassword)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization
                            ?.translate('forget_password.invalid_password') ??
                        'Password must be at least 8 characters long, contain a number, and a special character.',
                  ),
                ),
              );
              return;
            }

            // Validate password confirmation
            if (newPassword != confirmPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization
                            ?.translate('forget_password.password_mismatch') ??
                        'Passwords do not match.',
                  ),
                ),
              );
              return;
            }

            final repository = ForgetPasswordRepository();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  localization
                          ?.translate('forget_password.resetting_password') ??
                      'Resetting your password...',
                ),
              ),
            );

            try {
              final result = await repository.resetPasswordWithOtp(
                phoneOrEmail: _emailOrPhone ?? '',
                otp: _otpController.text.trim(),
                newPassword: newPassword,
              );
 if (!mounted) return;
              if (result.exception == null) {
                // Password reset was successful
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      localization?.translate('forget_password.success') ??
                          'Password reset successfully!',
                    ),
                  ),
                  
                );
                CustomNavigator(
              context: context,
              screen: const LoginScreen(),
            ).pushReplacement();
              } else {
                // Handle API error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      localization?.translate('forget_password.reset_failed') ??
                          (result.exception?.message ??
                              'Failed to reset password.'),
                    ),
                  ),
                );
              }
            } catch (error) {
              // Handle unexpected errors
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localization?.translate('forget_password.error_occurred') ??
                        'An error occurred while resetting the password.',
                  ),
                ),
              );
              print('Error: $error');
            }
          },
        ),
      ],
    );
  }
}
