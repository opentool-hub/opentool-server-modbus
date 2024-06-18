// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionModel _$FunctionModelFromJson(Map<String, dynamic> json) =>
    FunctionModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      slaveId: (json['slaveId'] as num).toInt(),
      method: $enumDecode(_$MethodTypeEnumMap, json['method']),
      storage: $enumDecode(_$StorageTypeEnumMap, json['storage']),
      address: (json['address'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      parameter: json['parameter'] == null
          ? null
          : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FunctionModelToJson(FunctionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'slaveId': instance.slaveId,
      'method': _$MethodTypeEnumMap[instance.method]!,
      'storage': _$StorageTypeEnumMap[instance.storage]!,
      'address': instance.address,
      'count': instance.count,
      'parameter': instance.parameter,
      'result': instance.result,
    };

const _$MethodTypeEnumMap = {
  MethodType.read: 'read',
  MethodType.write: 'write',
};

const _$StorageTypeEnumMap = {
  StorageType.coils: 'coils',
  StorageType.discreteInput: 'discreteInput',
  StorageType.inputRegisters: 'inputRegisters',
  StorageType.holdingRegisters: 'holdingRegisters',
};
