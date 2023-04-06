import 'package:complete_advanced_flutter/app/app.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp.instance));
}
