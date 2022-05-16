import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_time/views/home/carousel.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';
import 'package:manga_time/views/home/home_screen_view_model.dart';
import 'package:manga_time/views/home/more_screen.dart';
import 'package:manga_time/components/search.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<HomeScreenViewModel>(context, listen: false).getKomikList();
      Provider.of<HomeScreenViewModel>(context, listen: false).getPopularList();
      Provider.of<HomeScreenViewModel>(context, listen: false).getIsekaiList();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeScreenViewModel>(context);
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
                  MoreScreen(
                      title: "Update Terbaru",
                      endpoint: homeViewModel.komikList),
                  homeViewModel.komikList),
              const SizedBox(
                height: 10,
              ),
              listCategory(
                  context,
                  "Popular",
                  MoreScreen(
                      title: "Popular", endpoint: homeViewModel.popularList),
                  homeViewModel.popularList),
              const SizedBox(
                height: 10,
              ),
              listCategory(
                  context,
                  "Isekai",
                  MoreScreen(title: "Isekai", endpoint: homeViewModel.isekai),
                  homeViewModel.isekai),
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
                if (endpoint.isEmpty) {
                  return const Center(child: Loading());
                }
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
                            jumlahPembaca:
                                endpoint[index].jumlahPembaca.toString())));
                  },
                  child: Column(children: [
                    Expanded(
                        flex: 8,
                        child: AspectRatio(
                          aspectRatio: 3.5 / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error,
                                    color: Colors.red);
                              },
                              placeholder: (context, url) {
                                return const Center(child: Loading());
                              },
                              imageUrl: endpoint[index].gambar,
                              fit: BoxFit.cover,
                            ),
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
