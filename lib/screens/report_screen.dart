import 'package:flutter/material.dart';
import 'package:gold_workshop_manager/services/report_service.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportService reportService = ReportService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Dummy data for demonstration
                final List<Map<String, dynamic>> data = [
                  {'Name': 'Item A', 'Weight': 10.5, 'Status': 'Available'},
                  {'Name': 'Item B', 'Weight': 5.2, 'Status': 'Sold'},
                ];
                await reportService.generatePdfReport(data, 'inventory_report');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إنشاء تقرير PDF')), 
                );
              },
              child: const Text('إنشاء تقرير PDF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Dummy data for demonstration
                final List<Map<String, dynamic>> data = [
                  {'Name': 'Item A', 'Weight': 10.5, 'Status': 'Available'},
                  {'Name': 'Item B', 'Weight': 5.2, 'Status': 'Sold'},
                ];
                await reportService.generateExcelReport(data, 'inventory_report');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إنشاء تقرير Excel')), 
                );
              },
              child: const Text('إنشاء تقرير Excel'),
            ),
          ],
        ),
      ),
    );
  }
}

