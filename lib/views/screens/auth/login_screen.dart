import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/constants/app_assets.dart';
import 'package:dhenu_dharma/view_models/auth/login/login_bloc.dart';
import 'package:dhenu_dharma/views/screens/auth/otp_verification_screen.dart';
import 'package:dhenu_dharma/views/screens/auth/sign_up_screen.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:dhenu_dharma/views/screens/onboarding/onboarding_Screen.dart';
import 'package:dhenu_dharma/views/widgets/custom_button.dart';
import 'package:dhenu_dharma/views/widgets/custom_input_field.dart';
import 'package:dhenu_dharma/views/widgets/custom_navigator.dart';
import 'package:dhenu_dharma/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dhenu_dharma/utils/providers/locale_provider.dart';
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
    final localization = AppLocalizations.of(context);

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            CustomNavigator(
              context: context,
              screen: const InitialScreen(pageIndex: 0),
            ).pushReplacement();
          } else if (state is LoginError) {
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
                  height: 190.h,
                  child: Center(
                    child: Image.asset(AssetsConstants.logoImg, height: 44.h),
                  ),
                ),
                DropdownButton<Locale>(
                  value: Provider.of<LocaleProvider>(context, listen: false)
                      .locale,
                  onChanged: (Locale? locale) {
                    if (locale != null) {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .setLocale(locale);
                    }
                  },
                  dropdownColor: Colors.black,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('hi'),
                      child: Text('हिंदी'),
                    ),
                  ],
                  
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  height: MediaQuery.of(context).size.height - 190.h,
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
                        buildLogin(localization!),
                        buildSocialLogin(localization),
                        buildDoNotHaveAccount(localization),
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

  Form buildLogin(AppLocalizations localization) {
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
              localization.translate('login.welcome'), // Changed to nested key
              style: GoogleFonts.montserrat(
                fontSize: 24.h,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          CustomText(
            localization.translate('login.phone_or_email'), // Changed to nested key
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          CustomInputField(
            hint: localization.translate('login.enter_phone_or_email'), // Changed to nested key
            controller: usernameController,
            prefixIcon: Icons.email,
            onChangeText: (text) {
              BlocProvider.of<LoginBloc>(context)
                  .add(ChangeUsernameEvent(usernameController.text.trim()));
            },
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return localization.translate('login.username_empty'); // Changed to nested key
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          CustomText(
            localization.translate('login.password'), // Changed to nested key
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          CustomInputField(
            hint: localization.translate('login.enter_password'), // Changed to nested key
            controller: passwordController,
            prefixIcon: Icons.lock,
            obscureText: true,
            onChangeText: (text) {
              BlocProvider.of<LoginBloc>(context)
                  .add(ChangePasswordEvent(passwordController.text.trim()));
            },
            validator: (text) {
              return passwordValidation(text, localization);
            },
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              localization.translate('login.forgot_password'), // Changed to nested key
              color: AppColors.secondaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: localization.translate('login.login'), // Changed to nested key
            onPressed: () {
              login();
            },
          )
        ],
      ),
    );
  }


  String? passwordValidation(String? text, AppLocalizations localization) {
    if (text == null || text.trim().isEmpty) {
      return localization.translate('password_empty');
    }
    if (text.trim().length < 8) {
      return localization.translate('password_length_error');
    }
    return null;
  }

  void login() {
    if (_formKey.currentState!.validate()) {
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

  Column buildSocialLogin(AppLocalizations localization) {
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
        const FaIcon(
          FontAwesomeIcons.google,
          size: 28,
          color: AppColors.secondaryGrey,
        ),
        SizedBox(height: 20.h)
      ],
    );
  }

  Row buildDoNotHaveAccount(AppLocalizations localization) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          localization.translate('login.dont_have_account'),
          fontSize: 14,
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: () {
            CustomNavigator(context: context, screen: const SignUpScreen())
                .pushReplacement();
          },
          child: CustomText(
            localization.translate('login.sign_up'),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
