import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

class ServerType {
  static const String TCP = "tcp";
  static const String UDP = "udp";
  static const String RTU = "rtu";
  static const String ASCII = "ascii";
}

class DataType {
  static const String BOOL = "bool";
  static const String INT16 = "int16";
  static const String INT32 = "int32";
  static const String UINT16 = "uint16";
  static const String UINT32 = "uint32";
  static const String STRING = "string";
}

class ElementType {
  static const String DISCRETE_INPUT = "discreteInput";
  static const String COIL = "coil";
  static const String INPUT_REGISTER = "inputRegister";
  static const String HOLDING_REGISTER = "holdingRegister";
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class NetConfig {
  String type; // 'tcp' or 'udp'
  String url;
  int port;
  int unitId; // Default unit ID 1

  NetConfig({required this.type, required this.url, this.port = 502, this.unitId = 1});

  factory NetConfig.fromJson(Map<String, dynamic> json) => _$NetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$NetConfigToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SerialConfig {
  String type; // 'rtu' or 'ascii'
  String port;
  int baudRate;
  int unitId; // Default unitID 1

  SerialConfig({required this.type, required this.port, this.baudRate = 9600, this.unitId = 1});

  factory SerialConfig.fromJson(Map<String, dynamic> json) => _$SerialConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SerialConfigToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ModbusElementParams {
  String name;
  String description;
  String elementType;
  int address;
  int? byteCount;
  dynamic value;
  String dataType;
  String uom;
  double multiplier;

  ModbusElementParams({
    required this.name,
    required this.description,
    required this.elementType,
    required this.address,
    this.byteCount,
    this.value,
    required this.dataType,
    this.uom = "",
    this.multiplier = 1
  });

  factory ModbusElementParams.fromJson(Map<String, dynamic> json) => _$ModbusElementParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ModbusElementParamsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false, createFactory: false)
class OperateSuccessfully{
  late String message;

  OperateSuccessfully({required String operation}) {
    message = "$operation successfully";
  }

  Map<String, dynamic> toJson() => _$OperateSuccessfullyToJson(this);
}
