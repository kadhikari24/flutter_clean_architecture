import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/request/login_request.dart';
import 'package:complete_advanced_flutter/data/request/register_request.dart';
import 'package:complete_advanced_flutter/data/responses/forgot_password_response.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest request);

  Future<ForgotPasswordResponse> resetPassword(String request);

  Future<AuthenticationResponse> register(RegisterRequest request);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest request) {
    final response =  _appServiceClient.login(
        email: request.email,
        deviceType: "",//request.deviceType,
        imei: "",//request.imei,
        password: request.password);
    return response;
  }

  @override
  Future<ForgotPasswordResponse> resetPassword(String request) {
    return _appServiceClient.forgotPassword(email: request);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest request) {
    return _appServiceClient.register(  
      email: request.email,
      password: request.password,
      profilePicture: "" ,//request.profilePicture,
      countryCode: request.countryCode,
      phoneNumber: request.phoneNumber,
      userName: request.userName,);
  }
}
