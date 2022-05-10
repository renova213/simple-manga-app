import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';
import 'package:manga_time/view/detail/chapter_screen.dart';
import 'package:manga_time/view/favorite/favorite_view_model.dart';
import 'package:manga_time/view/report/report_screen.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final List? chapters;
  final String? jumlahPembaca;
  final String? caraBaca;
  final String? gambar;
  final String? genre;
  final String? jenisKomik;
  final String? judul;
  final String? judulIndonesia;
  final String? sinopsis;
  final String? status;
  final String? umurPembaca;
  const DetailScreen(
      {Key? key,
      this.chapters,
      this.jumlahPembaca,
      this.caraBaca,
      this.gambar,
      this.genre,
      this.jenisKomik,
      this.judul,
      this.judulIndonesia,
      this.sinopsis,
      this.status,
      this.umurPembaca})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final favorite = Provider.of<FavoriteViewModel>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Stack(children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.gambar.toString()),
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
                      Expanded(
                        child: Text(
                          widget.judul.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(NavigatorAnimation(
                                child: ReportScreen(
                                    judul: widget.judul.toString())));
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
                                (element) =>
                                    element.judul!.contains(widget.judul));
                            if (contains.isNotEmpty) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Komik Ini Sudah Ada Di Daftar Favorite");
                            } else {
                              favorite.postFavorite(FavoriteModel(
                                  caraBaca: widget.caraBaca,
                                  gambar: widget.gambar,
                                  genre: widget.genre,
                                  jenisKomik: widget.jenisKomik,
                                  judul: widget.judul,
                                  judulIndonesia: widget.judulIndonesia,
                                  jumlahPembaca: widget.jumlahPembaca,
                                  sinopsis: widget.sinopsis,
                                  status: widget.status,
                                  umurPembaca: widget.umurPembaca,
                                  chapters: widget.chapters));
                              Fluttertoast.showToast(
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
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Sinopsis : ${widget.sinopsis.toString()}"),
            const SizedBox(
              height: 10,
            ),
            tableCustom("Judul Indonesia", widget.judulIndonesia.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Jenis Komik", widget.jenisKomik.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Konsep Cerita", widget.genre.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Status", widget.status.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Umur Pembaca", widget.umurPembaca.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Jumlah Pembaca", widget.jumlahPembaca.toString()),
            const SizedBox(
              height: 5,
            ),
            tableCustom("Cara Baca", widget.caraBaca.toString()),
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
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 250, child: listChapter(widget.chapters))
          ]),
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
