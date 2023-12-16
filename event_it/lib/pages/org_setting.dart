import 'package:event_it/pages/org_about_us.dart';
import 'package:event_it/pages/createEvent.dart';
import 'package:event_it/pages/event_types.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/org_event_group.dart';
import 'package:event_it/pages/org_home.dart';
import 'package:event_it/pages/org_profile.dart';
import 'package:event_it/pages/your_saved.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class OrgSettingPage extends StatefulWidget {
  const OrgSettingPage({super.key});

  @override
  State<OrgSettingPage> createState() => _OrgSettingPageState();
}

class _OrgSettingPageState extends State<OrgSettingPage> {
  bool _isLoading = false;
  bool _light = false;
   String orgName = "";
  @override

  getUserName() async {
    DatabaseServices().getOrg(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }
 
  void initState() {
    // TODO: implement initState
    super.initState();
    // gettingHomeData();
     getUserName();
   
  }
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Settings',
            style: GoogleFonts.poppins(
              color: AppTheme.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 21,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      drawer: _drawer(context),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Search field

                  CupertinoSearchTextField(
                    backgroundColor: AppTheme.slightBlack,
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: AppTheme.whiteColor,
                      size: deviceWidth / 20,
                    ),
                    style: GoogleFonts.poppins(
                      color: AppTheme.whiteColor,
                      fontWeight: FontWeight.w300,
                      fontSize: deviceWidth / 22,
                    ),
                  ),

                 
                  // ListTile(
                  //   onTap: () {},
                  //   contentPadding: const EdgeInsets.symmetric(
                  //       horizontal: 10, vertical: 10),
                  //   leading: const Icon(
                  //     Icons.light_mode,
                  //     color: AppTheme.whiteColor,
                  //     size: 25,
                  //   ),
                  //   title: Text(
                  //     "Light Mode",
                  //     style:
                  //         AppTheme.appText(size: 16, weight: FontWeight.w400),
                  //   ),
                  //   trailing: GestureDetector(
                  //     onTap: () {
                  //       setState(() {
                  //         _light = !_light;
                  //       });
                  //     },
                  //     child: Icon(
                  //       _light ? Icons.toggle_on : Icons.toggle_off,
                  //       color:
                  //           _light ? AppTheme.blueColor : AppTheme.whiteColor,
                  //       size: 30,
                  //     ),
                  //   ),
                  // ),

                  ListTile(
                    onTap: () {
                      nextScreen(context, EventType());
                    },
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.search,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Event Type",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.help_outline,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Help Center",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      nextScreen(context, YourSaved());
                    },
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.bookmark,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Your Saved",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.payment,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Payment",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      nextScreen(context, OrgAboutUs());
                    },
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "About Us",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
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
                                    color: AppTheme.blueColor),
                              ),
                              content: Text(
                                "Are you sure you want to logout?",
                                style: AppTheme.appText(
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: AppTheme.backgroundColor),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 33,
                                      width: 110,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: AppTheme.buttonStyle3(
                                              backColor: AppTheme.blueColor),
                                          child: Text(
                                            "Cancel",
                                            style: AppTheme.appText(
                                                size: 16,
                                                weight: FontWeight.w300),
                                          )),
                                    ),
                                    20.pw,
                                    SizedBox(
                                      height: 33,
                                      width: 110,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: AppTheme.buttonStyle3(
                                              backColor: AppTheme.blueColor),
                                          child: Text(
                                            "Log out",
                                            style: AppTheme.appText(
                                                size: 16,
                                                weight: FontWeight.w300),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    leading: const Icon(
                      Icons.exit_to_app_outlined,
                      size: 25,
                      color: AppTheme.whiteColor,
                    ),
                    title: Text(
                      "Logout",
                      style:
                          AppTheme.appText(size: 16, weight: FontWeight.w400),
                    ),
                  ), // Other widgets go here
                ],
              ),
            ),
    );
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
              size: 18,
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
              nextScreen(context, OrgHome());
            },
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
              nextScreen(context, OrgProfile());
            },
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
              nextScreen(context, CreateEvent());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(
              Icons.add_box_outlined,
              color: AppTheme.backgroundColor,
              size: 25,
            ),
            title: Text(
              "Create Events",
              style: AppTheme.appText(size: 16, weight: FontWeight.w400),
            ),
          ),
          ListTile(
            onTap: () {
              nextScreen(context, OrgEventGroup());
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
              nextScreen(context, OrgSettingPage());
            },
            selected: true,
            selectedTileColor: AppTheme.greyColor,
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
                            color: AppTheme.blueColor),
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: AppTheme.appText(
                            size: 14,
                            weight: FontWeight.w400,
                            color: AppTheme.backgroundColor),
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
                                      backColor: AppTheme.blueColor),
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
                                  onPressed: () {},
                                  style: AppTheme.buttonStyle3(
                                      backColor: AppTheme.blueColor),
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
