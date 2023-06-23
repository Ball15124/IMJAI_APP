import 'package:json_annotation/json_annotation.dart';

part 'me.g.dart';

@JsonSerializable()
class meProfile {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: "phone_number")
  final String? phone_number;

  @JsonKey(name: "profile_url")
  final String? profile_url;

  @JsonKey(name: "birthdate")
  final String? birthdate;

  @JsonKey(name: "firstname")
  final String? firstname;

  @JsonKey(name: "lastname")
  final String? lastname;

  @JsonKey(name: "location_latitude")
  final String? location_latitude;

  @JsonKey(name: "location_longtitude")
  final String? location_longtitude;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  meProfile(
      {required this.id,
      required this.email,
      required this.username,
      required this.phone_number,
      required this.profile_url,
      required this.birthdate,
      required this.firstname,
      required this.lastname,
      required this.location_latitude,
      required this.location_longtitude,
      required this.updatedAt});

  factory meProfile.fromJson(Map<String, dynamic> json) =>
      _$meProfileFromJson(json);

  Map<String, dynamic> toJson() => _$meProfileToJson(this);
}
