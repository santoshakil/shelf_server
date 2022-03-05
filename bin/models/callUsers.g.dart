// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callUsers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCallAdapter extends TypeAdapter<UserCall> {
  @override
  final int typeId = 3;

  @override
  UserCall read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCall(
      email: fields[0] as String?,
      id: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserCall obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCallAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
