import 'package:flutter/material.dart';
import 'package:gold_workshop_manager/repositories/gold_api_service.dart';

class GoldPriceCard extends StatefulWidget {
  const GoldPriceCard({super.key});

  @override
  State<GoldPriceCard> createState() => _GoldPriceCardState();
}

class _GoldPriceCardState extends State<GoldPriceCard> {
  Map<String, double> _gramPrices = {};
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchGoldPrices();
  }

  Future<void> _fetchGoldPrices() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final prices = await GoldApiService().getGoldGramPrices();
      setState(() {
        _gramPrices = prices;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أسعار جرام الذهب (XAU/SAR)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? SelectableText('Error: $_error', style: const TextStyle(color: Colors.red))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('جرام 24: ر.س ${_gramPrices['24k'] ?? '-'}', style: const TextStyle(fontSize: 20)),
                          Text('جرام 22: ر.س ${_gramPrices['22k'] ?? '-'}', style: const TextStyle(fontSize: 20)),
                          Text('جرام 21: ر.س ${_gramPrices['21k'] ?? '-'}', style: const TextStyle(fontSize: 20)),
                          Text('جرام 18: ر.س ${_gramPrices['18k'] ?? '-'}', style: const TextStyle(fontSize: 20)),
                        ],
                      ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchGoldPrices,
              child: const Text('تحديث الأسعار'),
            ),
          ],
        ),
      ),
    );
  }
}

