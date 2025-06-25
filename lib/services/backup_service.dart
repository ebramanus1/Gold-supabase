import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BackupService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> initHive() async {
    await Hive.initFlutter();
    // Register adapters if needed for custom objects
  }

  Future<void> performLocalBackup() async {
    try {
      // Example: backup a box named 'goldItems'
      final box = await Hive.openBox('goldItems');
      // You would typically serialize your data from Supabase to Hive here
      // For simplicity, this example just shows opening a box.
      print('Local backup performed: ${box.length} items in goldItems box');
      await box.close();
    } catch (e) {
      print('Error performing local backup: $e');
      rethrow;
    }
  }

  Future<void> performCloudBackup() async {
    try {
      // Example: backup a file to Supabase Storage
      // This assumes you have a file to backup, e.g., a serialized Hive box.
      // For a real application, you'd export Hive data to a file first.
      final String bucketName = 'backups'; // Ensure this bucket exists in Supabase
      final String fileName = 'gold_workshop_backup_${DateTime.now().toIso8601String()}.json';

      // Create a dummy file for demonstration purposes
      final file = File('${Directory.systemTemp.path}/$fileName');
      await file.writeAsString('{"data": "This is a dummy backup data"}');

      await _supabase.storage.from(bucketName).upload(
            fileName,
            file,
            fileOptions: const FileOptions(upsert: true),
          );
      print('Cloud backup performed: $fileName uploaded to $bucketName');
      await file.delete(); // Clean up dummy file
    } catch (e) {
      print('Error performing cloud backup: $e');
      rethrow;
    }
  }
}

