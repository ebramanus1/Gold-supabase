import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gold_workshop_manager/models/gold_item.dart';

class GoldItemRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<GoldItem>> getGoldItems({
    String? karat,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return _supabase
        .from('items')
        .stream(primaryKey: ['id'])
        .map((maps) => maps
            .map((map) => GoldItem.fromJson(map))
            .where((item) =>
                (karat == null || item.karat == karat) &&
                (status == null || item.status == status) &&
                (startDate == null || item.createdAt.isAfter(startDate)) &&
                (endDate == null || item.createdAt.isBefore(endDate)))
            .toList());
  }

  Future<void> addGoldItem(GoldItem item) async {
    await _supabase.from('items').insert(item.toJson());
  }

  Future<void> updateGoldItem(GoldItem item) async {
    await _supabase
        .from('items')
        .update(item.toJson())
        .eq('id', item.id);
  }

  Future<void> deleteGoldItem(String id) async {
    await _supabase.from('items').delete().eq('id', id);
  }
}

