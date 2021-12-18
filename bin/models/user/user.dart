import 'package:hive/hive.dart'
    show
        HiveField,
        HiveObject,
        HiveType,
        TypeAdapter,
        BinaryReader,
        BinaryWriter;

import '../../helpers/constants.dart' show hiveTypeUser;

part 'user.g.dart';

@HiveType(typeId: hiveTypeUser)
class User extends HiveObject {
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
}
