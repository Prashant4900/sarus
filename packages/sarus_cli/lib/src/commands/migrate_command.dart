// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
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
  }) : _logger = logger;

  @override
  String get description =>
      'Generate Prisma clients for root and module schemas.';

  @override
  String get name => 'generate-prisma';

  final Logger _logger;

  @override
  Future<int> run() async {
    // Check if running from project root (sarus.yml exists)
    if (!await _checkProjectRoot()) {
      _logger
          .err('Error: Must run this command from the project root directory.');
      return ExitCode.usage.code;
    }

    // Generate Prisma client for root schema if it exists
    await _generateRootPrisma();

    // Generate Prisma clients for all module schemas
    await _generateModulePrisma();

    return ExitCode.success.code;
  }

  /// Checks if the command is being run from the project root
  /// by verifying the existence of sarus.yml
  Future<bool> _checkProjectRoot() async {
    final file = File('sarus.yml');
    return file.existsSync();
  }

  /// Generates Prisma client for the root schema if it exists
  Future<void> _generateRootPrisma() async {
    final rootSchema = File('prisma/schema.prisma');

    if (rootSchema.existsSync()) {
      _logger.info('Generating Prisma client for root schema...');

      try {
        final result = await Process.run(
          'npx',
          ['prisma', 'generate'],
          runInShell: true,
        );

        if (result.exitCode != 0) {
          _logger.err('Error generating root Prisma client:');
          _logger.err(result.stderr as String);
        } else {
          _logger.success('Root Prisma client generated successfully.');
        }
      } catch (e) {
        _logger.err('Error executing prisma generate: $e');
      }
    }
  }

  /// Generates Prisma clients for all module schemas
  Future<void> _generateModulePrisma() async {
    try {
      final file = File('sarus.yml');
      final content = file.readAsStringSync();
      final yaml = loadYaml(content) as Map;

      // Get modules list from sarus.yml
      final modules = (yaml['modules'] as List<dynamic>? ?? []).cast<String>();

      for (final module in modules) {
        final schemaPath = 'lib/$module/schema/schema.prisma';
        final schemaFile = File(schemaPath);

        if (schemaFile.existsSync()) {
          _logger.info('Generating Prisma client for module "$module"...');

          try {
            final result = await Process.run(
              'npx',
              ['prisma', 'generate', '--schema=$schemaPath'],
              runInShell: true,
            );

            if (result.exitCode != 0) {
              _logger
                  .err('Error generating Prisma client for module "$module":');
              _logger.err(result.stderr as String);
            } else {
              _logger.success(
                'Prisma client for module "$module" generated successfully.',
              );
            }
          } catch (e) {
            _logger.err(
              'Error executing prisma generate for module "$module": $e',
            );
          }
        }
      }
    } catch (e) {
      _logger.err('Error reading or parsing sarus.yml: $e');
    }
  }
}
