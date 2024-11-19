import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/view_models/auth/login/login_bloc.dart';
import 'package:dhenu_dharma/view_models/auth/register/register_bloc.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:dhenu_dharma/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    UserRepository userRepository = UserRepository();
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, index) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginBloc(
                  authRepository: authRepository,
                  userRepository: userRepository,
                ),
              ),
              BlocProvider(
                create: (context) => RegisterBloc(authRepository),
              ),
              BlocProvider(
                create: (context) => OnboardingBloc(userRepository),
              ),
            ],
            child: MaterialApp(
              title: 'DHENU DHARMA',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                useMaterial3: true,
              ),
              home: const SplashScreen(),
            ),
          );
        });
  }
}
