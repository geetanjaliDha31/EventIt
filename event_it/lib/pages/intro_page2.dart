import 'package:event_it/pages/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:event_it/pages/createEvent2.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
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
                    //   "/get_started/start2.png",
                    //   height: 300,
                    // ),
                     Image.network("https://firebasestorage.googleapis.com/v0/b/eventit-d8971.appspot.com/o/images%2Fstart2.png?alt=media&token=5976f5e5-ce7f-4110-9664-aadbfdcb1843", height: 300,),
                    2.ph,
                    Text(
                      "Participate in your Interested Events",
                      style: AppTheme.appText(
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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
                    80.ph,
                    SizedBox(
                      height: deviceHeight / 8,
                      width: deviceWidth / 1.7,
                      child: ElevatedButton(
                        style:
                            AppTheme.buttonStyle(backColor: AppTheme.blueColor),
                        onPressed: () {
                          nextScreen(context, IntroPage3());
                        },
                        child: Text("Next",
                            style: AppTheme.appText(
                                size: deviceWidth / 23,
                                weight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
