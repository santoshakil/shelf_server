import '../../../models/user/user.dart';
import '../postgres.dart';

Future<void> createUserTable() async => await pg.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        token VARCHAR(255) NOT NULL,
        phone VARCHAR(255) NOT NULL,
        address VARCHAR(255) NOT NULL,
        designation VARCHAR(255) NOT NULL,
        department VARCHAR(255) NOT NULL,
        profile_picture bytea,
        chat_rooms VARCHAR[],
        created_at TIMESTAMP NOT NULL DEFAULT NOW()
      )
    ''');

Future<void> createUser(User user) async => await pg.execute(
      '''
      INSERT INTO users (name, email, password, token, phone, address, designation, department, profile_picture, chat_rooms)
      VALUES (@name, @email, @password, @token, @phone, @address, @designation, @department, @profile_picture, @chat_rooms)
      ''',
      substitutionValues: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'token': user.token,
        'phone': user.phone,
        'address': user.address,
        'designation': user.designation,
        'department': user.depertment,
        'profile_picture': user.profilePicture,
        'chat_rooms': user.chatRooms,
      },
    );

Future<User?> getUserByEmail(String email) async {
  final results = await pg.query(
    'SELECT * FROM users WHERE email = @email',
    substitutionValues: {'email': email},
  );

  if (results.isEmpty) return null;

  return User.fromMap(results.first.toColumnMap());
}

Future<User?> getUserByToken(String token) async {
  final results = await pg.query(
    'SELECT * FROM users WHERE token = @token',
    substitutionValues: {'token': token},
  );

  if (results.isEmpty) return null;

  return User.fromMap(results.first.toColumnMap());
}

Future<User?> getUserById(int id) async {
  final results = await pg.query(
    'SELECT * FROM users WHERE id = @id',
    substitutionValues: {'id': id},
  );

  if (results.isEmpty) return null;

  return User.fromMap(results.first.toColumnMap());
}

Future<void> deleteUser(int id) async => await pg.execute(
      'DELETE FROM users WHERE id = @id',
      substitutionValues: {'id': id},
    );

Future<void> updateUser(User user) async => await pg.execute(
      '''
      UPDATE users
      SET name = @name,
          email = @email,
          password = @password,
          token = @token,
          phone = @phone,
          address = @address,
          designation = @designation,
          department = @department,
          profile_picture = @profile_picture
      WHERE id = @id
      ''',
      substitutionValues: {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'token': user.token,
        'phone': user.phone,
        'address': user.address,
        'designation': user.designation,
        'department': user.depertment,
        'profile_picture': user.profilePicture,
      },
    );

Future<void> updateToken(int id, String token) async => await pg.execute(
      '''
      UPDATE users
      SET token = @token
      WHERE id = @id
      ''',
      substitutionValues: {'id': id, 'token': token},
    );

Future<void> updatePassword(int id, String password) async => await pg.execute(
      '''
      UPDATE users
      SET password = @password
      WHERE id = @id
      ''',
      substitutionValues: {'id': id, 'password': password},
    );

Future<void> updatePhone(int id, String phone) async => await pg.execute(
      '''
      UPDATE users
      SET phone = @phone
      WHERE id = @id
      ''',
      substitutionValues: {'id': id, 'phone': phone},
    );

Future<void> updateEmail(int id, String email) async => await pg.execute(
      '''
      UPDATE users
      SET email = @email
      WHERE id = @id
      ''',
      substitutionValues: {'id': id, 'email': email},
    );

Future<void> updateProfilePicture(int id, img) async => await pg.execute(
      '''
      UPDATE users
      SET profile_picture = @img
      WHERE id = @id
      ''',
      substitutionValues: {'id': id, 'img': img},
    );

Future<bool> validateUserToken(String token) async {
  final results = await pg.query(
    'SELECT * FROM users WHERE token = @token',
    substitutionValues: {'token': token},
  );

  return results.isNotEmpty;
}
