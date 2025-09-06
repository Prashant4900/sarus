import 'package:build/build.dart';
import 'package:sarus_gen/generated/application_gen.dart';
import 'package:sarus_gen/generated/endpoint_gen.dart';
import 'package:sarus_gen/generated/model_gen.dart';
import 'package:source_gen/source_gen.dart';

/// Factory function that creates and returns a ModelBuilder instance.
///
/// This function is the entry point for the model code generation system.
/// It creates a LibraryBuilder that uses the ModelGen generator to process
/// model classes that extend `Models<T>`.
Builder modelBuilder(BuilderOptions options) =>
    LibraryBuilder(ModelGen(), generatedExtension: '.models.g.dart');

/// Factory function that creates and returns an EndpointBuilder instance.
///
/// This function is the entry point for the endpoint code generation system.
/// It creates a LibraryBuilder that uses the EndpointGen generator to process
/// endpoint classes that extend `Endpoints`.
Builder endpointBuilder(BuilderOptions options) =>
    LibraryBuilder(EndpointGen(), generatedExtension: '.endpoints.g.dart');

Builder applicationBuilder(BuilderOptions options) =>
    LibraryBuilder(ApplicationGen());
