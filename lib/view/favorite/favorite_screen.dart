import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/view/detail/detail_screen.dart';
import 'package:manga_time/view/favorite/favorite_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var homeViewModel =
          Provider.of<FavoriteViewModel>(context, listen: false);

      await homeViewModel.getFavorite();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteViewModel>(context);
    if (favorite.favoriteList.isEmpty) {
      return const Center(child: Text("Empty"));
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text("Favorite Screen",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: favorite.favoriteList.length,
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
                                                sinopsis: favorite
                                                    .favoriteList[index]
                                                    .sinopsis,
                                                judul: favorite
                                                    .favoriteList[index].judul,
                                                gambar: favorite
                                                    .favoriteList[index].gambar,
                                                chapters: favorite
                                                    .favoriteList[index]
                                                    .chapters,
                                                umurPembaca: favorite
                                                    .favoriteList[index]
                                                    .umurPembaca,
                                                judulIndonesia: favorite
                                                    .favoriteList[index]
                                                    .judulIndonesia,
                                                status: favorite
                                                    .favoriteList[index].status,
                                                genre: favorite
                                                    .favoriteList[index].genre,
                                                jenisKomik: favorite
                                                    .favoriteList[index]
                                                    .jenisKomik,
                                                caraBaca: favorite
                                                    .favoriteList[index]
                                                    .caraBaca,
                                                jumlahPembaca: favorite
                                                    .favoriteList[index]
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
                                        favorite.favoriteList[index].gambar!,
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
                                favorite.favoriteList[index].judul!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(favorite.favoriteList[index].genre!),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  favorite.favoriteList[index].sinopsis!,
                                ),
                              ))
                            ],
                          ),
                        )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Apakah Yakin Ingin Dihapus?"),
                                      content: SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  favorite.removeListFavorite(
                                                      favorite
                                                          .favoriteList[index]
                                                          .key,
                                                      favorite
                                                          .favoriteList[index]
                                                          .judul!,
                                                      index);
                                                  Fluttertoast.showToast(
                                                      msg: "Berhasil Dihapus");
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Yes")),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("No"))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
