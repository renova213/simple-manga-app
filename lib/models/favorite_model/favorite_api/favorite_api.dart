import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';

class FavoriteApi {
  static postFavoriteKomik({FavoriteModel? postfavorite}) async {
    await Dio().post(
        "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite.json",
        data: jsonEncode(postfavorite));
  }

  static getFavorite() async {
    List<FavoriteModel> favoriteList = [];
    final response = await Dio().get(
        "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite.json");

    (response.data as Map<String, dynamic>).forEach((key, value) {
      favoriteList.add(FavoriteModel(
          chapters: value['chapters'],
          caraBaca: value['caraBaca'],
          gambar: value['gambar'],
          genre: value['genre'],
          jenisKomik: value['jenisKomik'],
          judul: value['judul'],
          judulIndonesia: value['judulIndonesia'],
          sinopsis: value['sinopsis'],
          status: value['status'],
          umurPembaca: value['umurPembaca'],
          jumlahPembaca: value['jumlahPembaca'],
          key: key));
    });

    return favoriteList;
  }

  static deleteFavorite({key}) async {
    await Dio().delete(
        "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite/$key.json");
  }
}
