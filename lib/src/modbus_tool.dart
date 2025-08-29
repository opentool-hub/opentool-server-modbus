import 'dart:async';
import 'package:modbus_client/modbus_client.dart';
import 'package:modbus_client_serial/modbus_client_serial.dart';
import 'package:modbus_client_tcp/modbus_client_tcp.dart';
import 'package:modbus_client_udp/modbus_client_udp.dart';
import 'package:opentool_dart/opentool_dart.dart';
import 'exception.dart';
import 'modbus_util.dart';
import 'model.dart';

class ModbusTool extends Tool {
  ModbusClient? modbusClient;

  @override
  Future<Map<String, dynamic>> call(String name, Map<String, dynamic>? arguments) async {
    try {
      if (name == "OpenNetwork" && arguments != null) {
        NetConfig netConfig = NetConfig.fromJson(arguments);
        if (netConfig.type == ServerType.TCP) {
          modbusClient = ModbusClientTcp(
              netConfig.url,
              serverPort: netConfig.port,
              unitId: netConfig.unitId
          );
        } else if (netConfig.type == ServerType.UDP) {
          modbusClient = ModbusClientUdp(
              netConfig.url,
              serverPort: netConfig.port,
              unitId: netConfig.unitId
          );
        }
        return OperateSuccessfully(operation: name).toJson();
      } else if (name == "OpenSerial" && arguments != null) {
        SerialConfig serialConfig = SerialConfig.fromJson(arguments);
        if (serialConfig.type == ServerType.RTU) {
          modbusClient = ModbusClientSerialRtu(
              portName: serialConfig.port,
              baudRate: convertToSerialBaudRate(serialConfig.baudRate),
              unitId: serialConfig.unitId
          );
        } else if (serialConfig.type == ServerType.ASCII) {
          modbusClient = ModbusClientSerialAscii(
              portName: serialConfig.port,
              baudRate: convertToSerialBaudRate(serialConfig.baudRate),
              unitId: serialConfig.unitId
          );
        }
        return OperateSuccessfully(operation: name).toJson();
      } else if (name == "Read" && arguments != null) {
        if (modbusClient != null) {
          ModbusElementParams modbusElementParams = ModbusElementParams.fromJson(arguments);
          ModbusResponse modbusResponse = await read(modbusClient!, modbusElementParams);
          return modbusResponse.toJson();
        }
        return ModbusNotInitException().toJson();
      } else if (name == "Write" && arguments != null) {
        if (modbusClient != null) {
          ModbusElementParams modbusElementParams = ModbusElementParams.fromJson(arguments);
          ModbusResponse modbusResponse = await write(modbusClient!, modbusElementParams);
          return modbusResponse.toJson();
        }
        return ModbusNotInitException().toJson();
      } else if (name == "Close") {
        modbusClient?.disconnect();
        return OperateSuccessfully(operation: name).toJson();
      } else {
        return FunctionNotSupportedException(functionName: name).toJson();
      }
    } catch(e) {
      return ToolBreakException(e.toString()).toJson();
    }
  }

  @override
  Future<OpenTool?> load() async {
    return OpenTool(
        opentool: "1.0.0",
        info: Info(title: "Modbus Tools", version: "1.0.0", description: "A tool for Modbus communication, including network and serial connecting, and read/write operate."),
        functions: [
          FunctionModel(name: "OpenNetwork", description: "Open Network Modbus connecting", parameters: [
            Parameter(name: "type", schema: Schema(type: "string", enum_: [ServerType.TCP, ServerType.UDP]), required: true),
            Parameter(name: "url", schema: Schema(type: "string"), required: true),
            Parameter(name: "port", schema: Schema(type: "integer"), required: false, description: "Default: 502"),
            Parameter(name: "unitId", schema: Schema(type: "integer"), required: false, description: "Value: 1–247, default: 1")
          ]),
          FunctionModel(name: "OpenSerial", description: "Open Serial Modbus connecting", parameters: [
            Parameter(name: "type", schema: Schema(type: "string", enum_: [ServerType.ASCII, ServerType.RTU]), required: true),
            Parameter(name: "port", schema: Schema(type: "integer"), required: true),
            Parameter(name: "baudRate", schema: Schema(type: "integer", enum_: [200, 300, 600, 1200, 1800, 2400, 4800, 9600, 19200, 28800, 38400, 57600, 76800, 115200, 230400, 460800, 576000, 921600]), required: false, description: "Default: 9600"),
            Parameter(name: "unitId", schema: Schema(type: "integer"), required: false, description: "Value: 1–247, default: 1")
          ]),
          FunctionModel(name: "Read", description: "Read date from modbus", parameters: [
            Parameter(name: "name", schema: Schema(type: "string"), required: true),
            Parameter(name: "description", schema: Schema(type: "string"), required: true),
            Parameter(name: "elementType", schema: Schema(type: "string", enum_: ["discreteInput", "coil", "inputRegister", "holdingRegister"]), required: true),
            Parameter(name: "address", schema: Schema(type: "integer"), required: true),
            Parameter(name: "byteCount", schema: Schema(type: "integer"), required: false),
            Parameter(name: "value", schema: Schema(type: "string"), required: false, description: "Data value, will be convert to the specified data type by dateType"),
            Parameter(name: "dataType", schema: Schema(type: "string", enum_: ["int8", "uint8", "int16", "uint16", "int32", "uint32", "float32", "float64", "string"]), required: true),
            Parameter(name: "uom", schema: Schema(type: "string"), required: false, description: 'Default: ""'),
            Parameter(name: "multiplier", schema: Schema(type: "number"), required: false, description: "Default: 1")
          ]),
          FunctionModel(name: "Write", description: "Write date to modbus", parameters: [
            Parameter(name: "name", schema: Schema(type: "string"), required: true),
            Parameter(name: "description", schema: Schema(type: "string"), required: true),
            Parameter(name: "elementType", schema: Schema(type: "string", enum_: ["discreteInput", "coil", "inputRegister", "holdingRegister"]), required: true),
            Parameter(name: "address", schema: Schema(type: "integer"), required: true),
            Parameter(name: "byteCount", schema: Schema(type: "integer"), required: false),
            Parameter(name: "value", schema: Schema(type: "string"), required: false),
            Parameter(name: "modbusDataType", schema: Schema(type: "string", enum_: ["int8", "uint8", "int16", "uint16", "int32", "uint32", "float32", "float64", "string"]), required: true),
            Parameter(name: "uom", schema: Schema(type: "string"), required: false, description: 'Default: ""'),
            Parameter(name: "multiplier", schema: Schema(type: "number"), required: false, description: "Default: 1")
          ]),
        ]
    );
  }
}