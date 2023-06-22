// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservetoproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

reserveToProduct _$reserveToProductFromJson(Map<String, dynamic> json) =>
    reserveToProduct(
      id: json['id'] as int,
      userId: json['userId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      reserved_product: json['reserved_product'] == null
          ? null
          : mainProduct
              .fromJson(json['reserved_product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$reserveToProductToJson(reserveToProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'reserved_product': instance.reserved_product,
    };
