import 'package:postgres/postgres.dart';

Future<void> openPostgres() async {
  final postgres = PostgreSQLConnection(
    '0.0.0.0',
    5432,
    'postgres',
    username: 'postgres',
    password: '02630263',
  );

  await postgres.open();
  await postgres.execute('CREATE DATABASE IF NOT EXISTS users');
}
