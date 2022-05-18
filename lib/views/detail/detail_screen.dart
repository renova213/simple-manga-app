import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';
import 'package:manga_time/views/detail/chapter_screen.dart';
import 'package:manga_time/views/favorite/favorite_view_model.dart';
import 'package:manga_time/views/report/report_screen.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final dynamic index;
  const DetailScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final favorite = Provider.of<FavoriteViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: Stack(children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.index!.gambar.toString()),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                  top: 5,
                  child: Container(
                      height: 70,
                      padding: const EdgeInsets.only(left: 10),
                      color: Colors.black54,
                      width: size.width,
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.index!.judul!.length > 17
                              ? '${widget.index!.judul!.substring(0, 17)}...'
                              : widget.index!.judul.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(NavigatorAnimation(
                                  child: ReportScreen(
                                      judul: widget.index!.judul.toString())));
                            },
                            icon: const Icon(
                              Icons.report,
                              color: Colors.white,
                              size: 30,
                            )),
                        IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              var contains = favorite.favoriteList.where(
                                  (element) => element.judul!
                                      .contains(widget.index!.judul));
                              if (contains.isNotEmpty ||
                                  favorite.tempValidatorFavorite.contains(
                                      widget.index!.judul.toString())) {
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    msg:
                                        "Komik Ini Sudah Ada Di Daftar Favorite");
                              } else {
                                favorite.postFavorite(
                                    FavoriteModel(
                                        caraBaca: widget.index!.caraBaca,
                                        gambar: widget.index!.gambar,
                                        genre: widget.index!.genre,
                                        jenisKomik: widget.index!.jenisKomik,
                                        judul: widget.index!.judul,
                                        judulIndonesia:
                                            widget.index!.judulIndonesia,
                                        jumlahPembaca:
                                            widget.index!.jumlahPembaca,
                                        sinopsis: widget.index!.sinopsis,
                                        status: widget.index!.status,
                                        umurPembaca: widget.index!.umurPembaca,
                                        chapters: widget.index!.chapters),
                                    widget.index!.judul.toString());
                                Fluttertoast.showToast(
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    msg:
                                        "Komik Berhasil Ditambahkan Ke Favorite");
                              }
                            })
                      ])))
            ])),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Info Komik",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Sinopsis : ${widget.index!.sinopsis.toString()}"),
              const SizedBox(
                height: 10,
              ),
              tableCustom(
                  "Judul Indonesia", widget.index!.judulIndonesia.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom("Jenis Komik", widget.index!.jenisKomik.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom("Konsep Cerita", widget.index!.genre.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom("Status", widget.index!.status.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom("Umur Pembaca", widget.index!.umurPembaca.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom(
                  "Jumlah Pembaca", widget.index!.jumlahPembaca.toString()),
              const SizedBox(
                height: 5,
              ),
              tableCustom("Cara Baca", widget.index!.caraBaca.toString()),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Chapter",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(height: 250, child: listChapter(widget.index!.chapters))
            ]),
          ),
        ),
      ),
    );
  }

  Widget listChapter(chapters) {
    return ListView.separated(
        itemCount: chapters.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          var count = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  NavigatorAnimation(
                      child: ChapterScreen(
                          indexChapter: count,
                          imagesChapter: chapters[index])));
            },
            child: ListTile(
              title: Text("Chapter $count"),
            ),
          );
        });
  }

  Widget tableCustom(text1, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 35,
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.grey),
              shape: BoxShape.rectangle,
              color: Colors.grey.shade300),
          child: Center(child: Text(text1)),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 35,
          width: 165,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.grey),
            shape: BoxShape.rectangle,
          ),
          child: Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Text(text2))),
        ),
      ],
    );
  }
}
