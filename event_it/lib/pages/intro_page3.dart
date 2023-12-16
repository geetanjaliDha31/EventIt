import 'package:event_it/pages/role.dart';
import 'package:flutter/material.dart';
import 'package:event_it/pages/createEvent2.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   "/get_started/start3.png",
                    //   height: 400,
                    //   width: 1000,
                    // ),
                     Image.network("https://firebasestorage.googleapis.com/v0/b/eventit-d8971.appspot.com/o/images%2Fstart3.png?alt=media&token=c8da6371-73da-440e-a34f-b4774e9f8799", height: 300,),
                    0.ph,
                    Text(
                      "To never miss an Event",
                      style: AppTheme.appText(
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                    ),
                    90.ph,
                    SizedBox(
                      height: deviceHeight / 8,
                      width: deviceWidth / 1.7,
                      child: ElevatedButton(
                        style:
                            AppTheme.buttonStyle(backColor: AppTheme.blueColor),
                        onPressed: () {
                          nextScreen(context, Role());
                        },
                        child: Text("Let's Get Started",
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
