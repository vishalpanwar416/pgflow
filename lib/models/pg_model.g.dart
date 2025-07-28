// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pg_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PGAdapter extends TypeAdapter<PG> {
  @override
  final int typeId = 1;

  @override
  PG read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PG(
      pgId: fields[0] as String,
      ownerId: fields[1] as String,
      pgName: fields[2] as String,
      address: fields[3] as String,
      createdAt: fields[4] as DateTime,
      totalRooms: fields[5] as int,
      occupiedRooms: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PG obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.pgId)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.pgName)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.totalRooms)
      ..writeByte(6)
      ..write(obj.occupiedRooms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PGAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
