import 'package:dio/dio.dart';
import 'package:manga_time/models/category_model/category_model.dart';

class CategoryApi {
  Future<List<CategoryModel>> getCategoryList({String? endpoint}) async {
    try {
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/$endpoint.json");
      var mangaList = (response.data as List)
          .map((e) => CategoryModel(
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
