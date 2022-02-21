import 'package:shelf/shelf.dart' show Pipeline, logRequests;
import 'package:shelf/shelf_io.dart' show serve;

import 'database/hive.dart' show initHive;
import 'database/postgres.dart' show openPostgres;
import 'handlers/handlers.dart' show handlers;
import 'helpers/constants.dart' show serverIP, serverPort;

void main(List<String> args) async {
  await initHive();
  await openPostgres();

  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(handlers);
  final server = await serve(_handler, serverIP, serverPort);

  print('Server listening on address ${server.address} port ${server.port}');
}
