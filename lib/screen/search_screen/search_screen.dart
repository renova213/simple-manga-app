import 'package:flutter/material.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/models/search_model/search_api/search_api.dart';
import 'package:manga_time/models/search_model/search_model.dart';
import 'package:manga_time/screen/detail_screen/detail_screen.dart';

class SearchManga extends SearchDelegate {
  final SearchApi _mangaList = SearchApi();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<SearchModel>>(
        future: _mangaList.getSearchList(query: query),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          }
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(NavigatorAnimation(
                        child: DetailScreen(
                            sinopsis: data[index].sinopsis,
                            judul: data[index].judul,
                            gambar: data[index].gambar,
                            chapters: data[index].chapters,
                            umurPembaca: data[index].umurPembaca,
                            judulIndonesia: data[index].judulIndonesia,
                            status: data[index].status,
                            genre: data[index].genre,
                            jenisKomik: data[index].jenisKomik,
                            caraBaca: data[index].caraBaca,
                            jumlahPembaca: data[index].jumlahPembaca)));
                  },
                  child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Material(
                                  child: Image.network(
                                      data[index].gambar.toString(),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].judul.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(data[index].genre.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      data[index].sinopsis.toString(),
                                    ),
                                  ))
                                ],
                              ),
                            ))
                          ],
                        ),
                      )));
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
          child: Text(
        "Cari berdasarkan nama atau genrenya ^^ ",
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold),
      )),
    );
  }
}
