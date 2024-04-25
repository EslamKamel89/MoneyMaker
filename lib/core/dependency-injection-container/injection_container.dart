import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/localization/locale_cache_helper.dart';
import 'package:trading/core/routing/app_router.dart';
import 'package:trading/core/routing/middleware.dart';
import 'package:trading/core/themes/theme_cache_helper.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! -- Features -- onBorading and pick language ---------------------------------------------------------------------------------
  sl.registerLazySingleton<PickLanguageAndThemeCubit>(() => PickLanguageAndThemeCubit(
        sharedPreferences: sl(),
        localeCacheHelper: sl(),
        themeCacheHelper: sl(),
      ));
  //! -- Features -- Singup -------------------------------------------------------------------------------------------------------
  sl.registerLazySingleton<SignupCubit>(() => SignupCubit());
  //! -- Features -- Signin -------------------------------------------------------------------------------------------------------
  sl.registerLazySingleton<SigninCubit>(() => SigninCubit());
  //! -- Core --------------------------------------------------------------------------------------------------------------------
  sl.registerLazySingleton<AppRouter>(() => AppRouter(appMiddleWare: sl()));
  sl.registerLazySingleton<AppMiddleWare>(() => AppMiddleWare(sharedPreferences: sl()));

  //! -- CacheHelper --------------------------------------------------------------------------------------------------------------
  sl.registerLazySingleton<LocaleCacheHelper>(() => LocaleCacheHelper(sharedPreferences: sl()));
  sl.registerLazySingleton<ThemeCacheHelper>(() => ThemeCacheHelper(sharedPreferences: sl()));
  //! -- External --------------------------------------------------------------------------------------------------------------
  //? sharedPreferences ....................................................................................
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences); //
}
