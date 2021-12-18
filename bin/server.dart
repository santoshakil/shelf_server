import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Map<String, WebSocketChannel> _channels = {};

final _router = Router()
  ..get('/', _rootHandler)
  ..get('/getNotificaion', _getNotificationHandler)
  ..post('/sendNotificaion', _sendNotificationHandler);

Response _rootHandler(Request _) {
  return Response.ok('Hello');
}

FutureOr<Response> _getNotificationHandler(Request request) async {
  String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');

  void _onConnection(WebSocketChannel webSocket) {
    _channels.addAll({_token: webSocket});
    print('Client($_token) connected!');
    webSocket.sink.add('You are connected!');
    webSocket.stream.listen(
      (m) => print('Received message: $m'),
      onError: (e) {
        webSocket.sink.add(e);
        print('Error: $e');
      },
      onDone: () => _channels.remove(_token),
      cancelOnError: false,
    );
  }

  return await webSocketHandler(_onConnection)(request);
}

FutureOr<Response> _sendNotificationHandler(Request request) async {
  final String? _auth = request.headers['Authorization'];
  if (_auth == null) return Response.forbidden('Invalid Authorization');

  final String? _token = request.headers['to'];
  if (_token == null) return Response.forbidden('Invalid token');

  final _channel = _channels[_token];
  if (_channel == null) return Response.forbidden('User not found');
  _channel.sink.add(await request.readAsString());

  return Response.ok('Message sent!');
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
  // final _handler = Pipeline().addHandler(_router);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);

  print('Server listening on address ${server.address} port ${server.port}');
}
