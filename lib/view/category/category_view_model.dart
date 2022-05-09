import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/category_model/category_api/category_api.dart';
import 'package:manga_time/models/category_model/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  List<CategoryModel> _mangaList = [];
  List get mangaList => _mangaList;

  List<CategoryModel> _manhwaList = [];
  List get manhwaList => _manhwaList;

  List<CategoryModel> _manhuaList = [];
  List get manhuaList => _manhuaList;

  getMangaList() async {
    var getMangaList = await CategoryApi.getCategoryList(endpoint: "manga");
    _mangaList = getMangaList;
    notifyListeners();
  }

  getManhwaList() async {
    var getManhwaList = await CategoryApi.getCategoryList(endpoint: "manhwa");
    _manhwaList = getManhwaList;
    notifyListeners();
  }

  getManhuaList() async {
    var getManhuaList = await CategoryApi.getCategoryList(endpoint: "manhua");
    _manhuaList = getManhuaList;
    notifyListeners();
  }
}
