import 'package:dio/dio.dart';
import 'package:manga_time/models/search_model/search_model.dart';

class SearchApi {
  // Future<List<SearchModel>> getSearchList({String? query}) async {
  //   var data = [];
  //   List<SearchModel> results = [];
  //   final response = await Dio().get(
  //       "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/komik.json");

  //   try {
  //     if (response.statusCode == 200) {
  //       data = response.data;
  //       results = data.map((e) => SearchModel.fromJson(e)).toList();
  //       if (query != null) {
  //         results = results
  //             .where((element) =>
  //                 element.judul!.toLowerCase().contains(query.toLowerCase()) ||
  //                 element.genre!.toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //       }
  //     } else {
  //       throw ("api error");
  //     }
  //   } on Exception catch (e) {
  //     throw ("error : $e");
  //   }
  //   return results;
  // }

  static getKomikList() async {
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
  }
}
