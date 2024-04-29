import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateExcel() async {
  final Workbook workbook = Workbook();
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final output = await getTemporaryDirectory();
  var filepath = "${output.path}/filename.pdf";
  final file = File(filepath);
  await file.writeAsBytes(bytes);
  await OpenFile.open(filepath);
}
