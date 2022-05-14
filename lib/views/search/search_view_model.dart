import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/models/search_model/search_api/search_api.dart';
import 'package:manga_time/models/search_model/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  final searchApi = SearchApi();
  List<SearchModel> _komikList = [];
  List<SearchModel> get komikList => _komikList;

  List<SearchModel> _resultList = [];
  List<SearchModel> get resultList => _resultList;

  getKomikList(query) async {
    final getKomikList = await searchApi.getKomikList();
    _komikList = getKomikList;

    if (query == "") {
      return _resultList.clear();
    } else if (query != null) {
      return _resultList = _komikList
          .where((element) =>
              element.judul!.toLowerCase().contains(query.toLowerCase()) ||
              element.genre!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
