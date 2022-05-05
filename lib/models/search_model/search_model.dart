class SearchModel {
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

  SearchModel(
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

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
