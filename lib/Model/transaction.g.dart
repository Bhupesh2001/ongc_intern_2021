// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransActionAdapter extends TypeAdapter<TransAction> {
  @override
  final int typeId = 0;

  @override
  TransAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransAction()
      ..name = fields[0] as String
      ..createdDate = fields[1] as DateTime
      ..isRead = fields[2] as bool
      ..message = (fields[3] as List)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, TransAction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.isRead)
      ..writeByte(3)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
