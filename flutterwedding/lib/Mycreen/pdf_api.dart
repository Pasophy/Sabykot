import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mymodel/guestmodel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Generatepdffile {
  Future<Uint8List> generatrpdf(Eventsmodel eventsmodel,
      List<Guestmodel> guestmodels, String totaldollar, String totalkh) async {
    final pdf = pw.Document();
    const List<String> string = [
      "WELCOME  SABAYKOT",
      "No",
      "Name",
      "Amount",
      "Address",
      "status",
    ];
    const String dolla = "\$";
    const String riel = "R";
    final font = await rootBundle.load("fonts/Battambang-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.only(
            top: 25.0, bottom: 15.0, left: 10.0, right: 10.0),
        pageFormat: PdfPageFormat.a4,
        maxPages: 50,
        build: (pw.Context context) => [
              pw.Center(
                child: pw.Container(
                  width: 400.0,
                  color: const PdfColor.fromInt(0xffffE9E324),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Text(
                        string[0],
                        style: pw.TextStyle(
                          // fontNormal: ttf,
                          color: const PdfColor.fromInt(0xffff158DCE),
                          fontSize: 30.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(top: 10.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Text(
                        "${eventsmodel.eventname}",
                        style: pw.TextStyle(
                          background: const pw.BoxDecoration(
                              color: PdfColor.fromInt(0xffff76FF03)),
                          color: const PdfColor.fromInt(0xffff158DCE),
                          fontSize: 16.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              pw.Center(
                child: pw.Container(
                  margin: const pw.EdgeInsets.only(top: 10.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Text(
                        "TOTALAMOUNT:  Dollar = $totaldollar \$   Riel = $totalkh R",
                        style: pw.TextStyle(
                          background: const pw.BoxDecoration(
                              color: PdfColor.fromInt(0xffffF50057)),
                          color: const PdfColor.fromInt(0xffffFFFFFF),
                          fontSize: 16.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Container(
                margin:
                    const pw.EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                color: const PdfColor.fromInt(0xffffFFFB300),
                child: pw.Row(
                  //mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        string[1],
                        style: pw.TextStyle(
                            fontNormal: ttf,
                            color: const PdfColor.fromInt(0xffff158DCE),
                            fontSize: 16.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text(
                        string[2],
                        style: pw.TextStyle(
                            fontNormal: ttf,
                            color: const PdfColor.fromInt(0xffff158DCE),
                            fontSize: 16.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text(
                        string[3],
                        style: pw.TextStyle(
                            fontNormal: ttf,
                            color: const PdfColor.fromInt(0xffff158DCE),
                            fontSize: 16.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        string[4],
                        style: pw.TextStyle(
                            fontNormal: ttf,
                            color: const PdfColor.fromInt(0xffff158DCE),
                            fontSize: 16.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                    ),
                    pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                        string[5],
                        style: pw.TextStyle(
                            fontNormal: ttf,
                            color: const PdfColor.fromInt(0xffff158DCE),
                            fontSize: 16.0,
                            fontWeight: pw.FontWeight.bold,
                            font: ttf),
                      ),
                    ),
                  ],
                ),
              ),
              //pw.PieGrid(startAngle: 4.0 ),
              pw.ListView.builder(
                  itemCount: guestmodels.length,
                  itemBuilder: (context, index) => pw.Container(
                        margin:
                            const pw.EdgeInsets.only(left: 10.0, right: 5.0),
                        child: pw.Row(
                          // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Expanded(
                              flex: 1,
                              child: pw.Text(
                                "${index + 1}",
                                style: pw.TextStyle(
                                    fontNormal: ttf,
                                    color: const PdfColor.fromInt(0xffff158DCE),
                                    fontSize: 16.0,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                guestmodels[index].nameguest!,
                                style: pw.TextStyle(
                                    fontNormal: ttf,
                                    color: const PdfColor.fromInt(0xffff158DCE),
                                    fontSize: 16.0,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Row(children: [
                                  pw.Container(
                                    margin:
                                        const pw.EdgeInsets.only(right: 10.0),
                                    child: pw.Text(
                                      "${guestmodels[index].amount}",
                                      style: pw.TextStyle(
                                          fontNormal: ttf,
                                          color: const PdfColor.fromInt(
                                              0xffff158DCE),
                                          fontSize: 16.0,
                                          fontWeight: pw.FontWeight.bold,
                                          font: ttf),
                                    ),
                                  ),
                                  guestmodels[index].currency! == "រៀល"
                                      ? pw.Text(
                                          riel,
                                          style: pw.TextStyle(
                                              fontNormal: ttf,
                                              color: const PdfColor.fromInt(
                                                  0xffff158DCE),
                                              fontSize: 16.0,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf),
                                        )
                                      : pw.Text(
                                          dolla,
                                          style: pw.TextStyle(
                                              fontNormal: ttf,
                                              color: const PdfColor.fromInt(
                                                  0xffff158DCE),
                                              fontSize: 16.0,
                                              fontWeight: pw.FontWeight.bold,
                                              font: ttf),
                                        ),
                                ])),
                            pw.Expanded(
                              flex: 3,
                              child: pw.Text(
                                guestmodels[index].address!,
                                style: pw.TextStyle(
                                    fontNormal: ttf,
                                    color: const PdfColor.fromInt(0xffff158DCE),
                                    fontSize: 16.0,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                            pw.Expanded(
                              flex: 1,
                              child: pw.Text(
                                guestmodels[index].status!,
                                style: pw.TextStyle(
                                    fontNormal: ttf,
                                    color: const PdfColor.fromInt(0xffff158DCE),
                                    fontSize: 16.0,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf),
                              ),
                            ),
                          ],
                        ),
                      )),
            ]));
    return pdf.save();
  }

  Future<void> savepdffile(String filename, Uint8List bytelist) async {
    final output = await getTemporaryDirectory();
    var filepath = "${output.path}/$filename.pdf";
    final file = File(filepath);
    await file.writeAsBytes(bytelist);
    await OpenFile.open(filepath);
  }
}
