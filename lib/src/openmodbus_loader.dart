import 'dart:convert';
import 'dart:io';

import '/src/model/open_modbus.dart';

class OpenModbusLoader {
  Future<OpenModbus> load(String jsonString) async {
    Map<String, dynamic> openModbusMap = jsonDecode(jsonString);
    OpenModbus openModbus = OpenModbus.fromJson(openModbusMap);
    return openModbus;
  }

  Future<OpenModbus> loadFromFile(String jsonPath) async {
    File file = File(jsonPath);
    String jsonString = await file.readAsString();
    return load(jsonString);
  }
}