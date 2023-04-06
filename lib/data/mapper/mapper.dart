import 'package:complete_advanced_flutter/app/extension.dart';
import 'package:complete_advanced_flutter/data/responses/forgot_password_response.dart';
import 'package:complete_advanced_flutter/data/responses/home/home.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:complete_advanced_flutter/data/responses/store_detail/store_detail.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';
import 'package:complete_advanced_flutter/domain/model/home.dart';
import 'package:complete_advanced_flutter/domain/model/store_details.dart';

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

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        this?.id ?? zero, this?.title ?? empty, this?.image ?? empty);
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(this?.id ?? zero, this?.title ?? empty, this?.image ?? empty,
        this?.link ?? empty);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id ?? zero, this?.title ?? empty, this?.image ?? empty);
  }
}

extension HomeResponseMapper on HomeDataResponse? {
  HomeObject toDomain() {
    final services = this?.services?.map((e) => e.toDomain()).toList() ?? [];
    final banners = this?.banners?.map((e) => e.toDomain()).toList() ?? [];
    final stores = this?.stores?.map((e) => e.toDomain()).toList() ?? [];
    return HomeObject(HomeData(services, banners, stores));
  }
}

extension StoreDetailsResponseMapper on StoreDetailResponse? {
  StoreDetailsObject toDomain() {
    return StoreDetailsObject(
        title: this?.title ?? empty,
        id: this?.id ?? zero,
        image: this?.image ?? empty,
        about: this?.about ?? empty,
        services: this?.services ?? empty,
        details: this?.details ?? empty);
  }
}
