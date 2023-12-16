import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/user_event_groups.dart';
import 'package:event_it/pages/user_home.dart';
import 'package:event_it/pages/user_setting.dart';
import 'package:event_it/pages/your_saved.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/widgets.dart';

class UserProfile extends StatefulWidget {
  
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isLoading = false;
  bool _light = false;

  AuthServices authServices = new AuthServices();
  
 String orgName = "";
 String email="";
 String dob="";
 String loc="";
 String gender="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getUserName();
    getUserGender();
    getUserLoc();
    getUserDob();
    getUserEmail();
  }

  getUserName() async {
    DatabaseServices().getUser(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }
  getUserGender() async {
    DatabaseServices().getGender(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        gender = value;
      });
      print(gender);
    });
  }
  getUserLoc()async{
    DatabaseServices().getLoc(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        loc = value;
      });
      print(loc);
    });
  }
  getUserDob()async{
    DatabaseServices().getDob(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        dob = value;
      });
      print(loc);
    });
  }
  getUserEmail()async{
    DatabaseServices().getEmail(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        email = value;
      });
      print(loc);
    });
  }
 
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppTheme.backgroundColor,
        ),
        drawer: _drawer(context),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth / 20,
                            vertical: deviceHeight / 28),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  orgName.substring(0, 1).toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                  ),
                                ),
                              ),
                              15.pH,
                              Text(
                                orgName,
                                style: AppTheme.appText(
                                  size: 18,
                                  weight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              20.pH,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: AppTheme.whiteColor,
                                        size: 22,
                                      ),
                                      5.pW,
                                      Text(
                                        email,
                                        style: AppTheme.appText(
                                            size: 14, weight: FontWeight.w200, color: AppTheme.whiteColor),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.female,
                                        color: AppTheme.whiteColor,
                                        size: 22,
                                      ),
                                      5.pW,
                                      Text(
                                        gender,
                                        style: AppTheme.appText(
                                            size: 14, weight: FontWeight.w200, color: AppTheme.whiteColor),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: AppTheme.whiteColor,
                                        size: 22,
                                      ),
                                      5.pW,
                                      Text(
                                        dob,
                                        style: AppTheme.appText(
                                            size: 14, weight: FontWeight.w200, color: AppTheme.whiteColor),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: AppTheme.whiteColor,
                                        size: 22,
                                      ),
                                      5.pW,
                                      Text(
                                        loc,
                                        style: AppTheme.appText(
                                            size: 14, weight: FontWeight.w200, color: AppTheme.whiteColor),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  
                                 
                                ],
                              ),
                              25.pH,
                              
                            ],
                          ),
                        ),
                      ),
                      // ProfileCard(),
                      // 15.pH,
                      // ProfileCard(),
                      // 15.pH,
                      // ProfileCard(),
                    ],
                  ),
                ),
              ));
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.slightBlack,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: <Widget>[
         CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              orgName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          15.pH,
          Text(
            orgName,
            style: AppTheme.appText(
              size: 20,
              weight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          30.pH,
          const Divider(
            height: 20,
            endIndent: 0,
            indent: 0,
            thickness: 2,
            color: AppTheme.whiteColor,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, UserHome());
            },
            // selected: true,
            // selectedTileColor: AppTheme.greyColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.home_rounded,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Home",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, UserProfile());
            },
            selected: true,
            selectedTileColor: AppTheme.greyColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.person_rounded,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Profile",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, UserEventGroup());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.groups_rounded,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Event Groups",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, YourSaved());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.bookmark,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Your Saved",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, NotificationsPage());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.notifications_rounded,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Notifications",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
              onTap: () {},
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.light_mode,
                color: AppTheme.backgroundColor,
                size: 25,
              ),
              title: Text(
                "Light Mode",
                style: AppTheme.appText(size: 16, weight: FontWeight.w400),
              ),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _light = !_light;
                  });
                },
                child: Icon(
                  _light ? Icons.toggle_on : Icons.toggle_off,
                  color: _light ? AppTheme.blueColor : AppTheme.backgroundColor,
                  size: 30,
                ),
              )),
          ListTile(
            onTap: () {
              nextScreen(context, UserSettingPage());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.settings_rounded,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Settings",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      title: Text(
                        "Log Out",
                        style: AppTheme.appText(
                            size: 20,
                            weight: FontWeight.bold,
                            color: AppTheme.slightBlack),
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: AppTheme.appText(
                            size: 14,
                            weight: FontWeight.w400,
                            color: AppTheme.slightBlack),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: AppTheme.buttonStyle3(
                                      backColor: AppTheme.slightBlack),
                                  child: Text(
                                    "Cancel",
                                    style: AppTheme.appText(
                                        size: 16, weight: FontWeight.w500),
                                  )),
                            ),
                            20.pW,
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await authServices.signout();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoadingPage()),
                                        (route) => false);
                                  },
                                  style: AppTheme.buttonStyle3(
                                      backColor: AppTheme.slightBlack),
                                  child: Text(
                                    "Log out",
                                    style: AppTheme.appText(
                                        size: 16, weight: FontWeight.w500),
                                  )),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.exit_to_app_outlined,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Logout",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
