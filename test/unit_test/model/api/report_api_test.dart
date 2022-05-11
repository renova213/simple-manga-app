import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/report_model/report_api/report_api.dart';
import 'package:manga_time/models/report_model/report_model.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ReportApi])
void main() {
  test('report status == 200', () async {
    var report = await ReportApi.sendReport(
        report: ReportModel(
            judulKomik: 'One Punch Man',
            message: "Chapter 2 Tidak Bisa Dibuka",
            email: 'test@gmail.com',
            name: 'bambang'));
    expect(report.statusCode == 200, true);
  });
}
