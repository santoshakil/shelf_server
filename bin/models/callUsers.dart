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
  Future<void> put() async => await Hive.box<UserCall>(boxName).put(id.toString(), this);

  @HiveField(0)
  String? email;
  @HiveField(1)
  int? id;

  UserCall({required this.email,required this.id});

  UserCall copyWith({
    String? email,
    int? id,
  }) {
    return UserCall(
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'id': id};
  }

  String toJson() => json.encode(toMap());

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserCall && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User(id: $id)';
}
