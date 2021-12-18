import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;

FutureOr<Response> sendNotificationHandler(Request request) async {
  final String? _auth = request.headers['Authorization'];
  if (_auth == null) return Response.forbidden('Invalid Authorization');

  final String? _token = request.headers['to'];
  if (_token == null) return Response.forbidden('Invalid token');

  final _channel = channels[_token];
  if (_channel == null) return Response.forbidden('User not found');
  _channel.sink.add(await request.readAsString());

  return Response.ok('Message sent!');
}
