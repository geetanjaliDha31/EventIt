import 'package:csc_picker/csc_picker.dart';
import 'package:event_it/pages/event_types.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:event_it/helper/helperFunc.dart';

class OrgRegister extends StatefulWidget {
  const OrgRegister({super.key});

  @override
  State<OrgRegister> createState() => _OrgRegisterState();
}

class _OrgRegisterState extends State<OrgRegister> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = false;
  String name = "";
  String email = "";
  String phone = "";
  String country = "";
  String? state = "";
  String? city = "";
  String location = "";
  String passWord = "";
  String confirmPassword = "";

  AuthServices authServices = new AuthServices();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    locationFun();
    super.initState();
  }
  locationFun(){
    setState(() {
      location = country + " " + state! + " " + city!;
    });
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth / 12,
                      vertical: deviceHeight / 50),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: deviceWidth / 5,
                          height: deviceHeight / 5,
                        ),
                        Text("Create your account now",
                            style: AppTheme.appText(
                                size: deviceWidth / 22,
                                weight: FontWeight.bold)),
                        1.ph,
                        Text(
                          "to post your Events!",
                          style: AppTheme.appText(
                              size: deviceWidth / 22, weight: FontWeight.bold),
                        ),
                        20.ph,
                        TextFormField(
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Name",
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              size: deviceWidth / 18,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter your name";
                            }
                          },
                        ),
                        20.ph,
                        TextFormField(
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Email",
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
                        20.ph,
                        TextFormField(
                            cursorColor: AppTheme.whiteColor,
                            style: GoogleFonts.poppins(
                                color: AppTheme.whiteColor,
                                fontWeight: FontWeight.w300,
                                fontSize: deviceWidth / 26),
                            decoration: textInputDecoration.copyWith(
                              hintText: "Contact Number",
                              prefixIcon: Icon(
                                Icons.phone,
                                size: deviceWidth / 18,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                phone = value;
                              });
                            },
                            validator: (value) {
                              if (value!.length==10) {
                                return null;
                              } else {
                                return "Please enter valid contanct number";
                              }
                            }),
                        20.ph,
                        CSCPicker(
                          layout: Layout.horizontal,
                          flagState: CountryFlag.DISABLE,
                          onCountryChanged: (country1) {
                            setState(() {
                              country=country1;
                            });
                          },
                          onStateChanged: (state1) {
                            setState(() {
                              state=state1;
                            });
                          },
                          onCityChanged: (city1) {
                            setState(() {
                              city=city1;
                            });
                          },
                          dropdownDialogRadius: 10,
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppTheme.slightBlack,
                              border: Border.all(
                                  color: AppTheme.slightBlack, width: 1)),
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: AppTheme.slightBlack,
                              border: Border.all(
                                  color: AppTheme.slightBlack, width: 1)),
                          dropdownHeadingStyle: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontSize: deviceWidth / 26,
                              fontWeight: FontWeight.w300),

                          ///DropdownDialog Item style [OPTIONAL PARAMETER]
                          dropdownItemStyle: GoogleFonts.poppins(
                            color: AppTheme.backgroundColor,
                            fontSize: deviceWidth / 26,
                          ),
                          selectedItemStyle: GoogleFonts.poppins(
                            color: AppTheme.whiteColor,
                            fontSize: deviceWidth / 26,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        20.ph,
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
                              if (value!.length<8) {
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
                                    _obscureConfirmText = !_obscureConfirmText;
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
                        30.ph,
                        SizedBox(
                          height: deviceHeight / 14,
                          width: deviceWidth / 1.7,
                          child: ElevatedButton(
                            style: AppTheme.buttonStyle(
                                backColor: AppTheme.blueColor),
                            onPressed: () {
                              register();
                            },
                            child: Text("Sign up",
                                style: AppTheme.appText(
                                    size: deviceWidth / 26,
                                    weight: FontWeight.w400)),
                          ),
                        ),
                        10.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: AppTheme.appText(
                                size: deviceWidth / 26,
                                weight: FontWeight.w200,
                              ),
                            ),
                            5.pw,
                            GestureDetector(
                              onTap: () {
                                nextScreen(context, Login());
                              },
                              child: Text(
                                "Sign in",
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
  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    setState(() {
      location = country + " " + state! + " " + city!;
    });
    await authServices
        .registerOrgWithEmailAndPassword(name, email, passWord, phone, location)
        .then((value) async {
      if (value == true) {
        await helperFun.saveUserLoggedInStatus(true);
        await helperFun.saveUserNameSp(name);
        await helperFun.saveUserEmailSp(email);
        nextScreen(context, EventType());
      } else {
        showSnackbar(context, Colors.red, value);
        setState(() {
          _isLoading = false;
        });
      }
    });
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
