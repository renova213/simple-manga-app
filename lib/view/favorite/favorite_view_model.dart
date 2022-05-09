import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/favorite_model/favorite_api/favorite_api.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<FavoriteModel> _favoriteList = [];
  List get favoriteList => _favoriteList;
  List judulKomik = [];

  postFavorite(
      caraBaca,
      gambar,
      genre,
      jenisKomik,
      judul,
      judulIndonesia,
      jumlahPembaca,
      sinopsis,
      status,
      umurPembaca,
      chapters,
      judulIndex) async {
    await FavoriteApi.postFavoriteKomik(
        caraBaca: caraBaca,
        gambar: gambar,
        genre: genre,
        jenisKomik: jenisKomik,
        judul: judul,
        judulIndonesia: judulIndonesia,
        jumlahPembaca: jumlahPembaca,
        sinopsis: sinopsis,
        status: status,
        umurPembaca: umurPembaca,
        chapters: chapters);

    judulKomik.add(judulIndex);
  }

  getFavorite() async {
    final getFavorite = await FavoriteApi.getFavorite();
    _favoriteList = getFavorite as List<FavoriteModel>;
    _favoriteList.sort(
        ((a, b) => a.judul!.toLowerCase().compareTo(b.judul!.toLowerCase())));
    notifyListeners();
  }

  removeListFavorite(key, judulIndex, index) async {
    await FavoriteApi.deleteFavorite(
      key: key,
    );
    _favoriteList.removeAt(index);

    judulKomik.remove(judulIndex);
    notifyListeners();
  }
}
