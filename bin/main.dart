import 'package:shelf/shelf.dart' show Pipeline, logRequests;
import 'package:shelf/shelf_io.dart' show serve;

import 'database/hive.dart' show initHive;
import 'handlers/handlers.dart' show handlers, handlersWS;
import 'helpers/constants.dart' show serverIP, serverPort, serverPortWS;

void main(List<String> args) async {
  await initHive();

  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(handlers);
  final server = await serve(_handler, serverIP, serverPort);
  final ws = await serve(handlersWS, serverIP, serverPortWS);

  print('Server listening on address ${server.address} port ${server.port}');
  print('WebSocket listening on address ${ws.address} port ${ws.port}');
}
