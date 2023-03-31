
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/font_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getThemeApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
      //ripple color
      splashColor: ColorManager.primaryOpacity70,

      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s12),

      appBarTheme: AppBarTheme(
          color: ColorManager.primary,
          centerTitle: true,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12))
          )),

      textTheme: TextTheme(
        titleLarge: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16), //headLine1
        titleMedium: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14), // subtitle1
        titleSmall: getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s14), // subtitle2 //
        labelLarge: getRegularStyle(color: ColorManager.grey1), //caption
        bodyLarge: getRegularStyle(color: ColorManager.grey)),// bodyText1)

      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          hintStyle: getRegularStyle(color: ColorManager.grey1),
          labelStyle: getMediumStyle(color: ColorManager.darkGrey),
          //error style
          errorStyle: getRegularStyle(color: ColorManager.error),
          //enabled border
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
          // focused bored
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
          //focused error border
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
          //error border
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
          //disable border
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGrey, width: AppSize.s1_5),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // input decoration theme (text form field)
      ));
}