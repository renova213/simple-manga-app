import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/screen/category_screen/category_view_model.dart';
import 'package:manga_time/screen/detail_screen/detail_screen.dart';
import 'package:provider/provider.dart';

class ManhwaScreen extends StatefulWidget {
  const ManhwaScreen({Key? key}) : super(key: key);

  @override
  State<ManhwaScreen> createState() => _ManhwaScreenState();
}

class _ManhwaScreenState extends State<ManhwaScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var homeViewModel =
          Provider.of<CategoryViewModel>(context, listen: false);
      await homeViewModel.getManhwaList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CategoryViewModel>(context);
    if (viewModel.manhwaList.isEmpty) {
      return const Center(child: Loading());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: viewModel.manhwaList.length,
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
                                              .manhwaList[index].sinopsis,
                                          judul:
                                              viewModel.manhwaList[index].judul,
                                          gambar: viewModel
                                              .manhwaList[index].gambar,
                                          chapters: viewModel
                                              .manhwaList[index].chapters,
                                          umurPembaca: viewModel
                                              .manhwaList[index].umurPembaca,
                                          judulIndonesia: viewModel
                                              .manhwaList[index].judulIndonesia,
                                          status: viewModel
                                              .manhwaList[index].status,
                                          genre:
                                              viewModel.manhwaList[index].genre,
                                          jenisKomik: viewModel
                                              .manhwaList[index].jenisKomik,
                                          caraBaca: viewModel
                                              .manhwaList[index].caraBaca,
                                          jumlahPembaca: viewModel
                                              .manhwaList[index]
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
                                  imageUrl: viewModel.manhwaList[index].gambar,
                                  fit: BoxFit.fill,
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
                              viewModel.manhwaList[index].judul,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(viewModel.manhwaList[index].genre),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                viewModel.manhwaList[index].sinopsis,
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
