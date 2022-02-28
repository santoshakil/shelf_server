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
      uid: fields[0] as int,
      users: (fields[1] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, FavContact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.users);
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
