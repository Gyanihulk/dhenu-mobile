import 'package:dhenu_dharma/data/repositories/cowshed/cow_shed_repository.dart';
import 'package:dhenu_dharma/data/repositories/faqAndFeedback/help_and_feedback_repository.dart';
import 'package:dhenu_dharma/data/repositories/homePage/home_repository.dart';
import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/utils/providers/cow_shed_provider.dart';
import 'package:dhenu_dharma/utils/providers/help_and_feedback.dart';
import 'package:dhenu_dharma/utils/providers/home_provider.dart';
import 'package:dhenu_dharma/utils/providers/language_provider.dart';
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
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({required this.authProvider, super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repositories
    final authRepository = AuthRepository();
    final userRepository = UserRepository();
    final cowShedRepository = CowShedRepository();
    final homeRepository = HomeRepository();
    final helpAndFeedbackRepository = HelpAndFeedbackRepository();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProxyProvider<AuthProvider, CowShedProvider>(
          create: (context) => CowShedProvider(
            repository: cowShedRepository,
            authProvider: authProvider,
          ),
          update: (context, authProvider, previousProvider) =>
              previousProvider!..updateAuthProvider(authProvider),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            homeRepository: homeRepository,
            authProvider: authProvider,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => HelpAndFeedbackProvider(
            helpAndFeedbackRepository: helpAndFeedbackRepository,
            authProvider: authProvider,
          ),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          print("Locale value: ${localeProvider.locale.languageCode}");
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
                  navigatorKey: navigatorKey,
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
                  home: authProvider.isAuthenticated
                      ? const InitialScreen(pageIndex: 0)
                      : const LoginScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
