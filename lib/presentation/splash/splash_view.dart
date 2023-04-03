import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _appPreference = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _getNext);
  }

  void _getNext() {
    if (_appPreference.isUserLoggedIn()) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else if (_appPreference.isBoardingScreenView()) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }else{
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}
