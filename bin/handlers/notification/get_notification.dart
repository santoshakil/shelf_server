import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;
import 'package:shelf_web_socket/shelf_web_socket.dart' show webSocketHandler;
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

import '../../database/channels.dart' show channels;
import '../../database/postgres/functions/user.dart';
import '../../models/user/user.dart' show User;

FutureOr<Response> getNotificationHandler(Request request) async {
  final String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');

  final String? _email = request.headers['email'];
  if (_email == null) return Response.forbidden('email is required');

  // final User? _user = User.users.get(_email);
  final User? _user = await getUserByEmail(_email);
  if (_user == null) return Response.forbidden('Invalid email');
  if (_user.token != _token) return Response.forbidden('Invalid token');

  void _onConnection(WebSocketChannel webSocket) {
    channels.addAll({_email: webSocket});
    print('${_user.name} is connected!');
    webSocket.sink.add('You are connected!');
  }

  return await webSocketHandler(_onConnection)(request);
}
