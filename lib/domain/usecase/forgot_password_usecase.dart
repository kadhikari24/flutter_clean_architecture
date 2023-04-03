import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, ForgotPassword> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassword>> execute(email) async {
    return _repository.resetPassword(email);
  }
}
