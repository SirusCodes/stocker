import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../utils/color_serializer.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String name, categoryId;
  @JsonKey(ignore: true)
  final String? id;
  final double costPrice, sellingPrice, quantity;

  @ColorSerializer()
  final Color color;

  const ProductModel({
    this.id,
    required this.color,
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

  ProductModel copyWith({
    String? name,
    String? categoryId,
    String? id,
    double? costPrice,
    double? sellingPrice,
    double? quantity,
    Color? color,
  }) {
    return ProductModel(
      name: name ?? this.name,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      categoryId: categoryId ?? this.categoryId,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      costPrice: costPrice ?? this.costPrice,
    );
  }
}
