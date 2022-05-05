import 'package:flutter/material.dart';
import 'package:manga_time/components/navigator_animation.dart';
import 'package:manga_time/screen/home_screen/botnavbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(NavigatorAnimation(child: const BotNavBar()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
              ),
              Positioned(
                  right: 10,
                  top: 0,
                  child: Image.asset('assets/logo.png',
                      fit: BoxFit.fill, height: 70, width: 70)),
              Positioned(
                right: 80,
                top: 20,
                child: Text(
                  'MangaTime',
                  style: GoogleFonts.modak(color: Colors.red, fontSize: 45),
                ),
              ),
            ],
          ),
          const Text(
            'Baca Komik \n Bahasa Indonesia',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          const SpinKitThreeBounce(
            color: Colors.red,
            size: 40,
          )
        ],
      )),
    );
  }
}
