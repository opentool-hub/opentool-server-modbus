import 'package:json_annotation/json_annotation.dart';

import 'function_model.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  late String name;
  String? description;
  late DataType type;
  double multiplier;
  String? uom;

  Result({required this.name, this.description, required this.type, this.multiplier = 1, this.uom});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

}