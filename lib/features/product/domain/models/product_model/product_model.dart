import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../utils/color_serializer.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String name, categoryId;
  final String? id;
  final double costPrice, sellingPrice, quantity;

  @NullableColorSerializer()
  final Color? color;

  const ProductModel({
    this.id,
    this.color,
    required this.categoryId,
    required this.name,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        categoryId,
        name,
        costPrice,
        sellingPrice,
        quantity,
        color,
      ];
}
