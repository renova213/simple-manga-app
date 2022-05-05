import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteViewModel extends ChangeNotifier {
  late SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  final List<FavoriteModel> _favoriteList = [];
  List<FavoriteModel> get favoriteList => _favoriteList;
  List judulKomik = [];

  addListFavorite(FavoriteModel list, String nama) async {
    _prefs = await SharedPreferences.getInstance();
    _favoriteList.add(list);
    _favoriteList.sort(
        ((a, b) => a.judul!.toLowerCase().compareTo(b.judul!.toLowerCase())));
    judulKomik.add(nama);
  }

  removeListFavorite(int index, String judul) {
    _favoriteList.removeAt(index);
    judulKomik.remove(judul);

    notifyListeners();
  }
}
