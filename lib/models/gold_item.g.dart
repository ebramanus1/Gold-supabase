// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoldItem _$GoldItemFromJson(Map<String, dynamic> json) => GoldItem(
  id: json['id'] as String,
  name: json['name'] as String,
  materialId: json['materialId'] as String,
  weight: (json['weight'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$GoldItemToJson(GoldItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'materialId': instance.materialId,
  'weight': instance.weight,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
};
