import 'dart:io';
import 'dart:ui';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:train_charts/train_seat_json_edit/berth_info.dart';
import 'package:train_charts/train_seat_json_edit/coach_info.dart';

Future<void> createPDF(CoachInfo coachInfo) async {
  List<BerthInfo> berthInfo = coachInfo.bdd;
  final PdfDocument document = PdfDocument();
  final PdfPage page = document.pages.add();
  document.pageSettings.size = PdfPageSize.a4;
  page.graphics.drawString(
    'Coach Name: ${coachInfo.coachName}',
    PdfStandardFont(
      PdfFontFamily.helvetica,
      12,
      style: PdfFontStyle.underline,
    ),
    bounds: const Rect.fromLTWH(0, 0, 200, 50),
  );
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.cells[0].value = 'Berth';
  headerRow.cells[1].value = 'From';
  headerRow.cells[2].value = 'To';
  headerRow.cells[3].value = 'Occupancy';
  headerRow.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold);
  for (var berth in berthInfo) {
    for (var occupancy in berth.bsd) {
      PdfGridRow row = grid.rows.add();
      row.height = 12;
      row.style.font =
          PdfStandardFont(PdfFontFamily.helvetica, 8, style: PdfFontStyle.bold);
      if (occupancy.occupancy) {
        row.style.backgroundBrush = PdfBrushes.mistyRose;
      }

      row.cells[0].value = berth.berthNo.toString();
      row.cells[1].value = occupancy.from;
      row.cells[2].value = occupancy.to;
      row.cells[3].value = occupancy.occupancy ? 'Occupied' : 'Vacant';
      if (occupancy == berth.bsd.last) {
        row.cells[0].style = PdfGridCellStyle(
            borders: PdfBorders(
                bottom: PdfPen.fromBrush(PdfBrushes.black, width: 3.0)));
        row.cells[1].style = PdfGridCellStyle(
            borders: PdfBorders(
                bottom: PdfPen.fromBrush(PdfBrushes.black, width: 3.0)));
        row.cells[2].style = PdfGridCellStyle(
            borders: PdfBorders(
                bottom: PdfPen.fromBrush(PdfBrushes.black, width: 3.0)));
        row.cells[3].style = PdfGridCellStyle(
            borders: PdfBorders(
                bottom: PdfPen.fromBrush(PdfBrushes.black, width: 3.0)));
      }
    }
  }
  grid.style.cellPadding = PdfPaddings(
    left: 5,
  );
  grid.draw(
    page: page,
    bounds: Rect.fromLTWH(
        0, 30, page.getClientSize().width / 2.5, page.getClientSize().height),
  );

  List<int> bytes = document.save();
  document.dispose();
  saveAndLaunchFile(bytes, 'output.pdf');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getApplicationDocumentsDirectory()).path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
