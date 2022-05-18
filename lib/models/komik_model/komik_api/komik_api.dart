import 'package:dio/dio.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class GetList {
  Future<List<KomikListModel>> getKomikList() async {
    try {
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/komik.json");

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

  Future<List<KomikListModel>> getBannersList() async {
    try {
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/banners.json");

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
