// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String?,
      color: const NullableColorSerializer().fromJson(json['color'] as int?),
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
      'id': instance.id,
      'costPrice': instance.costPrice,
      'sellingPrice': instance.sellingPrice,
      'quantity': instance.quantity,
      'color': const NullableColorSerializer().toJson(instance.color),
    };
