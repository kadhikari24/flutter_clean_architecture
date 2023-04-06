import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/data/data_source/local_data_source.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _preference = instance<AppPreferences>();
  final _cacheStorage = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.titleMedium;
    return ListView(
      children: [
        ListTile(
          onTap: _changeLanguage,
          leading: SvgPicture.asset(ImageAssets.changeLanguageIcon),
          title: Text(AppStrings.changeLanguage, style: titleTheme).tr(),
          trailing: SvgPicture.asset(ImageAssets.settingRightIcon),
        ),
        _divider(),
        ListTile(
          onTap: _contactUs,
          leading: SvgPicture.asset(ImageAssets.contactUsIcon),
          title: Text(AppStrings.contactUs, style: titleTheme).tr(),
          trailing: SvgPicture.asset(ImageAssets.settingRightIcon),
        ),
        _divider(),
        ListTile(
          onTap: _inviteFriend,
          leading: SvgPicture.asset(ImageAssets.inviteFriendIcon),
          title: Text(AppStrings.inviteYourFriend, style: titleTheme).tr(),
          trailing: SvgPicture.asset(ImageAssets.settingRightIcon),
        ),
        _divider(),
        ListTile(
          onTap: _logout,
          leading: SvgPicture.asset(ImageAssets.logoutIcon),
          title: Text(AppStrings.logout, style: titleTheme).tr(),
          trailing: SvgPicture.asset(ImageAssets.settingRightIcon),
        ),
      ],
    );
  }

  void _changeLanguage() async {
    // i will apply localisation later
    await _preference.setLanguageChanged();
    await context.setLocale(_preference.getLocal());
  }

  void _contactUs() {}

  void _inviteFriend() {}

  void _logout() {
    _cacheStorage.clearCache();
    _preference.setUserLoggedIn(false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false);
  }

  Widget _divider() => Container(
      margin: const EdgeInsets.only(left: AppMargin.m16),
      child: const Divider());
}
