import 'package:dhenu_dharma/data/repositories/auth/auth_repository.dart';
import 'package:dhenu_dharma/data/repositories/user/user_repository.dart';
import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:dhenu_dharma/view_models/auth/login/login_bloc.dart';
import 'package:dhenu_dharma/view_models/auth/register/register_bloc.dart';
import 'package:dhenu_dharma/view_models/onboarding/onboarding_bloc.dart';
import 'package:dhenu_dharma/views/screens/auth/login_screen.dart';
import 'package:dhenu_dharma/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:dhenu_dharma/utils/providers/locale_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize repositories
    AuthRepository authRepository = AuthRepository();
    UserRepository userRepository = UserRepository();

    // Wrap the app with ChangeNotifierProvider for LocaleProvider
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
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
                  // Use the current locale from LocaleProvider
                  locale: localeProvider.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  home: const SplashScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
