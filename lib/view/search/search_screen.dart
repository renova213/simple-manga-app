import 'package:flutter/material.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/view/detail/detail_screen.dart';
import 'package:manga_time/view/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchManga extends SearchDelegate {
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
    final viewModel = Provider.of<SearchViewModel>(context);
    return FutureBuilder(
        future: viewModel.getKomikList(query),
        builder: (context, snapshot) {
          if (viewModel.resultList.isEmpty) {
            return (Center(
              child: Text(
                "Komik Yang Dicari Tidak Ada",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ));
          }
          return ListView.builder(
            itemCount: viewModel.resultList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(NavigatorAnimation(
                        child: DetailScreen(
                            sinopsis: viewModel.resultList[index].sinopsis,
                            judul: viewModel.resultList[index].judul,
                            gambar: viewModel.resultList[index].gambar,
                            chapters: viewModel.resultList[index].chapters,
                            umurPembaca:
                                viewModel.resultList[index].umurPembaca,
                            judulIndonesia:
                                viewModel.resultList[index].judulIndonesia,
                            status: viewModel.resultList[index].status,
                            genre: viewModel.resultList[index].genre,
                            jenisKomik: viewModel.resultList[index].jenisKomik,
                            caraBaca: viewModel.resultList[index].caraBaca,
                            jumlahPembaca:
                                viewModel.resultList[index].jumlahPembaca)));
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
                                      viewModel.resultList[index].gambar
                                          .toString(),
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
                                    viewModel.resultList[index].judul
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(viewModel.resultList[index].genre
                                      .toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      viewModel.resultList[index].sinopsis
                                          .toString(),
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
