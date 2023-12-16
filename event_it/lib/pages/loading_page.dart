import 'package:event_it/pages/intro_page1.dart';
import 'package:event_it/pages/role.dart';
import 'package:event_it/utils/loading_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8), () {
      // Navigate to the main page after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroPage1(),
        ),
      );
    });

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: deviceHeight,
          width: deviceWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color.fromARGB(255, 14, 14, 15),
                // Color.fromARGB(255, 1, 1, 16),
                // Color.fromARGB(255, 2, 2, 44),
                // Color.fromARGB(255, 4, 4, 74),
                // Color.fromARGB(255, 14, 14, 108),
                Color(0xFF080710),
                Color(0xFF040114),
                Color(0xFF110463),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: deviceWidth / 2.5,
                height: deviceHeight / 2.5,
              )
                  .animate()
                  .fade(duration: 4000.ms)
                  .scale(delay: 600.ms) // runs after fade.
                  // .slide(
                  .fadeOut(duration: 10600.ms)
                  .fadeOut(curve: Curves.bounceInOut),
              0.ph,
              Text(
                "E-vent it!",
                style: LoadingTheme.appText(
                  size: deviceWidth / 9,
                  weight: FontWeight.w500,
                ),
              )
                  .animate()
                  .fade(duration: 4000.ms)
                  .scale(delay: 600.ms) // runs after fade.
                  // .slide()
                  .fadeOut(duration: 10600.ms)
                  .fadeOut(curve: Curves.bounceInOut)
            ],
          )),
    );
  }
}

extension Padding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}
