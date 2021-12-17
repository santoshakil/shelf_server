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
  ..get('/send/<token>', _webSocketHandler);

Response _rootHandler(Request _) {
  return Response.ok('Hello');
}

FutureOr<Response> _webSocketHandler(Request request) async {
  String? _token = request.params['token'];
  if (_token == null) return Response.forbidden('Invalid token');

  void _onConnection(WebSocketChannel webSocket) {
    _channels.addAll({_token: webSocket});
    print('Client($_token) connected!');
    webSocket.stream.listen(
      (m) => print('Received message: $m'),
      onError: (e) {
        print('Error: $e');
        webSocket.sink.add(e);
      },
      onDone: () => _channels.remove(_token),
      cancelOnError: false,
    );
    if (_token == '10001') {
      for (var _channel in _channels.entries) {
        _channel.value.sink.add('Hello, Client($_token)');
      }
    }
  }

  return await webSocketHandler(_onConnection)(request);
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;
  // final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
  final _handler = Pipeline().addHandler(_router);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);

  print('Server listening on address ${server.address} port ${server.port}');
}
