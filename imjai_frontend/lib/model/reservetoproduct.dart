import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/widget/listorderwidget.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:mamaimakhrap/model/courseRound.dart';
// import 'package:mamaimakhrap/model/enrollUser.dart';

part 'reservetoproduct.g.dart';

@JsonSerializable()
class reserveToProduct {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'reserved_product')
  final mainProduct? reserved_product;

  reserveToProduct({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.reserved_product,
    // this.courseRound,
    // this.enrollUser
  });

  factory reserveToProduct.fromJson(Map<String, dynamic> json) =>
      _$reserveToProductFromJson(json);

  Map<String, dynamic> toJson() => _$reserveToProductToJson(this);

  // static map(ListOrderWidget Function(dynamic e) param0) {}
}
