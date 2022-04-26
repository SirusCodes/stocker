import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../utils/color_serializer.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String name;
  final double costPrice, sellingPrice, quantity;

  @ColorSerializer()
  final Color color;

  const ProductModel({
    required this.name,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
    required this.color,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        costPrice,
        sellingPrice,
        quantity,
        color,
      ];
}
