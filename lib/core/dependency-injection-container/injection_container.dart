import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/dio_consumer.dart';
import 'package:trading/core/localization/locale_cache_helper.dart';
import 'package:trading/core/routing/app_router.dart';
import 'package:trading/core/routing/middleware.dart';
import 'package:trading/core/themes/theme_cache_helper.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/presentation/blocs/signup-cubit/signup_cubit.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/blocs/transaction-history-cubit/transaction_history_cubit.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_main_balance_cubit/withdraw_main_balance_cubit.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_weekly_balance_cubit/withdraw_weekly_balance_cubit.dart';
import 'package:trading/features/mainpage/data/advertise_repo_implement.dart';
import 'package:trading/features/mainpage/presentation/blocs/mainpage_cubit/mainpage_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/data/RefferalsRepo.dart';
import 'package:trading/features/referrals/presentation/blocs/add_refferals_cubit/add_referrals_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! -- External --------------------------------------------------------------------------------------------------------------
  //? sharedPreferences ....................................................................................
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences); //
  //! -- CacheHelper --------------------------------------------------------------------------------------------------------------
  sl.registerSingleton<LocaleCacheHelper>(LocaleCacheHelper(sharedPreferences: sl()));
  sl.registerSingleton<ThemeCacheHelper>(ThemeCacheHelper(sharedPreferences: sl()));
  //! -- Core --------------------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AppMiddleWare>(AppMiddleWare(sharedPreferences: sl()));
  sl.registerSingleton<AppRouter>(AppRouter(appMiddleWare: sl()));
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<ApiConsumer>(DioConsumer(dio: sl()));
  //! -- Auth Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AuthRepo>(AuthRepo(api: sl()));
  //! -- Payment Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<PaymentRepo>(PaymentRepo(api: sl()));
  //! -- Refferals Domain and Data -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<RefferalsRepo>(RefferalsRepo(api: sl()));
  //! -- Features -- onBorading and pick language ---------------------------------------------------------------------------------
  sl.registerSingleton<PickLanguageAndThemeCubit>(PickLanguageAndThemeCubit(
    sharedPreferences: sl(),
    localeCacheHelper: sl(),
    themeCacheHelper: sl(),
  ));
  //! -- Mainpage and advertise -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AdvertiseRepo>(AdvertiseRepo(api: sl()));
  //! -- Features -- Singup -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<SignupCubit>(SignupCubit(authRepo: sl<AuthRepo>()));
  //! -- Features -- Signin -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<SigninCubit>(SigninCubit(authRepo: sl<AuthRepo>()));
  //! -- Features -- Payment -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AddBalanceCubit>(AddBalanceCubit(paymentRepo: sl()));
  sl.registerSingleton<WithdrawMainBalanceCubit>(WithdrawMainBalanceCubit(paymentRepo: sl()));
  sl.registerSingleton<WithdrawWeeklyBalanceCubit>(WithdrawWeeklyBalanceCubit(paymentRepo: sl()));
  sl.registerSingleton<TransactionHistoryCubit>(TransactionHistoryCubit(paymentRepo: sl()));
  //! -- Features -- Add Referrals -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<AddReferralsCubit>(AddReferralsCubit(refferalRepo: sl<RefferalsRepo>()));
  //! -- Features -- Mainpage and advertise -------------------------------------------------------------------------------------------------------
  sl.registerSingleton<MainpageCubit>(MainpageCubit(advertiseRepo: sl<AdvertiseRepo>()));
}
