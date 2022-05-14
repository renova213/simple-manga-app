import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manga_time/models/report_model/report_model.dart';

class ReportApi {
  static Future sendReport({ReportModel? report}) async {
    try {
      var response =
          await Dio().post("https://api.emailjs.com/api/v1.0/email/send",
              options: Options(headers: {
                'origin': 'http://localhost',
                'Content-Type': 'application/json',
              }),
              data: jsonEncode({
                'service_id': 'service_6lw1pun',
                'template_id': 'template_vs58srs',
                'user_id': 'X7q8O0RPBcKptSUNi',
                'template_params': report
              }));
      return response;
    } on Exception catch (_) {
      throw Exception("Failed Post");
    }
  }
}
