import 'package:dio/dio.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class KomikApi {
  Future<List<KomikListModel>> getKomikList({String? endpoint}) async {
    try {
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/$endpoint.json");

      final mangaList = (response.data as List)
          .map((e) => KomikListModel(
              chapters: e['chapters'],
              caraBaca: e['caraBaca'],
              gambar: e['gambar'],
              genre: e['genre'],
              jenisKomik: e['jenisKomik'],
              judul: e['judul'],
              judulIndonesia: e['judulIndonesia'],
              sinopsis: e['sinopsis'],
              status: e['status'],
              umurPembaca: e['umurPembaca'],
              jumlahPembaca: e['jumlahPembaca'],
              date: e['date']))
          .toList();
      return mangaList;
    } on Exception catch (_) {
      throw Exception("Failed Fetch");
    }
  }
}
