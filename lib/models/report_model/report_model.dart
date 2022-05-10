class ReportModel {
  final String judulKomik;
  final String message;
  final String email;
  final String name;

  ReportModel(
      {required this.judulKomik,
      required this.message,
      required this.email,
      required this.name});
  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
      judulKomik: json['judulKomik'],
      message: json['message'],
      email: json['email'],
      name: json['name']);

  Map<String, dynamic> toJson() => {
        "judulKomik": judulKomik,
        "message": message,
        "email": email,
        "name": name
      };
}
