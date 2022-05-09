import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_time/components/carousel.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/view/detail/detail_screen.dart';
import 'package:manga_time/view/home/home_screen_view_model.dart';
import 'package:manga_time/view/home/popular_screen.dart';
import 'package:manga_time/view/home/update_terbaru_screen.dart';
import 'package:manga_time/view/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var homeViewModel =
          Provider.of<HomeScreenViewModel>(context, listen: false);

      await homeViewModel.getKomikList();
      await homeViewModel.getPopularList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeScreenViewModel>(context);
    if (homeViewModel.komikList.isEmpty || homeViewModel.popularList.isEmpty) {
      return const Center(child: Loading());
    }
    return Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white54,
          title: Text("MangaTime",
              style: GoogleFonts.modak(color: Colors.red, fontSize: 22)),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchManga());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.red,
                ))
          ],
        ),
        body: ListView(children: [
          Column(
            children: [
              const SizedBox(height: 200, child: Carousel()),
              listCategory(
                  context,
                  "Recent Update",
                  const UpdateTerbaruScreen(title: "Update Terbaru"),
                  homeViewModel.komikList),
              const SizedBox(
                height: 10,
              ),
              listCategory(
                  context,
                  "Popular",
                  const PopularScreen(title: "Popular"),
                  homeViewModel.popularList),
            ],
          ),
        ]));
  }

  Widget listCategory(context, title, child, endpoint) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(NavigatorAnimation(child: child));
                },
                child:
                    Text("More >", style: TextStyle(color: Colors.grey[700])))
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
          height: 150,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(NavigatorAnimation(
                        child: DetailScreen(
                            chapters: endpoint[index].chapters,
                            umurPembaca: endpoint[index].umurPembaca,
                            status: endpoint[index].status,
                            jenisKomik: endpoint[index].jenisKomik,
                            genre: endpoint[index].genre,
                            caraBaca: endpoint[index].caraBaca,
                            judul: endpoint[index].judul,
                            gambar: endpoint[index].gambar,
                            sinopsis: endpoint[index].sinopsis,
                            judulIndonesia: endpoint[index].judulIndonesia,
                            jumlahPembaca: endpoint[index].jumlahPembaca)));
                  },
                  child: Column(children: [
                    Expanded(
                        flex: 8,
                        child: AspectRatio(
                          aspectRatio: 3.5 / 4,
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
                              imageUrl: endpoint[index].gambar,
                              fit: BoxFit.fill,
                            )),
                          ),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: 120,
                      child: Center(
                        child: Text(
                          endpoint[index].judul,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ]),
                );
              })))
    ]);
  }
}
