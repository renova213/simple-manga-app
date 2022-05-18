import 'package:flutter/material.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final komikApi = GetList();
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

  List<KomikListModel> _mangaList = [];
  List get mangaList => _mangaList;

  List<KomikListModel> _manhwaList = [];
  List get manhwaList => _manhwaList;

  List<KomikListModel> _manhuaList = [];
  List get manhuaList => _manhuaList;

  getKomikList() async {
    final getKomikList = await komikApi.getKomikList();
    _komikList = getKomikList;
    _komikList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getBannerList() async {
    final getBannerList = await komikApi.getBannersList();
    _bannerList = getBannerList;
    notifyListeners();
  }

  getPopularList() async {
    final getPopularList = await komikApi.getKomikList();
    _popularList = getPopularList;
    _popularList.sort((b, a) => a.jumlahPembaca!.compareTo(b.jumlahPembaca!));
    notifyListeners();
  }

  getIsekaiList() async {
    final getIsekaiList = await komikApi.getKomikList();
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

  getMangaList() async {
    final getMangaList = await komikApi.getKomikList();
    _mangaList = getMangaList
        .where((element) => element.jenisKomik!.toLowerCase().contains("manga"))
        .toList();
    _mangaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getManhwaList() async {
    final getManhwaList = await komikApi.getKomikList();
    _manhwaList = getManhwaList
        .where(
            (element) => element.jenisKomik!.toLowerCase().contains("manhwa"))
        .toList();
    _manhwaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getManhuaList() async {
    final getManhuaList = await komikApi.getKomikList();
    _manhuaList = getManhuaList
        .where(
            (element) => element.jenisKomik!.toLowerCase().contains("manhua"))
        .toList();
    _manhuaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }
}
