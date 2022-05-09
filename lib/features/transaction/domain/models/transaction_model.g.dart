// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      customerId: json['customerId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num).toDouble(),
      transactionType:
          $enumDecode(_$TransactionTypeEnumMap, json['transactionType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'customerId': instance.customerId,
      'quantity': instance.quantity,
      'sellingPrice': instance.sellingPrice,
      'costPrice': instance.costPrice,
      'timestamp': instance.timestamp.toIso8601String(),
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
    };

const _$TransactionTypeEnumMap = {
  TransactionType.sell: 'sell',
  TransactionType.buy: 'buy',
};
