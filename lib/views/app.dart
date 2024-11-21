import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/locale_provider.dart';
import 'package:dhenu_dharma/view_models/auth/login/login_bloc.dart';
import 'package:dhenu_dharma/view_models/auth/register/register_bloc.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:dhenu_dharma/views/screens/splash/splash_screen.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart'; // Import AuthProvider


class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({required this.authProvider, super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repositories
    AuthRepository authRepository = AuthRepository();
    UserRepository userRepository = UserRepository();

    // Wrap the app with ChangeNotifierProviders
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => authProvider),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (context, child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LoginBloc(
                      authRepository: authRepository,
                      userRepository: userRepository,
                      authProvider: authProvider,
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
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: AppColors.primary),
                    useMaterial3: true,
                  ),
                  supportedLocales: const [
                    Locale('en'),
                    Locale('hi'),
                  ],
                  locale: localeProvider.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  // Show different home screens based on auth state
                  home: authProvider.isAuthenticated
                      ? const InitialScreen(pageIndex: 0) // Main app screen
                      : const LoginScreen(), // Login screen
                ),
              );
            },
          );
        },
      ),
    );
  }
}
