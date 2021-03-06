import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';
import 'package:manga_time/views/home/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  CarouselController carouselController = CarouselController();

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<HomeScreenViewModel>(context, listen: false).getBannerList();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var banner = Provider.of<HomeScreenViewModel>(context);
    return Column(
      children: [
        Expanded(
            child: CarouselSlider(
          items: [
            for (var i = 0; i < banner.bannerList.length; i++)
              Stack(children: [
                ClipRRect(
                  child: AspectRatio(
                      aspectRatio: 2.0,
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                        placeholder: (context, url) {
                          return const Center(child: Loading());
                        },
                        imageUrl: banner.bannerList[i].gambar,
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                    bottom: 10,
                    left: 250,
                    child: SizedBox(
                      height: 25,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ))),
                          onPressed: () {
                            Navigator.of(context).push(NavigatorAnimation(
                                child:
                                    DetailScreen(index: banner.bannerList[i])));
                          },
                          child: const Text(
                            "Read Now",
                            style: TextStyle(color: Colors.black),
                          )),
                    ))
              ])
          ],
          carouselController: carouselController,
          options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 2.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banner.bannerList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
