import 'package:json_annotation/json_annotation.dart';
// import 'package:mamaimakhrap/model/courseRound.dart';
// import 'package:mamaimakhrap/model/enrollUser.dart';

part 'mainproduct.g.dart';

@JsonSerializable()
class mainProduct {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'picture_url')
  final String? picture_url;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'available_time')
  final String? available_time;

  @JsonKey(name: 'category_id')
  final int? category_id;

  @JsonKey(name: 'location_latitude')
  final String? location_latitude;

  @JsonKey(name: 'location_longtitude')
  final String? location_longtitude;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'is_reserved')
  final bool? is_reserved;

  //  @JsonKey(name: 'available_time')
  // final String? available_time;

  mainProduct({
    required this.id,
    required this.userId,
    required this.name,
    required this.picture_url,
    required this.description,
    required this.available_time,
    required this.category_id,
    required this.location_latitude,
    required this.location_longtitude,
    required this.status,
    required this.is_reserved,
    // this.courseRound,
    // this.enrollUser
  });

  factory mainProduct.fromJson(Map<String, dynamic> json) =>
      _$mainProductFromJson(json);

  Map<String, dynamic> toJson() => _$mainProductToJson(this);
}