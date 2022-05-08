import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/screen/detail_screen/detail_screen.dart';
import 'package:manga_time/screen/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatefulWidget {
  final String? title;
  const PopularScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var homeViewModel =
          Provider.of<HomeScreenViewModel>(context, listen: false);
      await homeViewModel.getPopularList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeScreenViewModel>(context);
    if (viewModel.popularList.isEmpty) {
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
            itemCount: viewModel.popularList.length,
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
                                                    .popularList[index]
                                                    .sinopsis,
                                                judul: viewModel
                                                    .popularList[index].judul,
                                                gambar: viewModel
                                                    .popularList[index].gambar,
                                                chapters: viewModel
                                                    .popularList[index]
                                                    .chapters,
                                                umurPembaca: viewModel
                                                    .popularList[index]
                                                    .umurPembaca,
                                                judulIndonesia: viewModel
                                                    .popularList[index]
                                                    .judulIndonesia,
                                                status: viewModel
                                                    .popularList[index].status,
                                                genre: viewModel
                                                    .popularList[index].genre,
                                                jenisKomik: viewModel
                                                    .popularList[index]
                                                    .jenisKomik,
                                                caraBaca: viewModel
                                                    .popularList[index]
                                                    .caraBaca,
                                                jumlahPembaca: viewModel
                                                    .popularList[index]
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
                                    imageUrl:
                                        viewModel.popularList[index].gambar,
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
                                viewModel.popularList[index].judul,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(viewModel.popularList[index].genre),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  viewModel.popularList[index].sinopsis,
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
