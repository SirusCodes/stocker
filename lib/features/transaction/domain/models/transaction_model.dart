import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../enums/enums.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Equatable {
  @JsonKey(ignore: true)
  final String? id;
  final String productId, productName, customerId;
  final double quantity, sellingPrice, costPrice;
  final DateTime timestamp;
  final TransactionType transactionType;

  const TransactionModel({
    this.id,
    required this.customerId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.sellingPrice,
    required this.costPrice,
    required this.transactionType,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  @override
  List<Object?> get props => [
        customerId,
        id,
        productId,
        productName,
        quantity,
        sellingPrice,
        costPrice,
        transactionType,
        timestamp,
      ];

  TransactionModel copyWith({
    String? id,
    String? customerId,
    String? productId,
    String? productName,
    double? quantity,
    double? sellingPrice,
    double? costPrice,
    DateTime? timestamp,
    TransactionType? transactionType,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      productName: productName ?? this.productName,
      costPrice: costPrice ?? this.costPrice,
      timestamp: timestamp ?? this.timestamp,
      transactionType: transactionType ?? this.transactionType,
    );
  }
}
