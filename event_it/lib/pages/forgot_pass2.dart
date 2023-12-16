import 'package:event_it/pages/forgot_pass.dart';
import 'package:event_it/pages/forgot_pass3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpass2 extends StatefulWidget {
  const Forgotpass2({super.key});

  @override
  State<Forgotpass2> createState() => _Forgotpass2State();
}

class _Forgotpass2State extends State<Forgotpass2> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : SafeArea(
              child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      nextScreenReplacement(context, Forgotpass());
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left_rounded,
                      size: deviceWidth / 14,
                      color: AppTheme.whiteColor,
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: deviceWidth / 5,
                        height: deviceHeight / 5,
                      ),
                      Text("Verification",
                          style: AppTheme.appText(
                              size: deviceWidth / 14, weight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Enter Verification Code",
                        textAlign: TextAlign.center,
                        style: AppTheme.appText(
                            size: deviceWidth / 24, weight: FontWeight.w400),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 45,
                              height: 60,
                              child: TextField(
                                maxLength: 1,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                cursorColor: AppTheme.whiteColor,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: AppTheme.whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 10)),
                              )),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 45,
                            height: 60,
                            child: TextField(
                                maxLength: 1,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                cursorColor: AppTheme.whiteColor,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.w400),
                                decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 10))),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 45,
                            height: 60,
                            child: TextField(
                                maxLength: 1,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                cursorColor: AppTheme.whiteColor,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.w400),
                                decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 10))),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 45,
                            height: 60,
                            child: TextField(
                                maxLength: 1,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                cursorColor: AppTheme.whiteColor,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.w400),
                                decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 17, vertical: 10))),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't recieve OTP ?",
                              style: AppTheme.appText(
                                  size: deviceWidth / 26,
                                  weight: FontWeight.w300),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Resend",
                                style: AppTheme.appText(
                                    size: deviceWidth / 26,
                                    weight: FontWeight.w500,
                                    color: AppTheme.blueColor),
                              ),
                            )
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: deviceHeight / 14,
                        width: deviceWidth / 1.7,
                        child: ElevatedButton(
                          style: AppTheme.buttonStyle(
                              backColor: AppTheme.blueColor),
                          onPressed: () {
                            nextScreen(context, Forgotpass3());
                          },
                          child: Text(
                            "Submit",
                            style: AppTheme.appText(
                              size: deviceWidth / 26,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
    );
  }
}
