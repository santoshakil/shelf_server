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

import '../helpers/constants.dart' show hiveTypeFavContact;

part 'favouriteContact.g.dart';

@HiveType(typeId: hiveTypeFavContact)
class FavContact extends HiveObject {
  static const String boxName = 'favContactBox';
  static final favContacts = Hive.box<FavContact>(boxName);

  Future<void> put() async => await Hive.box<FavContact>(boxName).put(id.toString(), this);

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;

  FavContact({
    required this.id,
    required this.name,
    required this.email,
  });

  FavContact copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return FavContact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory FavContact.fromMap(Map<String, dynamic> map) {
    int _id = DateTime.now().millisecondsSinceEpoch;
    return FavContact(
      id: int.parse(map['id']),
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavContact.fromJson(String source) => FavContact.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavContact && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email)';
}