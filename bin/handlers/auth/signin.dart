import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

FutureOr<Response> signInHandler(Request request) async {
  return Response.ok('Hello, world!');
}
