import 'package:complete_advanced_flutter/app/constants.dart';
import 'package:complete_advanced_flutter/data/responses/forgot_password_response.dart';
import 'package:complete_advanced_flutter/data/responses/home/home.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:complete_advanced_flutter/data/responses/store_detail/store_detail.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customer/login')
  Future<AuthenticationResponse> login(
      {@Field('email') required String email,
      @Field('password') required String password,
      @Field('imei') required String imei,
      @Field('deviceType') required String deviceType});

  @POST('/customer/forgotPassword')
  Future<ForgotPasswordResponse> forgotPassword(
      {@Field('email') required String email});

  @POST('/customer/register')
  Future<AuthenticationResponse> register(
      {@Field('email') required String email,
      @Field('password') required String password,
      @Field('profilePicture') required String profilePicture,
      @Field('phoneNumber') required String phoneNumber,
      @Field('countryCode') required String countryCode,
      @Field('userName') required String userName});

  @GET('/customer/home')
  Future<HomeResponse> getHome();

  @GET('/storeDetail/1')
  Future<StoreDetailResponse> getStoreDetails();
}
