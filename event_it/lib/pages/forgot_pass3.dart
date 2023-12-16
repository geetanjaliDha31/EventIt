import 'package:event_it/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../utils/app_theme.dart';
import '../widgets/widgets.dart';
import 'forgot_pass2.dart';

class Forgotpass3 extends StatefulWidget {
  const Forgotpass3({super.key});

  @override
  State<Forgotpass3> createState() => _Forgotpass3State();
}

class _Forgotpass3State extends State<Forgotpass3> {
  bool _obscureConfirmText = false;
  bool _obscureText = true;
  bool _isLoading = false;
  String passWord = "";
  String confirmPassword = "";
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        nextScreenReplacement(context, Forgotpass2());
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: deviceWidth / 14,
                        color: AppTheme.whiteColor,
                      ),
                    ),
                    SizedBox(height: 50),
                    Column(
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: deviceWidth / 5,
                          height: deviceHeight / 5,
                        ),
                        Text("New Password",
                            style: AppTheme.appText(
                                size: deviceWidth / 14,
                                weight: FontWeight.bold)),
                        20.ph,
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
                                    hintText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: deviceWidth / 18,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: _obscureText
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                    )),
                                obscureText: _obscureText,
                                onChanged: (value) {
                                  setState(() {
                                    passWord = value;
                                  });
                                },
                                validator: (value) {
                                  if (RegExp("/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@%^&*-]).{8,}/")
                                          .hasMatch(value!) &&
                                      value.isEmpty) {
                                    return "Please enter a strong password";
                                  }
                                  return null;
                                }),
                            20.ph,
                            TextFormField(
                                cursorColor: AppTheme.whiteColor,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: deviceWidth / 26),
                                decoration: textInputDecoration.copyWith(
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: deviceWidth / 18,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureConfirmText =
                                            !_obscureConfirmText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureConfirmText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: _obscureConfirmText
                                          ? Colors.grey
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                                obscureText: _obscureConfirmText,
                                onChanged: (value) {
                                  setState(() {
                                    confirmPassword = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please re-enter password';
                                  }
                                  print(password.text);

                                  print(confirmpassword.text);

                                  if (password.text != confirmpassword.text) {
                                    return "Password does not match";
                                  }
                                  return null;
                                }),
                            20.ph,
                            SizedBox(
                              height: deviceHeight / 14,
                              width: deviceWidth / 1.7,
                              child: ElevatedButton(
                                style: AppTheme.buttonStyle(
                                    backColor: AppTheme.blueColor),
                                onPressed: () {
                                  // nextScreen(context, Forgotpass3());
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
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
