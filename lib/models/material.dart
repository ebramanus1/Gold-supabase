import 'package:json_annotation/json_annotation.dart';

part 'material.g.dart';

@JsonSerializable()
class Material {
  final String id;
  final String name;
  final String karat;
  final DateTime createdAt;

  Material({
    required this.id,
    required this.name,
    required this.karat,
    required this.createdAt,
  });

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialToJson(this);
}

