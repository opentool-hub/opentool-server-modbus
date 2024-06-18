import 'package:json_annotation/json_annotation.dart';

import 'function_model.dart';
import 'server.dart';
import 'info.dart';

part 'open_modbus.g.dart';

@JsonSerializable()
class OpenModbus {
  late String openmodbus;
  late Info info;
  late Server server;
  late List<FunctionModel> functions;

  OpenModbus({
    required this.openmodbus,
    required this.info,
    required this.server,
    required this.functions,
  });

  factory OpenModbus.fromJson(Map<String, dynamic> json) => _$OpenModbusFromJson(json);

  Map<String, dynamic> toJson() => _$OpenModbusToJson(this);
}