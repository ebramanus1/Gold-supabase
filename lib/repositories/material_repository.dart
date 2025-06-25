import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gold_workshop_manager/models/material.dart';

class MaterialRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Material>> getMaterials() {
    return _supabase.from('materials').stream(primaryKey: ['id']).map(
        (maps) => maps.map((map) => Material.fromJson(map)).toList());
  }

  Future<void> addMaterial(Material material) async {
    await _supabase.from('materials').insert(material.toJson());
  }

  Future<void> updateMaterial(Material material) async {
    await _supabase
        .from('materials')
        .update(material.toJson())
        .eq('id', material.id);
  }

  Future<void> deleteMaterial(String id) async {
    await _supabase.from('materials').delete().eq('id', id);
  }
}

