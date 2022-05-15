import 'package:flutter/material.dart';
import 'package:manga_time/views/category/category_view_model.dart';
import 'package:manga_time/views/favorite/favorite_view_model.dart';
import 'package:manga_time/views/home/home_screen_view_model.dart';
import 'package:manga_time/views/report/report_view_model.dart';
import 'package:provider/provider.dart';
import 'components/splash_screen.dart';

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
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
