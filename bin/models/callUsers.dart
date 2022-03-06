import 'dart:convert' show json;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart' show JWT, SecretKey;
import 'package:hive/hive.dart'
    show
        BinaryReader,
        BinaryWriter,
        Hive,
        HiveField,
        HiveList,
        HiveObject,
        HiveType,
        TypeAdapter;

import '../helpers/constants.dart' show hiveTypeUserCall;
import 'user.dart';

part 'callUsers.g.dart';

// key: uid, value: [...users]

@HiveType(typeId: hiveTypeUserCall)
class UserCall extends HiveObject {
  static const String boxName = 'callUserBox';
  static final inCallUser = Hive.box<UserCall>(boxName);
  Future<void> put() async => await Hive.box<UserCall>(boxName).put(email.toString(), this);

  @HiveField(0)
  String? email;

  UserCall({required this.email,});

  UserCall copyWith({
    String? email,
    int? id,
  }) {
    return UserCall(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email};
  }

  String toJson() => json.encode(toMap());

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserCall && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;

  @override
  String toString() => 'User(email: $email)';
}
