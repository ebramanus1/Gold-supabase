import 'package:json_annotation/json_annotation.dart';

part 'gold_item.g.dart';

@JsonSerializable()
class GoldItem {
  final String id;
  final String name;
  final String materialId;
  final double weight;
  final String status;
  final DateTime createdAt;

  GoldItem({
    required this.id,
    required this.name,
    required this.materialId,
    required this.weight,
    required this.status,
    required this.createdAt,
  });

  factory GoldItem.fromJson(Map<String, dynamic> json) =>
      _$GoldItemFromJson(json);

  Map<String, dynamic> toJson() => _$GoldItemToJson(this);
}

