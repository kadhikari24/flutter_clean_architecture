import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _appPreference = instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tut app"),
        actions: [
          IconButton(
              onPressed: () {
                _appPreference.setUserLoggedIn(false);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body:  Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Coming soon!!!"),
          IconButton(
              onPressed: () {
                _appPreference.setUserLoggedIn(false);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      )),
    );
  }
}
