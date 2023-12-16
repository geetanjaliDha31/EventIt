import 'package:event_it/pages/createEvent2.dart';
import 'package:event_it/pages/intro_page2.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : SafeArea(
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 90),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   "/get_started/start1.png",
                      //   height: 300,
                      // ),
                      Image.network("https://firebasestorage.googleapis.com/v0/b/eventit-d8971.appspot.com/o/images%2Fstart1.png?alt=media&token=997dff97-f36e-4ed1-bacb-fbe413375246", height: 300,),
                      2.ph,
                      Text(
                        "Organize Your Events",
                        style: AppTheme.appText(
                          size: 24,
                          weight: FontWeight.w500,
                        ),
                      ),
                      20.ph,
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. Habitant feugiat dictumst sed ultrices pulvinar.",
                        style: AppTheme.appText(
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      100.ph,
                      SizedBox(
                        height: deviceHeight / 8,
                        width: deviceWidth / 1.7,
                        child: ElevatedButton(
                          style: AppTheme.buttonStyle(
                              backColor: AppTheme.blueColor),
                          onPressed: () {
                            nextScreen(context, IntroPage2());
                          },
                          child: Text("Next",
                              style: AppTheme.appText(
                                  size: deviceWidth / 23,
                                  weight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
