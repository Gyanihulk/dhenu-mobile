import 'package:dhenu_dharma/data/repositories/auth/sign_up_repository.dart'; // Import for SignUpRepository
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhenu_dharma/api/base/resource.dart';

import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_navigator.dart';
import '../../widgets/custom_text.dart';

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
                    buildSignUp(),
                    buildSocialSignUp(),
                    buildAlreadyHaveAccount()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Form(
          key: _formKey,
          child: Center(
            child: Text(
              "Sign Up",
              style: GoogleFonts.montserrat(
                fontSize: 24.h,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        const CustomText(
          "First Name",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter your First Name',
          controller: _firstnameController,
          inputType: TextInputType.name,
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "Last Name",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter your Last Name',
          controller: _lastnameController,
          inputType: TextInputType.name,
          prefixIcon: Icons.person,
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "Phone Number",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter your phone number',
          controller: _phoneController,
          inputType: TextInputType.phone,
          prefixIcon: Icons.phone_android,
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "Email ID",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter your Email ID',
          controller: _emailController,
          inputType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "Password",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter your password',
          controller: _passwordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 8.h),
        const CustomText(
          "Confirm Password",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomInputField(
          hint: 'Enter confirm password',
          controller: _confirmPasswordController,
          inputType: TextInputType.text,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 30.h),
        CustomButton(
          text: "Sign Up",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (_passwordController.text != _confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Passwords do not match')),
                );
                return;
              }

              final signUpRepository = SignUpRepository();
              final resource = await signUpRepository.signUp(
                firstName: _firstnameController.text,
                lastName: _lastnameController.text,  // Add a UI field for the last name if needed
                email: _emailController.text,
                phone: _phoneController.text,
                password: _passwordController.text,
                passwordConfirmation: _confirmPasswordController.text,
              );

              if (resource.status == Status.SUCCESS) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration successful')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (resource.status == Status.ERROR) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(resource.exception?.message ?? 'Registration failed')),
                );
              }
            }
          },
        )
      ],
    );
  }

  Column buildSocialSignUp() {
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
            const CustomText(
              "OR",
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
        SizedBox(width: 30.w),
        const FaIcon(
          FontAwesomeIcons.google,
          size: 28,
          color: AppColors.secondaryGrey,
        ),
        SizedBox(height: 20.h)
      ],
    );
  }

  Padding buildAlreadyHaveAccount() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            "Already have an account?",
            fontSize: 14,
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
              CustomNavigator(context: context, screen: const LoginScreen())
                  .pushReplacement();
            },
            child: const CustomText(
              "Sign in",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
