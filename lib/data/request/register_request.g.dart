// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      countryCode: json['countryCode'] as String,
      userName: json['userName'] as String,
      profilePicture: json['profilePicture'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'profilePicture': instance.profilePicture,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
    };
