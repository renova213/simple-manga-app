import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/screen/detail_screen/detail_screen.dart';
import 'package:manga_time/screen/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class UpdateTerbaruScreen extends StatefulWidget {
  final String? title;
  const UpdateTerbaruScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<UpdateTerbaruScreen> createState() => _UpdateTerbaruScreenState();
}

class _UpdateTerbaruScreenState extends State<UpdateTerbaruScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var homeViewModel =
          Provider.of<HomeScreenViewModel>(context, listen: false);
      await homeViewModel.getKomikList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeScreenViewModel>(context);
    if (viewModel.komikList.isEmpty) {
      return const Center(child: Loading());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(widget.title.toString(),
            style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: viewModel.komikList.length,
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
                                    Navigator.of(context).push(
                                        NavigatorAnimation(
                                            child: DetailScreen(
                                                sinopsis: viewModel
                                                    .komikList[index].sinopsis,
                                                judul: viewModel
                                                    .komikList[index].judul,
                                                gambar: viewModel
                                                    .komikList[index].gambar,
                                                chapters: viewModel
                                                    .komikList[index].chapters,
                                                umurPembaca: viewModel
                                                    .komikList[index]
                                                    .umurPembaca,
                                                judulIndonesia: viewModel
                                                    .komikList[index]
                                                    .judulIndonesia,
                                                status: viewModel
                                                    .komikList[index].status,
                                                genre: viewModel
                                                    .komikList[index].genre,
                                                jenisKomik: viewModel
                                                    .komikList[index]
                                                    .jenisKomik,
                                                caraBaca: viewModel
                                                    .komikList[index].caraBaca,
                                                jumlahPembaca: viewModel
                                                    .komikList[index]
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
                                    imageUrl: viewModel.komikList[index].gambar,
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
                                viewModel.komikList[index].judul,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(viewModel.komikList[index].genre),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  viewModel.komikList[index].sinopsis,
                                ),
                              ))
                            ],
                          ),
                        ))
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
