import 'package:postgres/postgres.dart';

import 'functions/chat.dart';
import 'functions/user.dart';

late final PostgreSQLConnection _pg;
PostgreSQLConnection get pg => _pg;

Future<void> initPostgres() async {
  _pg = PostgreSQLConnection(
    '0.0.0.0',
    5432,
    'postgres',
    username: 'santo',
    password: '11111111',
  );

  await _pg.open();
  await createUserTable();
  await createGroupChatInfoTable();
}
