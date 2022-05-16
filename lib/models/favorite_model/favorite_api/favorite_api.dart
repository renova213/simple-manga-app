import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mac_address/mac_address.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';

class FavoriteApi {
  Future postFavoriteKomik({FavoriteModel? postfavorite}) async {
    String platformVersion;
    try {
      platformVersion = await GetMac.macAddress;
      final response = await Dio().post(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite/$platformVersion.json",
          data: jsonEncode(postfavorite));
      return response;
    } on Exception catch (_) {
      throw Exception("Post Failed");
    }
  }

  Future<List<FavoriteModel>> getFavorite() async {
    String platformVersion;
    List<FavoriteModel> favoriteList = [];
    try {
      platformVersion = await GetMac.macAddress;
      final response = await Dio().get(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite/$platformVersion.json");

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
    } on Exception catch (_) {
      throw Exception("Failed Fetch");
    }

    return favoriteList;
  }

  Future deleteFavorite({key}) async {
    try {
      await Dio().delete(
          "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite/$key.json");
    } catch (_) {
      throw Exception("Delete Failed");
    }
  }
}
