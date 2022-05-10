import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/view/category/category_view_model.dart';
import 'package:manga_time/view/detail/detail_screen.dart';
import 'package:provider/provider.dart';

class MangaScreen extends StatefulWidget {
  const MangaScreen({Key? key}) : super(key: key);

  @override
  State<MangaScreen> createState() => _ManhwaScreenState();
}

class _ManhwaScreenState extends State<MangaScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<CategoryViewModel>(context, listen: false);
      await viewModel.getMangaList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CategoryViewModel>(context);
    if (viewModel.mangaList.isEmpty) {
      return const Center(child: Loading());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: viewModel.mangaList.length,
          itemBuilder: (context, index) {
            return SizedBox(
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
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(NavigatorAnimation(
                                      child: DetailScreen(
                                          sinopsis: viewModel
                                              .mangaList[index].sinopsis,
                                          judul:
                                              viewModel.mangaList[index].judul,
                                          gambar:
                                              viewModel.mangaList[index].gambar,
                                          chapters: viewModel
                                              .mangaList[index].chapters,
                                          umurPembaca: viewModel
                                              .mangaList[index].umurPembaca,
                                          judulIndonesia: viewModel
                                              .mangaList[index].judulIndonesia,
                                          status:
                                              viewModel.mangaList[index].status,
                                          genre:
                                              viewModel.mangaList[index].genre,
                                          jenisKomik: viewModel
                                              .mangaList[index].jenisKomik,
                                          caraBaca: viewModel
                                              .mangaList[index].caraBaca,
                                          jumlahPembaca: viewModel
                                              .mangaList[index]
                                              .jumlahPembaca)));
                                },
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                  placeholder: (context, url) {
                                    return const Center(child: Loading());
                                  },
                                  imageUrl: viewModel.mangaList[index].gambar,
                                  fit: BoxFit.cover,
                                )),
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
                              viewModel.mangaList[index].judul,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(viewModel.mangaList[index].genre),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                viewModel.mangaList[index].sinopsis,
                              ),
                            ))
                          ],
                        ),
                      ))
                    ],
                  ),
                ));
          }),
    );
  }
}
