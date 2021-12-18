import 'dart:async' show FutureOr;

import 'package:shelf/shelf.dart' show Request, Response;
import 'package:shelf_web_socket/shelf_web_socket.dart' show webSocketHandler;
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

import '../../database/channels.dart' show channels;

FutureOr<Response> getNotificationHandler(Request request) async {
  String? _token = request.headers['Authorization'];
  if (_token == null) return Response.forbidden('Invalid token');

  void _onConnection(WebSocketChannel webSocket) {
    channels.addAll({_token: webSocket});
    print('Client($_token) connected!');
    webSocket.sink.add('You are connected!');
    webSocket.stream.listen(
      (m) => print('Received message: $m'),
      onError: (e) {
        webSocket.sink.add(e);
        print('Error: $e');
      },
      onDone: () => channels.remove(_token),
      cancelOnError: false,
    );
  }

  return await webSocketHandler(_onConnection)(request);
}
