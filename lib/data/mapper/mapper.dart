import 'package:complete_advanced_flutter/app/extension.dart';
import 'package:complete_advanced_flutter/data/responses/forgot_password_response.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';

const empty = '';
const zero = 0;

extension CustomerResponseMapper on CustomersResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? empty,
        this?.name?.orEmpty() ?? empty,
        this?.numberOfNotification.orZero() ?? zero);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(this?.phone?.orEmpty() ?? empty,
        this?.link?.orEmpty() ?? empty, this?.email.orEmpty() ?? empty);
  }
}

extension AuthentationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgotPasswordMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(this?.support ?? empty);
  }
}