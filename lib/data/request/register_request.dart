import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String profilePicture;
  final String countryCode;
  final String phoneNumber;
  final String userName;

  RegisterRequest(
      {required this.email,
      required this.password,
      required this.phoneNumber,
      required this.countryCode,
      required this.userName,
      required this.profilePicture});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

