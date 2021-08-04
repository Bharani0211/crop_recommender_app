import 'dart:io';
import 'dart:typed_data';
// import 'dart:js';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final String algorithm;
  final String crop;
  final String accuracy;
  final String genTime;
  final String pdfTime;

  const Data({
    required this.algorithm,
    required this.crop,
    required this.accuracy,
    required this.genTime,
    required this.pdfTime,
  });
}

class PdfApi {
  static Future<File> generatePdf(List<List<String>> data, List<String> times,
      String? username, String? email, String recommendation_id) async {
    final pdf = Document();
    print(data);
    pdf.addPage(
      MultiPage(
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
          final msg = "CMRIT ISE 8A";

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
                child: Text(
                  msg,
                  style: TextStyle(color: PdfColors.black),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
                child: Text(
                  text,
                  style: TextStyle(color: PdfColors.black),
                ),
              ),
            ],
          );
        },
        build: (context) => <Widget>[
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PdfLogo(),
                SizedBox(width: 0.5 * PdfPageFormat.cm),
                Text(
                  "Crop recommender system",
                  style: TextStyle(fontSize: 20, color: PdfColors.black),
                ),
              ],
            ),
            SizedBox(height: 0.5 * PdfPageFormat.cm),
            Text(
              "Project by CMRIT ISE",
              style: TextStyle(fontSize: 18, color: PdfColors.black),
            ),
          ]),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Header(
            child: Text(
              "Naives Bayes",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Paragraph(
            text:
                "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in.",
          ),
          SizedBox(height: 0.1 * PdfPageFormat.cm),
          Header(
            child: Text(
              "KNN",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Paragraph(
            text:
                "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in.",
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Header(
            child: Text(
              "Decision tree",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Paragraph(
            text:
                "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in.",
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Header(
            child: Text(
              "Random forest",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Paragraph(
            text:
                "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in.",
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Header(
            child: Text(
              "Logistic regression",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Paragraph(
            text:
                "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in.",
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text("User name: " + username!),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text("Email ID: " + email!),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text("Recommendation ID: " + recommendation_id),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text("Result data generated time: " + times[0]),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Text("PDF generated time: " + times[1]),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Table.fromTextArray(headers: data[0], data: [data[1], data[2]]),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
        ],
      ),
    );
    return saveDocument(name: 'my-example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
