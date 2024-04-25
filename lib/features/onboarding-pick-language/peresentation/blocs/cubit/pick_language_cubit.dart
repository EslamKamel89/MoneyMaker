import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading/core/localization/locale_cache_helper.dart';
import 'package:trading/core/themes/apptheme_data.dart';
import 'package:trading/core/themes/apptheme_enum.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/themes/theme_cache_helper.dart';

part 'pick_language_state.dart';

class PickLanguageAndThemeCubit extends Cubit<PickLanguageAndThemeState> {
  SharedPreferences sharedPreferences;
  LocaleCacheHelper localeCacheHelper;
  ThemeCacheHelper themeCacheHelper;
  PickLanguageAndThemeCubit({
    required this.sharedPreferences,
    required this.localeCacheHelper,
    required this.themeCacheHelper,
  }) : super(PickLanguageAndThemeState(locale: const Locale('en'), themeData: appThemeData[AppTheme.blueLight]!));
  void changeLanguage(Locale locale) {
    localeCacheHelper.cacheLocale(languageCode: locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  void checkCachedLanguage() {
    emit(state.copyWith(locale: localeCacheHelper.getCachedLocale()));
  }

  void changeTheme(bool activateLightTheme) {
    ThemeData themeData = (activateLightTheme ? appThemeData[AppTheme.blueLight] : appThemeData[AppTheme.blueDark])!;
    themeCacheHelper.cacheTheme(themeType: activateLightTheme ? "light" : "dark");
    Clr.init();
    // themeData.brightness.prm('Theme Type');
    emit(state.copyWith(themeData: themeData));
  }

  void checkCachedTheme() {
    ThemeData themeData = themeCacheHelper.getCachedTheme();
    Clr.init();
    emit(state.copyWith(themeData: themeData));
  }

  bool isLightTheme() {
    return themeCacheHelper.isLightTheme();
  }

  bool isEnglishLanguage() {
    return state.locale.languageCode == 'en';
  }
}