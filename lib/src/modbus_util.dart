import 'dart:async';
import 'package:modbus_client_serial/modbus_client_serial.dart';
import 'package:modbus_client/modbus_client.dart';

import 'model.dart';

class ModbusResponse {
  int statusCode;
  String value;
  String message;
  ModbusResponse({required this.statusCode, required this.value, required this.message});

  Map<String, dynamic> toJson() => {'statusCode': statusCode, 'value': value, 'message': message};
}

Future<ModbusResponse> read(ModbusClient modbusClient, ModbusElementParams modbusElementParams) async {
  ModbusElement modbusElement = buildModbusElement(modbusElementParams);
  ModbusElementRequest modbusElementRequest = modbusElement.getReadRequest();
  ModbusResponseCode modbusResponseCode = await modbusClient.send(modbusElementRequest);
  int statusCode = modbusResponseCode.code;
  String message = modbusResponseCode.name;
  if (statusCode != 0x00) {
    /// If read error, return error info.
    return ModbusResponse(statusCode: statusCode, value: "", message: message);
  }
  dynamic value = modbusElement.value;
  String readValue = encodeModbusValue(value, modbusElement.type);
  return ModbusResponse(statusCode: statusCode, value: readValue, message: message);
}

Future<ModbusResponse> write(ModbusClient modbusClient, ModbusElementParams modbusElementParams) async {
  ModbusElement modbusElement = buildModbusElement(modbusElementParams);
  dynamic writeValue = parseModbusValue(modbusElementParams.value, modbusElementParams.dataType);
  ModbusElementRequest modbusElementRequest = modbusElement.getWriteRequest(writeValue);
  ModbusResponseCode modbusResponseCode = await modbusClient.send(modbusElementRequest);
  int statusCode = modbusResponseCode.code;
  String message = modbusResponseCode.name;
  if (statusCode != 0x00) {
    /// If read error, return error info.
    return ModbusResponse(statusCode: statusCode, value: "", message: message);
  }
  return ModbusResponse(statusCode: statusCode, value: writeValue, message: message);
}

ModbusElement buildModbusElement(ModbusElementParams modbusElementParams, {Function(ModbusElement)? onUpdate}) {
  ModbusElementType modbusElementType = convertToModbusElementType(modbusElementParams.elementType);
  switch (modbusElementParams.dataType) {
    case DataType.BOOL:
      return ModbusBitElement(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        type: modbusElementType,
        onUpdate: onUpdate
      );
    case DataType.INT16:
      return ModbusInt16Register(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        type: modbusElementType,
        onUpdate: onUpdate,
        uom: modbusElementParams.uom,
        multiplier: modbusElementParams.multiplier
      );
    case DataType.INT32:
      return ModbusInt32Register(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        type: modbusElementType,
        onUpdate: onUpdate,
        uom: modbusElementParams.uom,
        multiplier: modbusElementParams.multiplier
      );
    case DataType.UINT16:
      return ModbusUint16Register(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        type: modbusElementType,
        onUpdate: onUpdate,
        uom: modbusElementParams.uom,
        multiplier: modbusElementParams.multiplier
      );
    case DataType.UINT32:
      return ModbusUint32Register(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        type: modbusElementType,
        onUpdate: onUpdate,
        uom: modbusElementParams.uom,
        multiplier: modbusElementParams.multiplier
      );
    default :
      return ModbusBytesRegister(
        name: modbusElementParams.name,
        description: modbusElementParams.description,
        address: modbusElementParams.address,
        byteCount: modbusElementParams.byteCount!,
        type: modbusElementType,
        onUpdate: onUpdate
      );
  }
}

SerialBaudRate convertToSerialBaudRate(int number) {
  return SerialBaudRate.values.firstWhere(
    (e) => e.toString() == 'SerialBaudRate.b$number',
    orElse: () => throw ArgumentError('Unrecognized enum value: $number')
  );
}

ModbusElementType convertToModbusElementType(String elementType) {
  if (elementType == ElementType.DISCRETE_INPUT) {
    return ModbusElementType.discreteInput;
  } else if (elementType == ElementType.COIL) {
    return ModbusElementType.coil;
  } else if (elementType == ElementType.INPUT_REGISTER) {
    return ModbusElementType.inputRegister;
  } else if (elementType == ElementType.HOLDING_REGISTER) {
    return ModbusElementType.holdingRegister;
  } else {
    throw ArgumentError('Unrecognized element type: $elementType');
  }
}

dynamic parseModbusValue(String value, String modbusDataType) {
  switch (modbusDataType) {
    case "int8":
      return int.parse(value).toSigned(8);
    case "uint8":
      return int.parse(value).toUnsigned(8);
    case "int16":
      return int.parse(value).toSigned(16);
    case "uint16":
      return int.parse(value).toUnsigned(16);
    case "int32":
      return int.parse(value).toSigned(32);
    case "uint32":
      return int.parse(value).toUnsigned(32);
    case "float32":
    case "float64":
      return double.parse(value);
    case "string":
      return value;
    case "bool":
      return value.toLowerCase() == 'true' || value == '1';
    default:
      throw ArgumentError("Unsupported modbusDataType: $modbusDataType");
  }
}

String encodeModbusValue(dynamic value, ModbusElementType elementType) {
  if (value == null) return "";

  if (elementType.isRegister) {
    if (value is num || value is String) {
      return value.toString();
    } else {
      throw ArgumentError("Invalid value type for register: ${value.runtimeType}");
    }
  } else if (elementType.isBit) {
    if (value is bool) {
      return value ? "true" : "false";
    } else if (value is int) {
      return (value != 0) ? "true" : "false";
    } else if (value is String) {
      return (value.toLowerCase() == "true" || value == "1") ? "true" : "false";
    } else {
      throw ArgumentError("Invalid value type for bit: ${value.runtimeType}");
    }
  }

  throw ArgumentError("Unknown element type");
}