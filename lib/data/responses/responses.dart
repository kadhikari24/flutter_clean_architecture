import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomersResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "numberOfNotification")
  int? numberOfNotification;

  CustomersResponse(this.id, this.name, this.numberOfNotification);

  factory CustomersResponse.fromJson(Map<String,dynamic> json) {
   return _$CustomersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);

}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "link")
  String? link;

  @JsonKey(name: "email")
  String? email;

  ContactResponse(this.phone, this.link, this.email);

  factory ContactResponse.fromJson(Map<String,dynamic> json) {
    return _$ContactResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);

}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomersResponse? customer;

  @JsonKey(name: "contacts")
  ContactResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  factory AuthenticationResponse.fromJson(Map<String,dynamic> json){
    print('json contains $json');
    final response = _$AuthenticationResponseFromJson(json);
    return response;
  }

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
