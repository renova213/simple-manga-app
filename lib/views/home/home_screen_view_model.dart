import 'package:flutter/material.dart';
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

  List<KomikListModel> _isekai = [];
  List get isekai => _isekai;

  getKomikList() async {
    final getKomikList = await komikApi.getKomikList(endpoint: "komik");
    _komikList = getKomikList;
    _komikList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getBannerList() async {
    final getBannerList = await komikApi.getKomikList(endpoint: "banners");
    _bannerList = getBannerList;
    notifyListeners();
  }

  getPopularList() async {
    final getPopularList = await komikApi.getKomikList(endpoint: "komik");
    _popularList = getPopularList;
    _popularList.sort((b, a) => a.jumlahPembaca!.compareTo(b.jumlahPembaca!));
    notifyListeners();
  }

  getIsekaiList() async {
    final getIsekaiList = await komikApi.getKomikList(endpoint: "komik");
    _isekai = getIsekaiList
        .where((element) => element.genre!.toLowerCase().contains("isekai"))
        .toList();
    _isekai.sort((b, a) => a.date!.compareTo(b.date!));
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
