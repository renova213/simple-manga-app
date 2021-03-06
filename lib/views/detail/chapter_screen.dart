import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_time/models/radio_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterScreen extends StatefulWidget {
  final List imagesChapter;
  final int indexChapter;
  const ChapterScreen(
      {Key? key, required this.imagesChapter, required this.indexChapter})
      : super(key: key);

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _group = 1;
  bool _isHorizontal = false;

  final List<RadioModel> _listRadio = [
    RadioModel(index: 1, name: 'Vertical'),
    RadioModel(index: 2, name: 'Horizontal')
  ];

  void checkReadingMode() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.getBool('isHorizontal') == true) {
      setState(() {
        _isHorizontal = true;
        _group = 2;
      });
    } else {
      setState(() {
        _isHorizontal = false;
        _group = 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkReadingMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.black54,
            title: Text("Chapter ${widget.indexChapter.toString()}"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _viewSettings();
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
        ],
        body: PhotoViewGallery.builder(
          scrollDirection: _isHorizontal ? Axis.horizontal : Axis.vertical,
          itemCount: widget.imagesChapter.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
                  CachedNetworkImageProvider(widget.imagesChapter[index]),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 2.0,
              initialScale: PhotoViewComputedScale.contained * 1.0,
            );
          },
          loadingBuilder: (context, event) {
            return SizedBox(
                width: 80,
                height: 80,
                child: Center(child: Image.asset("assets/chibi.gif")));
          },
        ),
      ),
    );
  }

  void _viewSettings() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text(
              'Reading Mode',
              style: TextStyle(color: Colors.white),
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                  children: _listRadio.map((e) {
                return RadioListTile(
                  title: Text(
                    e.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: e.index,
                  dense: true,
                  groupValue: _group,
                  activeColor: Colors.red,
                  onChanged: (newValue) async {
                    final SharedPreferences prefs = await _prefs;
                    if (e.name == 'Vertical') {
                      setState(() {
                        prefs.setBool('isHorizontal', false);
                        _isHorizontal = false;
                      });
                    } else {
                      setState(() {
                        prefs.setBool('isHorizontal', true);
                        _isHorizontal = true;
                      });
                    }
                    setState(() {
                      _group = int.parse(newValue.toString());
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList()),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
