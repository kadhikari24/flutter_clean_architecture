import 'package:complete_advanced_flutter/app/app.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp( MyApp.instance);
}
