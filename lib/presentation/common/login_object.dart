import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_object.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  const factory LoginObject({required String email, required String password}) = _LoginObject;
}