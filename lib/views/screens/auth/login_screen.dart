import 'dart:developer';

import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/view_models/auth/login/login_bloc.dart';
import 'package:dhenu_dharma/views/screens/auth/sign_up_screen.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/app_assets.dart';
import '../../widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Correct class name
            // Navigate to InitialScreen on successful login
            CustomNavigator(
              context: context,
              screen: const InitialScreen(pageIndex: 0),
            ).pushReplacement();
          } else if (state is LoginError) {
            // Correct class name
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.secondaryBlack,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 220.h,
                  child: Center(
                    child: Image.asset(AssetsConstants.logoImg, height: 44.h),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  height: MediaQuery.of(context).size.height - 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70.w),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildLogin(),
                        buildSocialLogin(),
                        buildDoNotHaveAccount()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildLogin() {
    return Form(
      key: _formKey,
      autovalidateMode:
          autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Center(
            child: Text(
              "Login",
              style: GoogleFonts.montserrat(
                fontSize: 24.h,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          const CustomText(
            "Phone Number / Email ID",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          CustomInputField(
            hint: 'Enter your Phone Number or Email ID',
            controller: usernameController,
            prefixIcon: Icons.email,
            onChangeText: (text) {
              BlocProvider.of<LoginBloc>(context)
                  .add(ChangeUsernameEvent(usernameController.text.trim()));
            },
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return "Username or email cannot be empty";
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          const CustomText(
            "Password",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          CustomInputField(
            hint: 'Enter your password',
            controller: passwordController,
            prefixIcon: Icons.lock,
            obscureText: true,
            onChangeText: (text) {
              BlocProvider.of<LoginBloc>(context)
                  .add(ChangePasswordEvent(passwordController.text.trim()));
            },
            validator: (text) {
              return passwordValidation(text);
            },
          ),
          SizedBox(height: 2.h),
          const Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              "Forgot Password?",
              color: AppColors.secondaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: "Login",
            onPressed: () {
              login();
            },
          )
        ],
      ),
    );
  }

  String? passwordValidation(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "Password cannot be empty";
    }

    final password = text.trim();

    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    return null;
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      // Trigger the login event
      BlocProvider.of<LoginBloc>(context).add(
        LoginLoadEvent(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  Column buildSocialLogin() {
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
        const FaIcon(
          FontAwesomeIcons.google,
          size: 28,
          color: AppColors.secondaryGrey,
        ),
        SizedBox(height: 20.h)
      ],
    );
  }

  Row buildDoNotHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          "Don't have an account?",
          fontSize: 14,
        ),
        SizedBox(width: 4.w),
        GestureDetector(
            onTap: () {
              CustomNavigator(context: context, screen: const SignUpScreen())
                  .pushReplacement();
            },
            child: const CustomText(
              "Sign Up",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
