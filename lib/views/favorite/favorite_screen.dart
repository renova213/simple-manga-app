import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';
import 'package:manga_time/views/favorite/favorite_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<FavoriteViewModel>(context, listen: false).getFavorite();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteViewModel>(context);
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
                                                index: favorite
                                                    .favoriteList[index])));
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
                                                      index);
                                                  Fluttertoast.showToast(
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
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
