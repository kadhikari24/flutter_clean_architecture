import 'dart:ui';

import 'package:complete_advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKeyLanguage = 'Pref_key_language';
const String prefKeyOnBoardingScreen = 'pref_key_on_boarding_viewed';
const String prefKeyUserLogin = 'pref_key_user_logged_in';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setLanguageChanged() async {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.hindi.getValue()) {
      // save prefs with english lang
      await _sharedPreferences.setString(
          prefKeyLanguage, LanguageType.english.getValue());
    } else {
      // save prefs with arabic lang
     await _sharedPreferences.setString(
          prefKeyLanguage, LanguageType.hindi.getValue());
    }
  }

  Locale getLocal() {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.hindi.getValue()) {
      // return arabic local
      return HINDI_LOCAL;
    } else {
      // return english local
      return ENGLISH_LOCAL;
    }
  }

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(prefKeyLanguage);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setOnBoardingScreen() async =>
      _sharedPreferences.setBool(prefKeyOnBoardingScreen, true);

  bool isBoardingScreenView() =>
      _sharedPreferences.getBool(prefKeyOnBoardingScreen) ?? false;

  Future<void> setUserLoggedIn(bool value) async =>
      _sharedPreferences.setBool(prefKeyUserLogin, value);

  bool isUserLoggedIn()  =>
      _sharedPreferences.getBool(prefKeyUserLogin) ?? false;
}
