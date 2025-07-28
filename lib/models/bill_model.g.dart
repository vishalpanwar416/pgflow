// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 3;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      billId: fields[0] as String,
      tenantId: fields[1] as String,
      month: fields[2] as DateTime,
      amount: fields[3] as double,
      paid: fields[4] as bool,
      dueDate: fields[5] as DateTime,
      paidDate: fields[6] as DateTime?,
      paymentMethod: fields[7] as String?,
      transactionId: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.billId)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.paid)
      ..writeByte(5)
      ..write(obj.dueDate)
      ..writeByte(6)
      ..write(obj.paidDate)
      ..writeByte(7)
      ..write(obj.paymentMethod)
      ..writeByte(8)
      ..write(obj.transactionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
