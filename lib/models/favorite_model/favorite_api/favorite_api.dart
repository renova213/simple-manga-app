import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';

class FavoriteApi {
  static postFavoriteKomik(
      {caraBaca,
      gambar,
      genre,
      jenisKomik,
      judul,
      judulIndonesia,
      jumlahPembaca,
      sinopsis,
      status,
      umurPembaca,
      chapters}) async {
    await Dio().post(
        "https://emailpasswordauth-1dc31-default-rtdb.firebaseio.com/favorite.json",
        data: jsonEncode({
          'caraBaca': caraBaca.toString(),
          'gambar': gambar.toString(),
          'genre': genre.toString(),
          'jenisKomik': jenisKomik.toString(),
          'judul': judul.toString(),
          'judulIndonesia': judulIndonesia.toString(),
          'jumlahPembaca': jumlahPembaca.toString(),
          'sinopsis': sinopsis.toString(),
          'status': status.toString(),
          'umurPembaca': umurPembaca.toString(),
          'chapters': chapters
        }));
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
