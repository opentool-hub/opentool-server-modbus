import 'package:json_annotation/json_annotation.dart';

part 'exception.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false, createFactory: false)
class ModbusNotInitException implements Exception {
  final int code = 404;
  final String message = 'Modbus Client NOT initialized';

  Map<String, dynamic> toJson() => _$ModbusNotInitExceptionToJson(this);
}