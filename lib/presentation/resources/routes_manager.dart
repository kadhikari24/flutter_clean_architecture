import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_view.dart';
import 'package:complete_advanced_flutter/presentation/login/login_view.dart';
import 'package:complete_advanced_flutter/presentation/main/main_view.dart';
import 'package:complete_advanced_flutter/presentation/onboarding/onboarding_view.dart';
import 'package:complete_advanced_flutter/presentation/register/register_view.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/splash/splash_view.dart';
import 'package:complete_advanced_flutter/presentation/store_details/store_details_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String storeDetailRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());
      case Routes.loginRoute:
         initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomePageModule();
        return MaterialPageRoute(builder: (context) => const MainView());
      case Routes.storeDetailRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(
            builder: (context) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body:  Center(child: Text(AppStrings.noRouteFound).tr()),
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound).tr(),
              ),
            ));
  }
}
