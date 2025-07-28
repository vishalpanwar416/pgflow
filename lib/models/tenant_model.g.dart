// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TenantAdapter extends TypeAdapter<Tenant> {
  @override
  final int typeId = 2;

  @override
  Tenant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tenant(
      tenantId: fields[0] as String,
      pgId: fields[1] as String,
      name: fields[2] as String,
      rent: fields[3] as double,
      roomNo: fields[4] as String,
      joinDate: fields[5] as DateTime,
      leaveDate: fields[6] as DateTime?,
      phone: fields[7] as String,
      email: fields[8] as String,
      isActive: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Tenant obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.tenantId)
      ..writeByte(1)
      ..write(obj.pgId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.rent)
      ..writeByte(4)
      ..write(obj.roomNo)
      ..writeByte(5)
      ..write(obj.joinDate)
      ..writeByte(6)
      ..write(obj.leaveDate)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TenantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
