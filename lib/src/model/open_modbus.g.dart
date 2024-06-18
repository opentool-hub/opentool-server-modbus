// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_modbus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenModbus _$OpenModbusFromJson(Map<String, dynamic> json) => OpenModbus(
      openmodbus: json['openmodbus'] as String,
      info: Info.fromJson(json['info'] as Map<String, dynamic>),
      server: Server.fromJson(json['server'] as Map<String, dynamic>),
      functions: (json['functions'] as List<dynamic>)
          .map((e) => FunctionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpenModbusToJson(OpenModbus instance) =>
    <String, dynamic>{
      'openmodbus': instance.openmodbus,
      'info': instance.info,
      'server': instance.server,
      'functions': instance.functions,
    };
