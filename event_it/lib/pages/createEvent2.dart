import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
import 'package:event_it/pages/org_home.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:event_it/helper/helperFunc.dart';

import '../utils/app_theme.dart';
import '../widgets/widgets.dart';

class createEvent2 extends StatefulWidget {
  final File image;
  final String imgUrl;

  const createEvent2({super.key, required this.image, required this.imgUrl});
  @override
  State<createEvent2> createState() => _createEvent2State();
}

class _createEvent2State extends State<createEvent2> {
  bool _isLoading = false;
  String EventName = "";
  String EventDesc = "";
  String EventFee = "";
  String EventTime = "";
  String EventDate = "";
  String EventLoc = "";
  String EventAddress = "";
  String email = "";
  String phone = "";
  String passWord = "";
  String country = "";
  String? state = "";
  String? city = "";
  bool paid = false;
  String confirmPassword = "";
  int? selectedOption;
  String oname = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController _date = TextEditingController();
  TextEditingController _time = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  AuthServices authServices = new AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    locationFun();
    getOrgName();
    super.initState();
  }

  locationFun() {
    setState(() {
      EventLoc = country + " " + state! + " " + city!;
    });
  }

  getOrgName() async {
    DatabaseServices().getOrg(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        oname = value;
      });
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
                        Image.file(widget.image,
                            width: deviceWidth / 1.2,
                            height: deviceHeight / 3.5,
                            fit: BoxFit.cover),
                        20.ph,
                        Text(
                          "Event Details",
                          style: AppTheme.appText(
                              size: deviceWidth / 20, weight: FontWeight.w300),
                        ),
                        20.ph,
                        TextFormField(
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Event Name",
                            prefixIcon: Icon(
                              Icons.event_note,
                              size: deviceWidth / 18,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              EventName = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter your event name";
                            }
                          },
                        ),
                        20.ph,
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines:
                              1, //Normal tex'tInputField will be displayed
                          maxLines: 6,
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Event Description",
                            prefixIcon: Icon(
                              Icons.event_note,
                              size: deviceWidth / 18,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              EventDesc = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter your event name";
                            }
                          },
                        ),
                        20.ph,
                        Container(
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Free event',
                                    style:
                                        TextStyle(color: AppTheme.whiteColor),
                                  ),
                                  leading: Radio<int>(
                                    value: 1,
                                    groupValue: selectedOption,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedOption = value!;
                                        print(
                                            "Selected Option: $selectedOption");
                                      });
                                      setState(() {
                                        paid = false;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                    'Paid event',
                                    style:
                                        TextStyle(color: AppTheme.whiteColor),
                                  ),
                                  leading: Radio<int>(
                                    value: 2,
                                    groupValue: selectedOption,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedOption = value!;
                                        print(
                                            "Selected Option: $selectedOption");
                                        paid = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.slightBlack,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            )),
                        20.ph,
                        selectedOption == 2
                            ? Column(
                                children: [
                                  TextFormField(
                                    cursorColor: AppTheme.whiteColor,
                                    style: GoogleFonts.poppins(
                                        color: AppTheme.whiteColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: deviceWidth / 26),
                                    decoration: textInputDecoration.copyWith(
                                      hintText: "Event Fees",
                                      prefixIcon: Icon(
                                        Icons.currency_rupee,
                                        size: deviceWidth / 18,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        EventFee = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "Please enter your event name";
                                      }
                                    },
                                  ),
                                  20.ph,
                                ],
                              )
                            : SizedBox(),
                        TextFormField(
                          controller: _date,
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Event Date",
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
                                    DateFormat("MMMMEEEEd").format(pickDate);
                                EventDate = _date.text;
                              });
                            }
                          },
                        ),
                        20.ph,
                        TextFormField(
                            controller: _time,
                            cursorColor: AppTheme.whiteColor,
                            style: GoogleFonts.poppins(
                                color: AppTheme.whiteColor,
                                fontWeight: FontWeight.w300,
                                fontSize: deviceWidth / 26),
                            decoration: textInputDecoration.copyWith(
                              hintText: "Event Time",
                              prefixIcon: Icon(
                                Icons.access_time_rounded,
                                size: deviceWidth / 17,
                              ),
                            ),
                            onTap: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                setState(() {
                                  _time.text = timeOfDay.format(context);
                                  EventTime = _time.text;
                                });
                              }
                            }),
                        20.ph,
                        CSCPicker(
                          layout: Layout.horizontal,
                          flagState: CountryFlag.DISABLE,
                          onCountryChanged: (country1) {
                            setState(() {
                              country = country1;
                            });
                          },
                          onStateChanged: (state1) {
                            setState(() {
                              state = state1;
                            });
                          },
                          onCityChanged: (city1) {
                            setState(() {
                              city = city1;
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
                          keyboardType: TextInputType.multiline,
                          minLines:
                              1, //Normal tex'tInputField will be displayed
                          maxLines: 5,
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Address",
                            prefixIcon: Icon(
                              Icons.add_location,
                              size: deviceWidth / 17,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              EventAddress = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter your event address";
                            }
                          },
                        ),
                        20.ph,
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines:
                              1, //Normal tex'tInputField will be displayed
                          maxLines: 5,
                          cursorColor: AppTheme.whiteColor,
                          style: GoogleFonts.poppins(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w300,
                              fontSize: deviceWidth / 26),
                          decoration: textInputDecoration.copyWith(
                            hintText: "Google Form link",
                            prefixIcon: Icon(
                              Icons.g_mobiledata,
                              size: deviceWidth / 17,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              EventAddress = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please enter your google form link";
                            }
                          },
                        ),
                        30.ph,
                        SizedBox(
                          height: deviceHeight / 14,
                          width: deviceWidth / 1.7,
                          child: ElevatedButton(
                            style: AppTheme.buttonStyle(
                                backColor: AppTheme.blueColor),
                            onPressed: () {
                              registerEvent();
                            },
                            child: Text("create event",
                                style: AppTheme.appText(
                                    size: deviceWidth / 26,
                                    weight: FontWeight.w400)),
                          ),
                        ),
                        30.ph
                      ],
                    ),
                  ),
                ),
              ));
  }

  registerEvent() async {
    if (formKey.currentState!.validate()) {
      // setState(() {
      //   _isLoading = true;
        nextScreen(context, OrgHome());
      // });
    }
    EventLoc = country + " " + state! + " " + city!;
    String orgid = FirebaseAuth.instance.currentUser!.uid;
    print(orgid);
    DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .createEvent( EventName, EventDesc, paid, EventFee, EventDate,
            EventTime, EventLoc, EventAddress, widget.imgUrl)
        .then((value) {
      if (value == true) {
        // nextScreen(context, OrgHome());
        showSnackbar(context, Colors.green, "Group Created Succesfully!");
      } else {
        showSnackbar(context, Colors.red, "error");
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
