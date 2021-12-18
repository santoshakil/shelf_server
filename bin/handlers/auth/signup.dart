import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

FutureOr<Response> signUpHandler(Request request) async {
  return Response.ok('Sign up');
}
