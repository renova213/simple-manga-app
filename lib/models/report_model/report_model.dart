class ReportModel {
  final String message;

  ReportModel({required this.message});
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      ReportModel(message: json['message']);

  Map<String, dynamic> toJson() => {"message": message};
}
