import 'dart:async' show FutureOr;
import 'dart:convert' show jsonDecode;

import 'package:shelf/shelf.dart' show Request, Response;

import '../../database/channels.dart' show channels;
import '../../models/user/user.dart' show User;

FutureOr<Response> sendNotificationHandler(Request request) async {
  final String _body = await request.readAsString();
  final Map<String, dynamic> _map = jsonDecode(_body);

  final String? _auth = request.headers['Authorization'];
  if (_auth == null) return Response.forbidden('Invalid Authorization');
  final String? _message = _map['message'];
  final String? _email = _map['email'];
  final String? _to = _map['to'];
  if (_message == null || _email == null || _to == null) {
    return Response.forbidden('message, email and to are required');
  }

  final User? _user = User.users.get(_email);
  if (_user == null) return Response.forbidden('User not found');
  if (_user.token != _auth) return Response.forbidden('Invalid Authorization');
  final User? _toUser = User.users.get(_to);
  if (_toUser == null) return Response.forbidden('To user not found');

  final _channel = channels[_to];
  if (_channel == null) return Response.forbidden('To User is not connected');
  _channel.sink.add('''
  {
    "message": "$_message",
    "email": "$_email",
    "sender": "${_user.name}",
    "time": "${DateTime.now()}"
  }
  ''');

  return Response.ok('Message sent!');
}
