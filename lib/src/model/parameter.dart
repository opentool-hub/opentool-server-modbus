import 'package:json_annotation/json_annotation.dart';

import 'function_model.dart';

part 'parameter.g.dart';

@JsonSerializable()
class Parameter {
  late String name;
  String? description;
  late DataType type;
  double multiplier;
  String? uom;

  Parameter({required this.name, this.description, required this.type, this.multiplier = 1, this.uom});

  factory Parameter.fromJson(Map<String, dynamic> json) => _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}