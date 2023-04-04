import 'dart:io';

import 'package:complete_advanced_flutter/domain/model/device_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String version = "Unknown";
  String identifier = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final tempInfo = await deviceInfoPlugin.androidInfo;
    name = "${tempInfo.brand} ${tempInfo.model}";
    identifier = tempInfo.androidId;
    version = tempInfo.version.codename;
  } else if (Platform.isIOS) {
    final tempInfo = await deviceInfoPlugin.iosInfo;
    name = "${tempInfo.name} ${tempInfo.model}";
    identifier = tempInfo.identifierForVendor;
    version = tempInfo.systemVersion;
  }
  return DeviceInfo(name, identifier, version);
}

bool isEmailValid(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

void removeFocus(){
  FocusManager.instance.primaryFocus?.unfocus();
}