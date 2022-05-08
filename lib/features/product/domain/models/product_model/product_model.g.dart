// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      color: const ColorSerializer().fromJson(json['color'] as int),
      categoryId: json['categoryId'] as String,
      name: json['name'] as String,
      costPrice: (json['costPrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'costPrice': instance.costPrice,
      'sellingPrice': instance.sellingPrice,
      'quantity': instance.quantity,
      'color': const ColorSerializer().toJson(instance.color),
    };
