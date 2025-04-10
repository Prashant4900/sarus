// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// A generator that converts YAML schema definitions to JSON files.
class JsonGenerator {
  /// Creates a new [JsonGenerator] instance.
  ///
  /// [appLabel] is used to identify the application.
  /// [schemaYaml] contains the schema definitions to process.
  /// Set [dryRun] to true to preview changes without writing files.
  JsonGenerator({
    required this.appLabel,
    required this.schemaYaml,
    required this.logger,
    this.dryRun = false,
  });

  /// The application label for identification.
  final String appLabel;

  /// The YAML map containing the schema definitions.
  final YamlMap schemaYaml;

  /// Whether to perform a dry run (no files are written).
  final bool dryRun;

  /// The logger to use for logging.
  final Logger logger;

  /// Generates schema JSON files based on the provided YAML definitions.
  ///
  /// Returns the number of schema files generated.
  Future<int> generate() async {
    if (!schemaYaml.containsKey('schema')) {
      throw const FormatException('Missing "schema" key in YAML configuration');
    }

    final schemas = schemaYaml['schema'] as YamlList?;
    if (schemas == null || schemas.isEmpty) {
      logger.err('No schemas found to generate');
      return 0;
    }

    // Prepare output directory
    final baseDir = Directory.current.path;
    final outDir = Directory(path.join(baseDir, 'lib', 'gen', 'schemas'));

    if (!outDir.existsSync() && !dryRun) {
      outDir.createSync(recursive: true);
    }

    var filesGenerated = 0;

    // Process each schema
    for (final schema in schemas) {
      if (schema is! YamlMap) {
        logger.info('Skipping invalid schema format: $schema');
        continue;
      }

      try {
        await _processSchema(schema, outDir);
        filesGenerated++;
      } catch (e) {
        logger
            .err('Error processing schema: ${schema['name'] ?? 'unnamed'}: $e');
      }
    }

    return filesGenerated;
  }

  /// Processes a single schema definition and writes the output file.
  Future<void> _processSchema(YamlMap schemaMap, Directory outDir) async {
    final tableName = schemaMap['name'] as String?;
    if (tableName == null || tableName.isEmpty) {
      throw const FormatException('Schema missing name attribute');
    }

    final fields = schemaMap['fields'] as YamlMap?;
    if (fields == null) {
      throw FormatException('Schema "$tableName" missing fields attribute');
    }

    // Convert schema to JSON
    final jsonOutput = <String, dynamic>{
      'name': tableName,
      'fields': <String, dynamic>{},
    };

    for (final entry in fields.entries) {
      if (entry.value is YamlMap) {
        jsonOutput['fields'][entry.key] =
            Map<String, dynamic>.from(entry.value as Map);
      } else {
        jsonOutput['fields'][entry.key] = entry.value;
      }
    }

    // Write output file
    final outputPath = path.join(outDir.path, '$tableName.json');

    if (dryRun) {
      logger.info('[Dry Run] Would write: $outputPath');
    } else {
      final outputFile = File(outputPath);
      await outputFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(jsonOutput),
      );
      logger.info('Wrote: $outputPath');
    }
  }
}
