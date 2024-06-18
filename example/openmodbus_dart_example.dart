import 'package:openmodbus_dart/openmodbus_dart.dart';

import 'dart:io';

void main() async {
  List<String> jsonFileNameList = ["ascii-safe-system-example.json", "rtu-lights-example.json", "tcp-air-condition-example.json"];

  String currentWorkingDirectory = Directory.current.path;
  jsonFileNameList.forEach((jsonFileName) async {
    print("FILE_NAME: $jsonFileName");
    String jsonPath = "$currentWorkingDirectory/example/json/$jsonFileName";
    OpenModbusLoader openModbusLoader = OpenModbusLoader();
    OpenModbus openModbus = await openModbusLoader.loadFromFile(jsonPath);
    print("title: ${openModbus.info.title}");
  });
}
