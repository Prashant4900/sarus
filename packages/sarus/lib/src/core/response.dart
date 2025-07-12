import 'dart:io' show HttpResponse;

import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;

class Response extends shelf.Response {
  Response(super.statusCode);

  Response.json({
    int statusCode = 200,
    Object? body = const <String, dynamic>{},
    Map<String, Object> headers = const <String, Object>{},
  }) : super(statusCode, headers: headers, body: body);

  /// Create a [Response] with a byte array body.
  Response.bytes({
    int statusCode = 200,
    List<int>? body,
    Map<String, Object>? headers,
  }) : super(
          statusCode,
          body: body,
          headers: headers,
        );

  /// Create a [Response] with a string body.
  Response.text({
    int statusCode = 200,
    String? body,
    Map<String, Object>? headers,
  }) : super(
          statusCode,
          body: body,
          headers: headers,
        );

  /// Create a [Response] with a stream of bytes.
  ///
  /// If [bufferOutput] is `true` (the default), streamed responses will be
  /// buffered to improve performance. If `false`, all chunks will be pushed
  /// over the wire as they're received. Note that, disabling buffering of the
  /// output can result in very poor performance, when writing many small
  /// chunks.
  ///
  /// See also:
  ///
  /// * [HttpResponse.bufferOutput](https://api.flutter.dev/flutter/dart-io/HttpResponse/bufferOutput.html)
  Response.stream({
    int statusCode = 200,
    Stream<List<int>>? body,
    Map<String, Object>? headers,
    bool bufferOutput = true,
  }) : super(
          statusCode,
          body: body,
          headers: headers,
          context: !bufferOutput
              ? {Response.shelfBufferOutputContextKey: bufferOutput}
              : null,
        );

  /// A `shelf.Response.context` key used to determine if if the
  /// [HttpResponse.bufferOutput] should be enabled or disabled.
  ///
  /// See also:
  ///
  /// * [shelf_io library](https://pub.dev/documentation/shelf/latest/shelf_io/shelf_io-library.html)
  /// * [HttpResponse.bufferOutput](https://api.flutter.dev/flutter/dart-io/HttpResponse/bufferOutput.html)
  @visibleForTesting
  static const shelfBufferOutputContextKey = 'shelf.io.buffer_output';
}
