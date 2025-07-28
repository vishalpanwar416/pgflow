// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComplaintAdapter extends TypeAdapter<Complaint> {
  @override
  final int typeId = 4;

  @override
  Complaint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Complaint(
      complaintId: fields[0] as String,
      tenantId: fields[1] as String,
      issue: fields[2] as String,
      status: fields[3] as String,
      createdAt: fields[4] as DateTime,
      resolvedAt: fields[5] as DateTime?,
      resolution: fields[6] as String?,
      category: fields[7] as String,
      priority: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Complaint obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.complaintId)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.issue)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.resolvedAt)
      ..writeByte(6)
      ..write(obj.resolution)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplaintAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
