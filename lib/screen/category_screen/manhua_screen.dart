import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/screen/category_screen/category_view_model.dart';
import 'package:manga_time/screen/detail_screen/detail_screen.dart';
import 'package:provider/provider.dart';

class ManhuaScreen extends StatefulWidget {
  const ManhuaScreen({Key? key}) : super(key: key);

  @override
  State<ManhuaScreen> createState() => _ManhwaScreenState();
}

class _ManhwaScreenState extends State<ManhuaScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<CategoryViewModel>(context, listen: false);
      await viewModel.getManhuaList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CategoryViewModel>(context);
    if (viewModel.manhuaList.isEmpty) {
      return const Center(child: Loading());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: viewModel.manhuaList.length,
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
                                              .manhuaList[index].sinopsis,
                                          judul:
                                              viewModel.manhuaList[index].judul,
                                          gambar: viewModel
                                              .manhuaList[index].gambar,
                                          chapters: viewModel
                                              .manhuaList[index].chapters,
                                          umurPembaca: viewModel
                                              .manhuaList[index].umurPembaca,
                                          judulIndonesia: viewModel
                                              .manhuaList[index].judulIndonesia,
                                          status: viewModel
                                              .manhuaList[index].status,
                                          genre:
                                              viewModel.manhuaList[index].genre,
                                          jenisKomik: viewModel
                                              .manhuaList[index].jenisKomik,
                                          caraBaca: viewModel
                                              .manhuaList[index].caraBaca,
                                          jumlahPembaca: viewModel
                                              .manhuaList[index]
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
                                  imageUrl: viewModel.manhuaList[index].gambar,
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
                              viewModel.manhuaList[index].judul,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(viewModel.manhuaList[index].genre),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                viewModel.manhuaList[index].sinopsis,
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
