// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  itemId: json['itemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  type: json['type'] as String,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'transactionDate': instance.transactionDate.toIso8601String(),
      'type': instance.type,
    };
