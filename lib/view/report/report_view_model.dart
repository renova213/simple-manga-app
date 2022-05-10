import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/report_model/report_api/report_api.dart';

class ReportViewModel extends ChangeNotifier {
  postReport(judulKomik, message, email, name) async {
    await ReportApi.sendReport(
        judulKomik: judulKomik, message: message, email: email, name: name);
    notifyListeners();
  }
}
