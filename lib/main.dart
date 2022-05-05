import 'package:flutter/material.dart';
import 'package:manga_time/screen/category_screen/category_view_model.dart';
import 'package:manga_time/screen/favorite_screen/favorite_view_model.dart';
import 'package:manga_time/screen/home_screen/home_screen_view_model.dart';
import 'package:manga_time/screen/report_screen/report_view_model.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeScreenViewModel>(
          create: (_) => HomeScreenViewModel(),
        ),
        ChangeNotifierProvider<CategoryViewModel>(
          create: (_) => CategoryViewModel(),
        ),
        ChangeNotifierProvider<FavoriteViewModel>(
          create: (_) => FavoriteViewModel(),
        ),
        ChangeNotifierProvider<ReportViewModel>(
          create: (_) => ReportViewModel(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
