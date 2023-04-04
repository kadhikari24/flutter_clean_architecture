import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/register_request.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return _repository.register(RegisterRequest(
        email: input.email,
        password: input.password,
        countryCode: input.countryCode,
        phoneNumber: input.phoneNumber,
        profilePicture: input.profilePicture,
        userName: input.userName));
  }
}

class RegisterUseCaseInput {
  final String email;
  final String password;
  final String profilePicture;
  final String countryCode;
  final String phoneNumber;
  final String userName;

  RegisterUseCaseInput(
      {required this.password,
      required this.profilePicture,
      required this.countryCode,
      required this.phoneNumber,
      required this.userName,
      required this.email});
}
