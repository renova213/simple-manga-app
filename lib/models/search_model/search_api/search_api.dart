import 'package:dio/dio.dart';
import 'package:manga_time/models/search_model/search_model.dart';

class SearchApi {
  Future<List<SearchModel>> getKomikList() async {
    try {
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/komik.json");

      final mangaList = (response.data as List)
          .map((e) => SearchModel(
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
              jumlahPembaca: e['jumlahPembaca']))
          .toList();
      return mangaList;
    } on Exception catch (_) {
      throw Exception("Failed Fetch");
    }
  }
}
