import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/user_home.dart';
import 'package:event_it/pages/user_register.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_it/widgets/widgets.dart';
import 'forgot_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  bool _isLoading = false;
  bool _obscureText = true;
  AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black,
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth / 12, vertical: deviceHeight / 4),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: deviceWidth / 5,
                          height: deviceHeight / 5,
                        ),
                        2.pH,
                        Text("Sign in",
                            style: AppTheme.appText(
                                size: deviceWidth / 16,
                                weight: FontWeight.bold)),
                        20.pH,
                        TextFormField(
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Email or Username",
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
                            if (value!.isEmpty) {
                              return "Please enter your email or password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        20.pH,
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
                                password = value;
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
                        30.pH,
                        // GestureDetector(
                        //   onTap: () {
                        //     nextScreen(context, Forgotpass());
                        //   },
                        //   child: Text(
                        //     "Forgot password?",
                        //     style: AppTheme.appText(
                        //       size: deviceWidth / 26,
                        //       weight: FontWeight.w400,
                        //       color: AppTheme.blueColor,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: deviceHeight / 8,
                          width: deviceWidth / 1.7,
                          child: ElevatedButton(
                            style: AppTheme.buttonStyle(
                                backColor: AppTheme.blueColor),
                            onPressed: () {
                              // nextScreen(context, OrgHome());
                              login();
                            },
                            child: Text("Sign in",
                                style: AppTheme.appText(
                                    size: deviceWidth / 26,
                                    weight: FontWeight.w300)),
                          ),
                        ),
                        16.pH,
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: AppTheme.appText(
                                size: deviceWidth / 26,
                                weight: FontWeight.w200,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                nextScreen(context, UserRegister());
                              },
                              child: Text(
                                "Signup",
                                style: AppTheme.appText(
                                    size: deviceWidth / 26,
                                    weight: FontWeight.w500,
                                    color: AppTheme.blueColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }


  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .signinWithEmailAndPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot = await DatabaseServices(
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .getUserData(email);
          // saving the values to our shared preferences
          // await helperFun.saveUserLoggedInStatus(true);
          // await helperFun.saveUserEmailSp(email);
          // await helperFun.saveUserNameSp(snapshot.docs[0]['fullName']);
          nextScreenReplacement(context, const UserHome());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
  
}

extension Padding on num {
  SizedBox get pH => SizedBox(
        height: toDouble(),
      );
  SizedBox get pW => SizedBox(
        width: toDouble(),
      );
}
