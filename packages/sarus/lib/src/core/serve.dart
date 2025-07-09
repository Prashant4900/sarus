import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

/// Starts an [HttpServer] that listens on the specified [address] and
/// [port] and sends requests to [handler].
///
/// If a [securityContext] is provided an HTTPS server will be started.
///
/// See the documentation for [HttpServer.bind] and [HttpServer.bindSecure]
/// for more details on [address], [port], [backlog], and [shared].
///
/// {@template shelf_io_header_defaults}
/// Every response will get a "date" header and an "X-Powered-By" header.
/// If the either header is present in the `Response`, it will not be
/// overwritten.
/// Pass [poweredByHeader] to set the default content for "X-Powered-By",
/// pass `null` to omit this header.
/// {@endtemplate}
Future<HttpServer> serve(
  Handler handler,
  Object address,
  int port, {
  SecurityContext? securityContext,
  int? backlog,
  bool shared = false,
  String? poweredByHeader = 'Dart with package:sarus',
}) async {
  backlog ??= 0;
  final server = await (securityContext == null
      ? HttpServer.bind(address, port, backlog: backlog, shared: shared)
      : HttpServer.bindSecure(
          address,
          port,
          securityContext,
          backlog: backlog,
          shared: shared,
        ));

  serveRequests(server, handler, poweredByHeader: poweredByHeader);
  return server;
}
