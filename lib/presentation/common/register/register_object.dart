import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_object.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  const factory RegisterObject(
      {required String password,
      required String profilePicture,
      required String phoneNumber,
      required String countryCode,
      required String userName,
      required String email}) = _RegisterObject;
}
