import 'dart:convert' show json;

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart' show JWT, SecretKey;
import 'package:hive/hive.dart'
    show BinaryReader, BinaryWriter, Hive, HiveField, HiveList, HiveObject, HiveType, TypeAdapter;

import '../helpers/constants.dart' show hiveTypeFavContact;
import 'user.dart';

part 'favouriteContact.g.dart';

// key: uid, value: [...users]

@HiveType(typeId: hiveTypeFavContact)
class FavContact extends HiveObject {
  static const String boxName = 'favContactBox';
  static final favContacts = Hive.box<FavContact>(boxName);
  Future<void> put() async =>
      await Hive.box<FavContact>(boxName).put(uid.toString(), this);

  @HiveField(0)
  int uid;
  @HiveField(1)
  HiveList<User> users;

  FavContact({
    required this.uid,
    required this.users
  });

  FavContact copyWith({
    int? id,
    HiveList<User>? users
  }) {
    return FavContact(
      uid: id ?? uid,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'user': users
    };
  }

  // factory FavContact.fromMap(Map<String, dynamic> map) {
  //   int _id = DateTime.now().millisecondsSinceEpoch;
  //   return FavContact(
  //     uid: int.parse(map['id']),
  //     users: map['user']
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory FavContact.fromJson(String source) =>
  //     FavContact.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavContact && other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;

  @override
  String toString() => 'User(id: $uid)';
}
