import 'package:json_annotation/json_annotation.dart';
import 'parameter.dart';
import 'result.dart';

part 'function_model.g.dart';

enum MethodType {
  read,
  write
}

/*
Coils 线圈: 开关量，可读可写
DiscreteInputs 输入离散量: 开关量，只读
InputRegisters 输入寄存器: 双byte寄存器，只读
HoldingRegisters 保持寄存器: 双byte寄存器，可读可写
 */
enum StorageType {
  coils,
  discreteInput,
  inputRegisters,
  holdingRegisters
}

// enum ModbusFunctionType {
//   readCoils,                      // 0x01
//   readDiscreteInputs,             // 0x02
//   readHoldingRegisters,           // 0x03
//   readInputRegisters,             // 0x04
//   writeSingleCoil,                // 0x05
//   writeSingleHoldingRegister,     // 0x06
//   writeMultipleCoils,             // 0x0F
//   writeMultipleHoldingRegisters   // 0x10
// }

enum DataType {
  bool,
  int16,
  int32,
  uint16,
  uint32,
  string
}

@JsonSerializable()
class FunctionModel {
  late String name;
  String? description;
  late int slaveId;
  late MethodType method;
  late StorageType storage;
  late int address;
  late int count;
  Parameter? parameter;
  Result? result;

  FunctionModel({
    required this.name,
    this.description,
    required this.slaveId,
    required this.method,
    required this.storage,
    required this.address,
    required this.count,
    this.parameter,
    this.result,
  });

  factory FunctionModel.fromJson(Map<String, dynamic> json) => _$FunctionModelFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionModelToJson(this);
}