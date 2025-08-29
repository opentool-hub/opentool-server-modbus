import 'package:modbus_tool/modbus_tool.dart';
import 'package:opentool_dart/opentool_dart.dart';
import '../bin/opentool_server_modbus.dart';

Future<void> main() async {
  Client client = OpenToolClient(port: TOOL_PORT, apiKey: "bb31b6a6-1fda-4214-8cd6-b1403842070c");

  // Check Version
  Version version = await client.version();
  print(version.toJson());

  // Call Tool
  Map<String, dynamic> arguments = SerialConfig(type: ServerType.RTU, port: "COM1").toJson();
  FunctionCall functionCall = FunctionCall(id: "callId-0", name: "OpenSerial", arguments: arguments);
  ToolReturn toolReturn = await client.call(functionCall);
  print(toolReturn.toJson());

  // Load OpenTool
  OpenTool? openTool = await client.load();
  print(openTool?.toJson());
}