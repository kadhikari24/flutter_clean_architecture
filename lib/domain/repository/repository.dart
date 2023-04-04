import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/login_request.dart';
import 'package:complete_advanced_flutter/data/request/register_request.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPassword>> resetPassword(String request);
  Future<Either<Failure, Authentication>> register(RegisterRequest request);
}
