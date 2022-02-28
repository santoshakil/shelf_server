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

import '../helpers/constants.dart' show hiveTypeUser;


part 'user.g.dart';

@HiveType(typeId: hiveTypeUser)
class User extends HiveObject {
  static const String boxName = 'userBox';
  static final users = Hive.box<User>(boxName);

  Future<void> put() async => await Hive.box<User>(boxName).put(id.toString(), this);

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
  @HiveField(5)
  String phone;
  @HiveField(6)
  String address;
  @HiveField(7)
  String designation;
  @HiveField(8)
  String depertment;
  @HiveField(9, defaultValue: false)
  bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    required this.phone,
    required this.address,
    required this.designation,
    required this.depertment,
    this.isActive = false,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? token,
    String? phone,
    String? address,
    String? designation,
    String? depertment,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      designation: designation ?? this.designation,
      depertment: depertment ?? this.depertment,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'designation': designation,
      'depertment': depertment,
      'isActive': isActive,
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
          JWT({
            'id': _id,
            'email': map['email'],
            'expiry': DateTime.now().add(Duration(days: 30)).toString(),
          }).sign(SecretKey('clerk')),
      phone: map['phone'],
      address: map['address'],
      designation: map['designation'],
      depertment: map['depertment'],
      isActive: map['isActive'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, phone: $phone, address: $address, designation: $designation, depertment: $depertment)';
}