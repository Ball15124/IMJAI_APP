// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

mainProduct _$mainProductFromJson(Map<String, dynamic> json) => mainProduct(
      id: json['id'] as int,
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      picture_url: json['picture_url'] as String?,
      description: json['description'] as String?,
      available_time: json['available_time'] as String?,
      category_id: json['category_id'] as int?,
      location_latitude: json['location_latitude'] as String?,
      location_longtitude: json['location_longtitude'] as String?,
      status: json['status'] as int?,
      is_reserved: json['is_reserved'] as bool?,
    );

Map<String, dynamic> _$mainProductToJson(mainProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'picture_url': instance.picture_url,
      'description': instance.description,
      'available_time': instance.available_time,
      'category_id': instance.category_id,
      'location_latitude': instance.location_latitude,
      'location_longtitude': instance.location_longtitude,
      'status': instance.status,
      'is_reserved': instance.is_reserved,
    };
