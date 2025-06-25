import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gold_workshop_manager/models/transaction.dart';

class TransactionRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<List<Transaction>> getTransactions() {
    return _supabase.from('entries').stream(primaryKey: ['id']).map(
        (maps) => maps.map((map) => Transaction.fromJson(map)).toList());
  }

  Future<void> addEntry(Transaction transaction) async {
    await _supabase.from('entries').insert(transaction.toJson());
  }

  Future<void> addOutput(Transaction transaction) async {
    await _supabase.from('outputs').insert(transaction.toJson());
  }
}

