import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/favorite_model/favorite_api/favorite_api.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final favoriteApi = FavoriteApi();
  List<FavoriteModel> _favoriteList = [];
  List get favoriteList => _favoriteList;

  List tempValidatorFavorite = [];

  postFavorite(favorite, judulKomik) async {
    await favoriteApi.postFavoriteKomik(postfavorite: favorite);
    tempValidatorFavorite.add(judulKomik);
    notifyListeners();
  }

  getFavorite() async {
    final getFavorite = await favoriteApi.getFavorite();
    _favoriteList = getFavorite;
    _favoriteList.sort(
        ((a, b) => a.judul!.toLowerCase().compareTo(b.judul!.toLowerCase())));
    notifyListeners();
  }

  removeListFavorite(key, index) async {
    await favoriteApi.deleteFavorite(
      key: key,
    );
    _favoriteList.removeAt(index);
    notifyListeners();
  }
}
