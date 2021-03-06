import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';
import 'package:manga_time/views/home/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class MangaScreen extends StatefulWidget {
  const MangaScreen({Key? key}) : super(key: key);

  @override
  State<MangaScreen> createState() => _ManhwaScreenState();
}

class _ManhwaScreenState extends State<MangaScreen> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<HomeScreenViewModel>(context, listen: false).getMangaList();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeScreenViewModel>(context);
    if (viewModel.mangaList.isEmpty) {
      return const Center(child: Loading());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: viewModel.mangaList.length,
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
                                          index: viewModel.mangaList[index])));
                                },
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                  placeholder: (context, url) {
                                    return const Center(child: Loading());
                                  },
                                  imageUrl: viewModel.mangaList[index].gambar,
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
                              viewModel.mangaList[index].judul,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(viewModel.mangaList[index].genre),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                viewModel.mangaList[index].sinopsis,
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
