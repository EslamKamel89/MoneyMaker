import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_router.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // runApp(DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) {
  //       return const MyApp();
  //     }));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<PickLanguageAndThemeCubit>(
              create: (context) => sl<PickLanguageAndThemeCubit>()
                ..checkCachedLanguage()
                ..checkCachedTheme(),
            ),
            BlocProvider<SignupCubit>(create: (context) => sl()),
            BlocProvider<SigninCubit>(create: (context) => sl())
          ],
          child: Builder(builder: (context) {
            final PickLanguageAndThemeCubit pickLanguageCubit = context.watch<PickLanguageAndThemeCubit>();
            // pickLanguageCubit.checkCachedTheme();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: pickLanguageCubit.state.themeData,
              // initialRoute: AppRoutesNames.bottomNavigationScreen,
              initialRoute: AppRoutesNames.signin,
              onGenerateRoute: sl<AppRouter>().onGenerateRoute,
              locale: pickLanguageCubit.state.locale,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalization.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                bool languageSupported = false;
                for (var locale in supportedLocales) {
                  if (deviceLocale?.languageCode == locale.languageCode) {
                    languageSupported = true;
                  }
                }
                if (deviceLocale != null && languageSupported) {
                  return deviceLocale;
                }
                return supportedLocales.first;
              },
            );
          }),
        );
      },
    );
  }
}
