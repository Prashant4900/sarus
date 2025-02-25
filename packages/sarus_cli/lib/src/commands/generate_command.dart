// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// {@template generate_prisma_command}
///
/// `sarus_cli generate-prisma`
/// A [Command] to generate Prisma clients for root and module schemas
/// {@endtemplate}
class GeneratePrismaCommand extends Command<int> {
  /// {@macro generate_prisma_command}
  GeneratePrismaCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'schema',
        help: 'Custom path to your Prisma schema',
      )
      ..addFlag(
        'watch',
        help: 'Watch the Prisma schema and rerun after a change',
        negatable: false,
      )
      ..addMultiOption(
        'generator',
        help: 'Generator to use (may be provided multiple times)',
      )
      ..addFlag(
        'no-engine',
        help: 'Generate a client for use with Accelerate only',
        negatable: false,
      )
      ..addFlag(
        'no-hints',
        help: 'Hides the hint messages but still outputs errors and warnings',
        negatable: false,
      )
      ..addFlag(
        'allow-no-models',
        help: 'Allow generating a client without models',
        negatable: false,
      )
      ..addFlag(
        'sql',
        help: 'Generate typed sql module',
        negatable: false,
      );
  }

  @override
  String get description =>
      'Generate Prisma clients for root and module schemas.';

  @override
  String get name => 'generate-prisma';

  final Logger _logger;

  @override
  Future<int> run() async {
    // Check if running from project root
    if (!await _checkProjectRoot()) {
      _logger
          .err('Error: Must run this command from the project root directory.');
      return ExitCode.usage.code;
    }

    final specifiedSchema = argResults?['schema'] as String?;

    if (specifiedSchema != null) {
      // Generate for specific schema
      return _generateForSchema(specifiedSchema);
    } else {
      // Generate for root and all modules
      await _generateRootPrismaSchemas();
      await _generateModulePrismaSchemas();
      return ExitCode.success.code;
    }
  }

  /// Checks if the command is being run from the project root
  Future<bool> _checkProjectRoot() async {
    final file = File('sarus.yml');
    return file.existsSync();
  }

  /// Builds the command arguments based on provided flags
  List<String> _buildCommandArgs() {
    final args = ['prisma', 'generate'];

    // Add optional flags
    if (argResults?['watch'] as bool? ?? false) {
      args.add('--watch');
    }

    if (argResults?['no-engine'] as bool? ?? false) {
      args.add('--no-engine');
    }

    if (argResults?['no-hints'] as bool? ?? false) {
      args.add('--no-hints');
    }

    if (argResults?['allow-no-models'] as bool? ?? false) {
      args.add('--allow-no-models');
    }

    if (argResults?['sql'] as bool? ?? false) {
      args.add('--sql');
    }

    // Add generators if specified
    final generators = argResults?['generator'] as List<String>? ?? [];
    for (final generator in generators) {
      args.addAll(['--generator', generator]);
    }

    return args;
  }

  /// Generate Prisma client for a specific schema
  Future<int> _generateForSchema(String schemaPath) async {
    final schemaFile = File(schemaPath);

    if (!schemaFile.existsSync()) {
      _logger.err('Error: Schema not found at $schemaPath');
      return ExitCode.usage.code;
    }

    _logger.info('Generating Prisma client for schema: $schemaPath');

    try {
      final args = _buildCommandArgs();
      args.addAll(['--schema', schemaPath]);

      final result = await Process.run(
        'npx',
        args,
        runInShell: true,
      );

      if (result.exitCode != 0) {
        _logger.err('Error generating Prisma client:');
        _logger.err(result.stderr as String);
        return ExitCode.software.code;
      } else {
        _logger.success('Prisma client generated successfully for $schemaPath');
        return ExitCode.success.code;
      }
    } catch (e) {
      _logger.err('Error executing prisma generate: $e');
      return ExitCode.software.code;
    }
  }

  /// Find all Prisma schema files in a directory
  List<File> _findPrismaSchemas(Directory directory) {
    final prismaFiles = <File>[];

    try {
      final entities = directory.listSync();

      for (final entity in entities) {
        if (entity is File && path.extension(entity.path) == '.prisma') {
          prismaFiles.add(entity);
        }
      }
    } catch (e) {
      _logger.warn('Error scanning directory ${directory.path}: $e');
    }

    return prismaFiles;
  }

  /// Generates Prisma client for all schemas in the root prisma directory
  Future<void> _generateRootPrismaSchemas() async {
    final prismaDir = Directory('prisma');

    if (prismaDir.existsSync()) {
      final schemaFiles = _findPrismaSchemas(prismaDir);

      if (schemaFiles.isEmpty) {
        _logger.info('No Prisma schema files found in root prisma directory.');
        return;
      }

      for (final schemaFile in schemaFiles) {
        _logger.info(
          'Generating Prisma client for root schema: ${schemaFile.path}',
        );

        try {
          final args = _buildCommandArgs();
          args.addAll(['--schema', schemaFile.path]);

          final result = await Process.run(
            'npx',
            args,
            runInShell: true,
          );

          if (result.exitCode != 0) {
            _logger
                .err('Error generating Prisma client for ${schemaFile.path}:');
            _logger.err(result.stderr as String);
          } else {
            _logger.success(
              'Prisma client generated successfully for ${schemaFile.path}',
            );
          }
        } catch (e) {
          _logger.err(
            'Error executing prisma generate for ${schemaFile.path}: $e',
          );
        }
      }
    }
  }

  /// Generates Prisma clients for all schema files in all module schema directories
  Future<void> _generateModulePrismaSchemas() async {
    try {
      final file = File('sarus.yml');
      final content = file.readAsStringSync();
      final yaml = loadYaml(content) as Map;

      final modules = (yaml['modules'] as List<dynamic>? ?? []).cast<String>();

      for (final module in modules) {
        final schemaDir = Directory('lib/$module/schema');

        if (schemaDir.existsSync()) {
          final schemaFiles = _findPrismaSchemas(schemaDir);

          if (schemaFiles.isEmpty) {
            _logger.info('No Prisma schema files found for module "$module".');
            continue;
          }

          for (final schemaFile in schemaFiles) {
            _logger.info(
              'Generating Prisma client for module "$module" schema: ${schemaFile.path}',
            );

            try {
              final args = _buildCommandArgs();
              args.addAll(['--schema', schemaFile.path]);

              final result = await Process.run(
                'npx',
                args,
                runInShell: true,
              );

              if (result.exitCode != 0) {
                _logger.err(
                  'Error generating Prisma client for ${schemaFile.path}:',
                );
                _logger.err(result.stderr as String);
              } else {
                _logger.success(
                  'Prisma client generated successfully for ${schemaFile.path}',
                );
              }
            } catch (e) {
              _logger.err(
                'Error executing prisma generate for ${schemaFile.path}: $e',
              );
            }
          }
        }
      }
    } catch (e) {
      _logger.err('Error reading or parsing sarus.yml: $e');
    }
  }
}
