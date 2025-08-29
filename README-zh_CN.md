# Modbus for OpenTool

[English](README.md) | 中文

OpenTool的Modbus客户端实现，运行opentool的请求来执行Modbus的操作

支持Modbus `TCP`/`UDP`/`ASCII`/`RTU`

## 构建

### Windows

```bash
dart pub get
dart compile exe bin/opentool_server_modbus.dart -o build/modbus.exe
```

### macOS / Linux

```bash
dart pub get
dart compile exe bin/opentool_server_modbus.dart -o build/modbus
```

## 示例

1. 拉起OpenTool Server，也即运行 `bin/opentool_server_modbus.dart`
2. 运行 `example/client.dart`