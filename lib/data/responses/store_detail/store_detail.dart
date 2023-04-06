import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'store_detail.g.dart';

@JsonSerializable()
class StoreDetailResponse extends BaseResponse {
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'services')
  final String? services;
  @JsonKey(name: 'about')
  final String? about;

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);

  StoreDetailResponse(this.image, this.id, this.title, this.details, this.services, this.about);
}
