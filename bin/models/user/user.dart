import 'dart:convert' show json;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart' show JWT, SecretKey;
import 'package:hive/hive.dart'
    show
        BinaryReader,
        BinaryWriter,
        Hive,
        HiveField,
        HiveObject,
        HiveType,
        TypeAdapter;

import '../../helpers/constants.dart' show hiveTypeUser;

part 'user.g.dart';

@HiveType(typeId: hiveTypeUser)
class User extends HiveObject {
  static const String boxName = 'userBox';
  static final users = Hive.box<User>(boxName);

  Future<void> put() async => await Hive.box<User>(boxName).put(email, this);

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    int _id = DateTime.now().millisecondsSinceEpoch;
    return User(
      id: map['id'] ?? _id,
      name: map['name'],
      email: map['email'],
      password: map['password'],
      token: map['token'] ??
          JWT({'id': _id, 'email': map['email']}).sign(SecretKey('clerk')),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, password: $password, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ password.hashCode;
}
