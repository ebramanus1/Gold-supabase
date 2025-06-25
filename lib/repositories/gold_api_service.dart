import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class GoldApiService {
  final String _apiKey = 'goldapi-8t25psmccbprqt-io'; // ضع مفتاحك هنا
  final String _baseUrl = 'https://www.goldapi.io/api/XAU/SAR';

  Future<double> getGoldPrice() async {
    print('GoldApiService.getGoldPrice called');
    if (kIsWeb) {
      print('GoldAPI Error: الاتصال المباشر بـ GoldAPI غير مدعوم من المتصفح بسبب سياسة CORS. استخدم سيرفر وسيط أو جرب على macOS/Windows/Android/iOS.');
      throw Exception('GoldAPI Error: الاتصال المباشر بـ GoldAPI غير مدعوم من المتصفح بسبب سياسة CORS. استخدم سيرفر وسيط أو جرب على macOS/Windows/Android/iOS.');
    }
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'x-access-token': _apiKey,
          'Accept': 'application/json',
        },
      );

      print('Gold API status: [32m${response.statusCode}[0m');
      print('Gold API headers: ${response.headers}');
      print('Gold API body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // إرجاع سعر الجرام 24k فقط (للتوافق)
        return data['price_gram_24k']?.toDouble() ?? 0.0;
      } else {
        throw Exception('GoldAPI Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('GoldAPI Exception: $e');
      throw Exception('GoldAPI Connection Error: $e');
    }
  }

  // دالة جديدة لإرجاع جميع أسعار الجرامات
  Future<Map<String, double>> getGoldGramPrices() async {
    print('GoldApiService.getGoldGramPrices called');
    if (kIsWeb) {
      throw Exception('GoldAPI Error: الاتصال المباشر بـ GoldAPI غير مدعوم من المتصفح بسبب سياسة CORS. استخدم سيرفر وسيط أو جرب على macOS/Windows/Android/iOS.');
    }
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'x-access-token': _apiKey,
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          '24k': data['price_gram_24k']?.toDouble() ?? 0.0,
          '22k': data['price_gram_22k']?.toDouble() ?? 0.0,
          '21k': data['price_gram_21k']?.toDouble() ?? 0.0,
          '18k': data['price_gram_18k']?.toDouble() ?? 0.0,
        };
      } else {
        throw Exception('GoldAPI Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('GoldAPI Connection Error: $e');
    }
  }
}

