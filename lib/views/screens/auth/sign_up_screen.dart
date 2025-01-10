import 'package:dhenu_dharma/data/repositories/auth/sign_up_repository.dart'; // Import for SignUpRepository
import 'package:dhenu_dharma/utils/auth/sign_up_with_google.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/screens/auth/otp_verification_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_input_field.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhenu_dharma/api/base/resource.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                height: 160.h,
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
                    buildSignUp(localization!),
                    buildSocialSignUp(localization),
                    buildAlreadyHaveAccount(localization)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSignUp(AppLocalizations localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Form(
          key: _formKey,
          child: Center(
            child: Text(
              localization.translate('signup.title'), // Localized
              style: GoogleFonts.montserrat(
                fontSize: 24.h,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        CustomText(
          localization.translate('signup.first_name'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: localization.translate('signup.enter_first_name'), // Localized
          controller: _firstnameController,
          inputType: TextInputType.name,
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 8.h),
        CustomText(
          localization.translate('signup.last_name'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: localization.translate('signup.enter_last_name'), // Localized
          controller: _lastnameController,
          inputType: TextInputType.name,
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 8.h),
        CustomText(
          localization.translate('signup.phone_number'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint:
              localization.translate('signup.enter_phone_number'), // Localized
          controller: _phoneController,
          inputType: TextInputType.phone,
          prefixIcon: Icons.phone_android,
        ),
        SizedBox(height: 8.h),
        CustomText(
          localization.translate('signup.email_id'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: localization.translate('signup.enter_email_id'), // Localized
          controller: _emailController,
          inputType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
        ),
        SizedBox(height: 8.h),
        CustomText(
          localization.translate('signup.password'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: localization.translate('signup.enter_password'), // Localized
          controller: _passwordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 8.h),
        CustomText(
          localization.translate('signup.confirm_password'), // Localized
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: localization
              .translate('signup.enter_confirm_password'), // Localized
          controller: _confirmPasswordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 30.h),
        CustomButton(
          text: localization.translate('signup.sign_up_button'), // Localized
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_passwordController.text != _confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(localization.translate(
                          'signup.passwords_do_not_match'))), // Localized
                );
                return;
              }

              final signUpRepository = SignUpRepository();
              final resource = await signUpRepository.signUp(
                firstName: _firstnameController.text,
                lastName: _lastnameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                password: _passwordController.text,
                passwordConfirmation: _confirmPasswordController.text,
              );
              print(resource);
              if (resource.status == Status.SUCCESS) {
                if (!mounted) return;
                print("Navigating to OnboardingScreen...");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(localization.translate(
                          'signup.registration_successful'))), // Localized
                );
                 String phoneOrEmail = _emailController.text.isNotEmpty ? _emailController.text : _phoneController.text;
                CustomNavigator(
                  context: context,
                  screen: OtpVerificationScreen(phoneOrEmail: phoneOrEmail),
                ).pushReplacement();
              } else if (resource.status == Status.ERROR) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(resource.exception?.message ??
                          localization.translate(
                              'signup.registration_failed'))), // Localized
                );
              }
            }
          },
        )
      ],
    );
  }

  Column buildSocialSignUp(AppLocalizations localization) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130.w,
              height: 0.5,
              color: AppColors.secondaryGrey,
            ),
            SizedBox(width: 8.w),
            CustomText(
              localization.translate('login.or'),
              color: AppColors.secondaryBlack,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 8.w),
            Container(
              width: 130.w,
              height: 0.5,
              color: AppColors.secondaryGrey,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        GestureDetector(
        onTap: () async {
          User? user = await signUpWithGoogle();
          if (user != null) {
            print('Google sign-in successful: ${user}');
           CustomNavigator(
              context: context,
              screen: const InitialScreen(pageIndex: 0),
            ).pushReplacement();
          } else {
            print('Google sign-in canceled or failed.');
          }
        },
        child: const FaIcon(
          FontAwesomeIcons.google,
          size: 28,
          color: AppColors.secondaryGrey,
        ),
      ),
        SizedBox(height: 20.h)
      ],
    );
  }

  Padding buildAlreadyHaveAccount(AppLocalizations localization) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CustomText(
          //   localization.translate('signup.have_account'),
          //   fontSize: 14,
          // ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
              CustomNavigator(context: context, screen: const LoginScreen())
                  .pushReplacement();
            },
            child: CustomText(
              localization.translate('signup.have_account'),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
