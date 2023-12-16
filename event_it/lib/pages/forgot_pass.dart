import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_theme.dart';
import '../widgets/widgets.dart';
import 'forgot_pass2.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  String email = " ";
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            nextScreenReplacement(context, Login());
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
                            Text("Forgot Password",
                                style: AppTheme.appText(
                                    size: deviceWidth / 14, weight: FontWeight.bold)),
                            SizedBox(
                              height: 30,
                            ),
                            Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  cursorColor: AppTheme.whiteColor,
                                  style: GoogleFonts.poppins(
                                      color: AppTheme.whiteColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: deviceWidth / 26),
                                  decoration: textInputDecoration.copyWith(
                                    hintText: "Email Address",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: deviceWidth / 18,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                  validator: (value) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value!)
                                        ? null
                                        : "Please enter valid email!";
                                  },
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: deviceHeight / 14,
                                  width: deviceWidth / 1.7,
                                  child: ElevatedButton(
                                    style: AppTheme.buttonStyle(
                                        backColor: AppTheme.blueColor),
                                    onPressed: () {
                                      nextScreen(context, Forgotpass2());
                                    },
                                    child: Text(
                                      "Send",
                                      style: AppTheme.appText(
                                        size: deviceWidth / 26,
                                        weight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "OR",
                                  textAlign: TextAlign.center,
                                  style: AppTheme.appText(
                                      size: deviceWidth / 26,
                                      weight: FontWeight.w300,
                                      color: AppTheme.whiteColor),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Don't have an account ?",
                                  style: AppTheme.appText(
                                      size: deviceWidth / 26,
                                      weight: FontWeight.w300),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    nextScreen(context, Role());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: AppTheme.appText(
                                        size: 16,
                                        weight: FontWeight.w500,
                                        color: AppTheme.blueColor),
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ]),
                ),
              ));
  }
}
