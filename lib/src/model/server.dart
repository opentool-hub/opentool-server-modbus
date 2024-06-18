import 'package:json_annotation/json_annotation.dart';

part 'server.g.dart';

enum ServerType {
  tcp, udp,   // via NetConfig
  rtu, ascii  // via SerialConfig
}

@JsonSerializable()
class Server {
  late ServerType type;
  late dynamic config;

  Server({required this.type, this.config});

  factory Server.fromJson(Map<String, dynamic> json) {
    dynamic configObj;
    if(json['type'].toString().toLowerCase() == ServerType.tcp.name.toLowerCase() || json['type'].toString().toLowerCase() == ServerType.udp.name.toLowerCase() ) {
      configObj = NetConfig.fromJson(json['config']);
    } else {
      configObj = SerialConfig.fromJson(json['config']);
    }

    return Server(
      type: $enumDecode(_$ServerTypeEnumMap, json['type']),
      config: configObj,
    );
  }

  Map<String, dynamic> toJson() => _$ServerToJson(this);

}

@JsonSerializable()
class NetConfig {
  late String url;
  late int port;

  NetConfig({required this.url, this.port = 502});

  factory NetConfig.fromJson(Map<String, dynamic> json) => _$NetConfigFromJson(json);

  Map<String, dynamic> toJson() => _$NetConfigToJson(this);
}

enum BaudRateType {
  b200,
  b300,
  b600,
  b1200,
  b1800,
  b2400,
  b4800,
  b9600,
  b19200,
  b28800,
  b38400,
  b57600,
  b76800,
  b115200,
  b230400,
  b460800,
  b576000,
  b921600
}

@JsonSerializable()
class SerialConfig {
  late String port;

  @JsonKey(fromJson: _baudRateTypeFromJson, toJson: _baudRateTypeToJson)
  late BaudRateType baudRate;

  SerialConfig({required this.port, this.baudRate = BaudRateType.b9600});

  factory SerialConfig.fromJson(Map<String, dynamic> json) => _$SerialConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SerialConfigToJson(this);

}

BaudRateType _baudRateTypeFromJson(int number) {
  return BaudRateType.values.firstWhere(
          (e) => e.toString() == 'BaudRateType.b$number',
      orElse: () => throw ArgumentError('Unrecognized enum value: $number')
  );
}

int _baudRateTypeToJson(BaudRateType enumValue) {
  return int.parse(enumValue.toString().split('b')[1]);
}