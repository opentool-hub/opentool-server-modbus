# Modbus for OpenTool

English | [中文](README-zh_CN.md)

An OpenTool-compatible Modbus client implementation that handles OpenTool requests to perform Modbus operations.

Supports Modbus `TCP` / `UDP` / `ASCII` / `RTU`.

## Build

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

## Example

1. Launch the OpenTool Server by running `bin/opentool_server_modbus.dart`
2. Run `example/client.dart`
