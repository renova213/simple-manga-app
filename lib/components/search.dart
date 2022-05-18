import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';
import 'package:manga_time/views/home/home_screen_view_model.dart';
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
    final viewModel = Provider.of<HomeScreenViewModel>(context);
    return FutureBuilder(
        future: viewModel.searchComic(query: query),
        builder: (context, snapshot) {
          if (viewModel.result.isEmpty) {
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
            itemCount: viewModel.result.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(NavigatorAnimation(
                        child: DetailScreen(index: viewModel.result[index])));
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
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                    placeholder: (context, url) {
                                      return const Center(child: Loading());
                                    },
                                    imageUrl: viewModel.result[index].gambar
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
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
                                    viewModel.result[index].judul.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      viewModel.result[index].genre.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      viewModel.result[index].sinopsis
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
