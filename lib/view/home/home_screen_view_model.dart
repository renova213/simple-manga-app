import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  List<KomikListModel> _komikList = [];
  List get komikList => _komikList;

  List<KomikListModel> _bannerList = [];
  List get bannerList => _bannerList;

  List<KomikListModel> _popularList = [];
  List get popularList => _popularList;

  getKomikList({String? query}) async {
    final getKomikList = await KomikApi.getKomikList(endpoint: "komik");
    _komikList = getKomikList;
    notifyListeners();
  }

  getBannerList() async {
    final getBannerList = await KomikApi.getKomikList(endpoint: "banners");
    _bannerList = getBannerList;
  }

  getPopularList() async {
    final getPopularList = await KomikApi.getKomikList(endpoint: "popular");
    _popularList = getPopularList;
    notifyListeners();
  }
}
