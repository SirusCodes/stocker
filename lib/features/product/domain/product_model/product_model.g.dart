// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      name: json['name'] as String,
      costPrice: (json['costPrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      color: const ColorSerializer().fromJson(json['color'] as int),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'costPrice': instance.costPrice,
      'sellingPrice': instance.sellingPrice,
      'quantity': instance.quantity,
      'color': const ColorSerializer().toJson(instance.color),
    };
