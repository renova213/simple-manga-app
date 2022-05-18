import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/components/loading.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/views/detail/detail_screen.dart';

class MoreScreen extends StatefulWidget {
  final String? title;
  final List? endpoint;
  const MoreScreen({Key? key, this.title, this.endpoint}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
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
            itemCount: widget.endpoint!.length,
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
                                                index:
                                                    widget.endpoint![index])));
                                  },
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                    placeholder: (context, url) {
                                      return const Center(child: Loading());
                                    },
                                    imageUrl: widget.endpoint![index].gambar,
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
                                widget.endpoint![index].judul,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(widget.endpoint![index].genre),
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.endpoint![index].sinopsis,
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
