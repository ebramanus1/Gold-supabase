
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String id;
  final String itemId;
  final int quantity;
  final DateTime transactionDate;
  final String type; // 'entry' or 'output'

  Transaction({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.transactionDate,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

