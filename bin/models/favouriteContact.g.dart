// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favouriteContact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavContactAdapter extends TypeAdapter<FavContact> {
  @override
  final int typeId = 2;

  @override
  FavContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavContact(
      id: fields[0] as int,
      name: fields[1] as String,
      email: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavContact obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
