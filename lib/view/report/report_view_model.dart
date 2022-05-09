import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/report_model/report_api/report_api.dart';

class ReportViewModel extends ChangeNotifier {
  postReport(message) async {
    await ReportApi.sendReport(message: message);
    notifyListeners();
  }
}
