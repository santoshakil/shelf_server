import 'package:postgres/postgres.dart' show PostgreSQLConnection;

import '../models/user/user.dart';

late PostgreSQLConnection postgres;

Future<void> openPostgres() async {
  postgres = PostgreSQLConnection(
    '0.0.0.0',
    5432,
    'postgres',
    username: 'postgres',
    password: '02630263',
  );

  await postgres.open();

  await postgres.execute(
    '''
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      email VARCHAR(255) NOT NULL,
      password VARCHAR(255) NOT NULL,
      created_at TIMESTAMP NOT NULL DEFAULT NOW()
    )
    ''',
  );
}

Future<List<User>> getUsers() async {
  final results = await postgres.query(
    '''
    SELECT * FROM users
    ''',
  );

  return results.map((row) => User.fromMap(row.toColumnMap())).toList();
}

Future<User?> getUserByEmail(String email) async {
  final result = await postgres.mappedResultsQuery(
    'SELECT * FROM users WHERE email = @email',
    substitutionValues: {'email': email},
  );

  if (result.isEmpty) {
    return null;
  }

  return User.fromMap(result.first);
}

Future<User> createUser(User user) async {
  await postgres.execute(
    '''
    INSERT INTO users (name, email, password)
    VALUES (@name, @email, @password)
    ''',
    substitutionValues: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
    },
  );

  return user;
}
