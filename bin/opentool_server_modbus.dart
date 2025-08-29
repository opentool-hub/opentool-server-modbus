import 'dart:io';
import 'package:args/args.dart';
import 'package:modbus_tool/modbus_tool.dart';
import 'package:opentool_dart/opentool_dart.dart';

/// The command-line format follows [OpenTool Server Command-Line Interface Guidelines](https://github.com/opentool-hub/opentool-spec/blob/master/opentool-server-cli-guidelines-en.md).

const String TOOL_NAME = "MODBUS";
const String CMD = "modbus";
String defaultVersion = "1.0.0";
const int TOOL_PORT = 9642;

void main(List<String> arguments) async {
  final parser = ArgParser();

  parser.addFlag('help', abbr: 'h', negatable: false, help: 'Show help information');

  // --- start ---
  parser.addCommand('start', ArgParser()
    ..addOption('version', abbr: 'v', help: 'Version, Default: $defaultVersion')
    ..addOption('toolPort', abbr: 't', help: 'OpenTool Server Port, Default: $TOOL_PORT')
    ..addMultiOption('apiKeys', abbr: 'k', help: 'API Keys, allow array, as: --apiKeys KEY_A --apiKeys KEY_B')
  );

  // Handle parsing
  try {

    ArgResults results = parser.parse(arguments);

    if (results['help'] == true) {
      _printHelp(parser);
      exit(0);
    }

    final command = results.command;
    if (command == null) {
      await startModbusTool(version: defaultVersion, port: TOOL_PORT);
    } else {
      final cmdName = command.name;
      switch (cmdName) {
        case 'start':
          String? version = command['version'];
          if(version != null) defaultVersion = version;
          else version = defaultVersion;
          final toolPort = command['toolPort'] == null? TOOL_PORT : int.parse(command['toolPort']);
          final apiKeys = command['apiKeys'] as List<String>?;
          await startModbusTool(version: version, port: toolPort, apiKeys: apiKeys);
          break;

        default:
          print('Unknown command: $cmdName\n');
          _printHelp(parser);
          exit(1);
      }
    }
  } catch (e) {
    print('❌ Error: $e\n');
    _printHelp(parser);
    exit(64); // standard usage error
  }
}

void _printHelp(ArgParser parser) {
  print('$TOOL_NAME OpenTool Server CLI ($defaultVersion) - OpenTool Server implement by $TOOL_NAME.\n');
  print('Usage: $CMD <command> [options]\n');

  print('Available commands:\n');
  for (final entry in parser.commands.entries) {
    final name = entry.key;
    final usage = entry.value.usage.trimRight();
    print('Command: $name');
    print(usage.split('\n').map((line) => '  $line').join('\n'));
    print('');
  }

  print('Global options:\n');
  print(parser.usage);
}

Future<void> startModbusTool({required String version, required int port, List<String>? apiKeys}) async {
  Tool tool = ModbusTool();
  Server server = OpenToolServer(tool, version, port: port, apiKeys: apiKeys);
  await server.start();
}