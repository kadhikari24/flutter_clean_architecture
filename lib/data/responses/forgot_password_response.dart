import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
