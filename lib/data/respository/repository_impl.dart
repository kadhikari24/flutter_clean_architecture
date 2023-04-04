import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/request/login_request.dart';
import 'package:complete_advanced_flutter/data/request/register_request.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> resetPassword(String request) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.resetPassword(request);
        if (response.status == ApiInternalStatus.success) {
         return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest request) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
