import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ReportService {
  Future<void> generatePdfReport(List<Map<String, dynamic>> data, String filename) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('تقرير المخزون', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  headers: List<String>.from(data.first.keys),
                  data: data.map((row) => List<String>.from(row.values.map((e) => e.toString()))).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$filename.pdf');
    await file.writeAsBytes(await pdf.save());
    print('PDF report generated at: ${file.path}');
  }

  Future<void> generateExcelReport(List<Map<String, dynamic>> data, String filename) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add headers
    if (data.isNotEmpty) {
      data.first.keys.forEach((key) {
        sheetObject.appendRow([key]);
      });
    }

    // Add data
    data.forEach((row) {
      sheetObject.appendRow(row.values.map((e) => e.toString()).toList());
    });

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$filename.xlsx');
    await file.writeAsBytes(excel.encode()!); // Use excel.encode()! for non-nullable
    print('Excel report generated at: ${file.path}');
  }
}

