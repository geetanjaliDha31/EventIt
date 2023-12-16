import 'package:event_it/pages/interests.dart';
import 'package:event_it/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:event_it/helper/helperFunc.dart';
import 'package:event_it/services/authServices.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = false;
  String name = "";
  String email = "";
  String phone = "";
  String passWord = "";
  String confirmPassword = "";
  String dob = "";
  String gender = "";
  String country = "";
  String? state = "";
  String? city = "";
  String location = "";
  AuthServices authServices = AuthServices();

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

  List<String> genderl = <String>[
    "Gender",
    "Male",
    "Female",
    "Other",
  ];
  String selectGender = "Gender";

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _date = TextEditingController();

  @override
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
                      vertical: deviceHeight / 75),
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
                          "to know about your",
                          style: AppTheme.appText(
                              size: deviceWidth / 22, weight: FontWeight.bold),
                        ),
                        1.ph,
                        Text(
                          "Interested Events!",
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
                            // validator: (value) {
                              
                            //   if (value!.length<10) {
                            //     return null;
                            //   } else {
                            //     return "Please enter valid contanct number";
                            //   }
                            // }
                            ),
                        20.ph,
                        CSCPicker(
                          layout: Layout.horizontal,
                          flagState: CountryFlag.DISABLE,
                          onCountryChanged: (country1) {
                            country = country1;
                          },
                          onStateChanged: (state1) {
                            state = state1;
                          },
                          onCityChanged: (city1) {
                            city = city1;
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
                        DropdownButtonFormField(
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 24,
                            color: AppTheme.backgroundColor,
                          ),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Gender",
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              size: deviceWidth / 18,
                            ),
                          ),
                          value: selectGender,
                          dropdownColor: AppTheme.slightBlack,
                          items: genderl
                              .map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.whiteColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: deviceWidth / 26),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectGender = value!;
                            gender = value;
                          },
                          validator: (value) {
                            if (value == "Gender") {
                              return "please select a genderl!";
                            }
                            return null;
                          },
                        ),
                        20.ph,
                        TextFormField(
                          controller: _date,
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Date of Birth",
                            prefixIcon: Icon(
                              Icons.calendar_today_rounded,
                              size: deviceWidth / 18,
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2120),
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                      splashColor: AppTheme.slightBlack,
                                      colorScheme: const ColorScheme.light(
                                        inverseSurface: AppTheme.slightBlack,
                                        primary: AppTheme.blueColor,
                                        onPrimary: AppTheme.whiteColor,
                                        onSurface: AppTheme.backgroundColor,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              AppTheme.backgroundColor,
                                        ),
                                      ),
                                    ),
                                    child: child!);
                              },
                            );
                            if (pickDate != null) {
                              setState(() {
                                _date.text =
                                    DateFormat("yyyy-MM-dd").format(pickDate);
                                dob = _date.text;
                              });
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
                                        : AppTheme.blueColor,
                                  ),
                                )),
                            obscureText: _obscureText,
                            onChanged: (value) {
                              setState(() {
                                passWord = value;
                              });
                            },
                            validator: (value) {
                              // if (RegExp("/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@%^&*-]).{8,}/")
                                  //     .hasMatch(value!) &&
                                  // value.isEmpty) 
                              if(value!.length<8)
                              {
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
                                      : AppTheme.blueColor,
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
                              print(_password.text);

                              print(_confirmpassword.text);

                              if (_password.text != _confirmpassword.text) {
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
        .registerUserWithEmailAndPassword(name, email, passWord, phone, dob, gender , location)
        .then((value) async {
      if (value == true) {
        await helperFun.saveUserLoggedInStatus(true);
        await helperFun.saveUserNameSp(name);
        await helperFun.saveUserEmailSp(email);
        nextScreen(context, Interests());
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
