import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../utils/color_serializer.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final String name;

  @JsonKey(ignore: true)
  final String? id;
  final int productCount;

  @ColorSerializer()
  final Color color;

  const CategoryModel({
    this.id,
    required this.name,
    required this.color,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  List<Object?> get props => [id, name, productCount, color];

  CategoryModel copyWith({
    String? name,
    String? id,
    int? productCount,
    Color? color,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      id: id ?? this.id,
      productCount: productCount ?? this.productCount,
      color: color ?? this.color,
    );
  }
}
