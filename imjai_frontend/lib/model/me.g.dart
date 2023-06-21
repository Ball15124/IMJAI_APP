// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

meProfile _$meProfileFromJson(Map<String, dynamic> json) => meProfile(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      phone_number: json['phone_number'] as String,
      profile_url: json['profile_url'] as String,
      birthdate: json['birthdate'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      location_latitude: json['location_latitude'] as String,
      location_longtitude:
          DateTime.parse(json['location_longtitude'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$meProfileToJson(meProfile instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'phone_number': instance.phone_number,
      'profile_url': instance.profile_url,
      'birthdate': instance.birthdate,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'location_latitude': instance.location_latitude,
      'location_longtitude': instance.location_longtitude.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
