import 'package:flutter/cupertino.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';

class CategoryViewModel extends ChangeNotifier {
  final categoryApi = GetList();
  List<KomikListModel> _mangaList = [];
  List get mangaList => _mangaList;

  List<KomikListModel> _manhwaList = [];
  List get manhwaList => _manhwaList;

  List<KomikListModel> _manhuaList = [];
  List get manhuaList => _manhuaList;

  getMangaList() async {
    final getMangaList = await categoryApi.getKomikList();
    _mangaList = getMangaList
        .where((element) => element.jenisKomik!.toLowerCase().contains("manga"))
        .toList();
    _mangaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getManhwaList() async {
    final getManhwaList = await categoryApi.getKomikList();
    _manhwaList = getManhwaList
        .where(
            (element) => element.jenisKomik!.toLowerCase().contains("manhwa"))
        .toList();
    _manhwaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  getManhuaList() async {
    final getManhuaList = await categoryApi.getKomikList();
    _manhuaList = getManhuaList
        .where(
            (element) => element.jenisKomik!.toLowerCase().contains("manhua"))
        .toList();
    _manhuaList.sort((b, a) => a.date!.compareTo(b.date!));
    notifyListeners();
  }
}
