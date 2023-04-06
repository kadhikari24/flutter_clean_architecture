import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/main/home/home_page.dart';
import 'package:complete_advanced_flutter/presentation/main/notification_page.dart';
import 'package:complete_advanced_flutter/presentation/main/search_page.dart';
import 'package:complete_advanced_flutter/presentation/main/settings_page.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _appPreference = instance<AppPreferences>();
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage()
  ];

  final titles =  <String>[
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings
  ];
  var _currentIndex = 0;

  var _title = AppStrings.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Theme.of(context).textTheme.displayMedium),
        actions: [
          IconButton(
              onPressed: () {
                _appPreference.setUserLoggedIn(false);
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(boxShadow: [
        //   BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1_5)
        // ]),
        child: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: const Icon(Icons.notifications_sharp),
                label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings), label: AppStrings.settings),
          ],
          onTap: onChangePage,
          currentIndex: _currentIndex,
          unselectedItemColor: ColorManager.lightGrey,
          selectedItemColor: ColorManager.primary,
        ),
      ),
    );
  }

  void onChangePage(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[_currentIndex];
    });
  }
}
