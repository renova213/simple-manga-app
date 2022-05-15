import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final komikApi = KomikApi();
  List<KomikListModel> _komikList = [];
  List get komikList => _komikList;

  List<KomikListModel> _bannerList = [];
  List get bannerList => _bannerList;

  List<KomikListModel> _popularList = [];
  List get popularList => _popularList;

  List<KomikListModel> _result = [];
  List get result => _result;

  getKomikList() async {
    final getKomikList = await komikApi.getKomikList(endpoint: "komik");
    _komikList = getKomikList;
    notifyListeners();
  }

  getBannerList() async {
    final getBannerList = await komikApi.getKomikList(endpoint: "banners");
    _bannerList = getBannerList;
    notifyListeners();
  }

  getPopularList() async {
    final getPopularList = await komikApi.getKomikList(endpoint: "popular");
    _popularList = getPopularList;
    notifyListeners();
  }

  searchComic({String? query}) async {
    if (query == "") {
      return _result.clear();
    } else if (query != null) {
      return _result = _komikList
          .where((element) =>
              element.judul!.toLowerCase().contains(query.toLowerCase()) ||
              element.genre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
