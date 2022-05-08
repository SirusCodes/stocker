import 'package:equatable/equatable.dart';

class WorkerModel extends Equatable {
  final String name, email, id;

  const WorkerModel({
    required this.name,
    required this.email,
    required this.id,
  });

  @override
  List<Object?> get props => [name, email, id];
}
