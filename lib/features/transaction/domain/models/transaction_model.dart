import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../enums/enums.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Equatable {
  final String productId, productName;
  final double quantity, sellingPrice, costPrice;
  final DateTime timestamp;
  final TransactionType transactionType;

  const TransactionModel({
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
        productId,
        productName,
        quantity,
        sellingPrice,
        costPrice,
        transactionType,
        timestamp,
      ];
}
