import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable {
  final String name, email, phone;
  @JsonKey(ignore: true)
  final String? id;

  const CustomerModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [name, email, phone];

  CustomerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
