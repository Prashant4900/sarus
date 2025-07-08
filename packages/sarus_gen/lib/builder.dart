import 'package:build/build.dart';
import 'package:sarus_gen/generated/sarus_application_builder.dart';

/// Factory function that creates and returns a SarusApplicationBuilder instance.
///
/// This function serves as the entry point for the Sarus code generation system.
/// It is typically called by the build system (build_runner) to instantiate
/// the builder that will generate Sarus application code.
///
/// The function follows the standard builder factory pattern required by
/// the Dart build system, where builder factories must accept BuilderOptions
/// and return a Builder instance.
///
/// [options] Build configuration options passed by the build system.
///           Currently unused but required by the builder factory interface.
///
/// Returns a new instance of [SarusApplicationBuilder] that will handle
/// the code generation process for @Endpoint and @DTO annotated classes.
Builder sarusApplicationBuilder(BuilderOptions options) =>
    SarusApplicationBuilder();
