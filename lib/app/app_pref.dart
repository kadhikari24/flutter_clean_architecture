import 'package:complete_advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKeyLanguage = 'Pref_key_language';
const String prefKeyOnBoardingScreen = 'pref_key_on_boarding_viewed';
const String prefKeyUserLogin = 'pref_key_user_logged_in';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String language = _sharedPreferences.getString(prefKeyLanguage) ?? english;
    return language;
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
