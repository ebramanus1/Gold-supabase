// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Material _$MaterialFromJson(Map<String, dynamic> json) => Material(
  id: json['id'] as String,
  name: json['name'] as String,
  karat: json['karat'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MaterialToJson(Material instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'karat': instance.karat,
  'createdAt': instance.createdAt.toIso8601String(),
};
