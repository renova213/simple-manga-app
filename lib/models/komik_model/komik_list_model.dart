class KomikListModel {
  List? chapters;
  String? caraBaca;
  String? gambar;
  String? genre;
  String? jenisKomik;
  String? judul;
  String? judulIndonesia;
  String? sinopsis;
  String? status;
  String? umurPembaca;
  String? jumlahPembaca;

  KomikListModel(
      {this.chapters,
      this.jumlahPembaca,
      this.caraBaca,
      this.gambar,
      this.genre,
      this.jenisKomik,
      this.judul,
      this.judulIndonesia,
      this.sinopsis,
      this.status,
      this.umurPembaca});

  factory KomikListModel.fromJson(Map<String, dynamic> json) => KomikListModel(
      chapters: json['chapters'],
      jumlahPembaca: json['jumlahPembaca'],
      caraBaca: json['caraBaca'],
      gambar: json['gambar'],
      genre: json['genre'],
      jenisKomik: json['jenisKomik'],
      judul: json['judul'],
      judulIndonesia: json['judulIndonesia'],
      sinopsis: json['sinopsis'],
      status: json['status'],
      umurPembaca: json['umurPembaca']);

  Map<String, dynamic> toJson() => {
        "chapters": chapters,
        "jumlahPembaca": jumlahPembaca,
        "caraBaca": caraBaca,
        "gambar": gambar,
        "genre": genre,
        "jenisKomik": jenisKomik,
        "Genre": genre,
        "judul": judul,
        "judulIndonesia": judulIndonesia,
        "sinopsis": sinopsis,
        "status": status,
        "umurPembaca": umurPembaca,
      };
}
