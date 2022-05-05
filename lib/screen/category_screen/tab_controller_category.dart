import 'package:flutter/material.dart';
import 'package:manga_time/screen/category_screen/manga_screen.dart';
import 'package:manga_time/screen/category_screen/manhua_screen.dart';
import 'package:manga_time/screen/category_screen/manhwa_screen.dart';

class TabContollerCategory extends StatefulWidget {
  const TabContollerCategory({Key? key}) : super(key: key);

  @override
  State<TabContollerCategory> createState() => _TabContollerCategoryState();
}

class _TabContollerCategoryState extends State<TabContollerCategory>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              controller: controller,
              indicatorWeight: 3,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
              tabs: const [
                Tab(text: "Manga"),
                Tab(text: "Manhwa"),
                Tab(text: "Manhua"),
              ]),
          Expanded(
            child: TabBarView(controller: controller, children: const [
              MangaScreen(),
              ManhwaScreen(),
              ManhuaScreen()
            ]),
          ),
        ]),
      ),
    );
  }
}
