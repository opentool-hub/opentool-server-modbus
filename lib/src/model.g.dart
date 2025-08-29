// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetConfig _$NetConfigFromJson(Map<String, dynamic> json) => NetConfig(
  type: json['type'] as String,
  url: json['url'] as String,
  port: (json['port'] as num?)?.toInt() ?? 502,
  unitId: (json['unitId'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$NetConfigToJson(NetConfig instance) => <String, dynamic>{
  'type': instance.type,
  'url': instance.url,
  'port': instance.port,
  'unitId': instance.unitId,
};

SerialConfig _$SerialConfigFromJson(Map<String, dynamic> json) => SerialConfig(
  type: json['type'] as String,
  port: json['port'] as String,
  baudRate: (json['baudRate'] as num?)?.toInt() ?? 9600,
  unitId: (json['unitId'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$SerialConfigToJson(SerialConfig instance) =>
    <String, dynamic>{
      'type': instance.type,
      'port': instance.port,
      'baudRate': instance.baudRate,
      'unitId': instance.unitId,
    };

ModbusElementParams _$ModbusElementParamsFromJson(Map<String, dynamic> json) =>
    ModbusElementParams(
      name: json['name'] as String,
      description: json['description'] as String,
      elementType: json['elementType'] as String,
      address: (json['address'] as num).toInt(),
      byteCount: (json['byteCount'] as num?)?.toInt(),
      value: json['value'],
      dataType: json['dataType'] as String,
      uom: json['uom'] as String? ?? "",
      multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$ModbusElementParamsToJson(
  ModbusElementParams instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'elementType': instance.elementType,
  'address': instance.address,
  'byteCount': ?instance.byteCount,
  'value': ?instance.value,
  'dataType': instance.dataType,
  'uom': instance.uom,
  'multiplier': instance.multiplier,
};

Map<String, dynamic> _$OperateSuccessfullyToJson(
  OperateSuccessfully instance,
) => <String, dynamic>{'message': instance.message};
