import 'package:mason/mason.dart';

export 'build_command.dart';
export 'create_command.dart';
export 'dev_command.dart';
export 'module_command.dart';
export 'update_command.dart';

/// A method which returns a [Future<MasonGenerator>] given a [MasonBundle].
typedef GeneratorBuilder = Future<MasonGenerator> Function(MasonBundle);
