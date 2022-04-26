import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../utils/color_serializer.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String name;
  final int productCount;

  @ColorSerializer()
  final Color color;

  const CategoryModel({
    required this.name,
    required this.color,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
