import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/network/dio_factory.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/respository/repository_impl.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharePrefs = await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharePrefs);
  // app preference instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  final dio = await instance.get<DioFactory>().getDio();

  // dio factory instance
  instance.registerLazySingleton<Dio>(() => dio);

  //app service client instance
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(instance()));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //repository repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}


void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}
