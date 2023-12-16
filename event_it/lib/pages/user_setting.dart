// ignore_for_file: prefer_const_constructors
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/user_about_us.dart';
import 'package:event_it/pages/user_event_groups.dart';
import 'package:event_it/pages/interests.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/user_home.dart';
import 'package:event_it/pages/user_profile.dart';
import 'package:event_it/pages/your_saved.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  bool _isLoading = false;
  bool _light = false;
  AuthServices authServices = new AuthServices();
  @override
  Widget build(BuildContext context) {
    // double deviceHeight = MediaQuery.of(context).size.height;
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

                  ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    leading: Icon(
                      Icons.notifications,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Notification",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    leading: const Icon(
                      Icons.light_mode,
                      color: AppTheme.whiteColor,
                      size: 25,
                    ),
                    title: Text(
                      "Light Mode",
                      style:
                          AppTheme.appText(size: 16, weight: FontWeight.w400),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          _light = !_light;
                        });
                      },
                      child: Icon(
                        _light ? Icons.toggle_on : Icons.toggle_off,
                        color:
                            _light ? AppTheme.blueColor : AppTheme.whiteColor,
                        size: 30,
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
                      Icons.history,
                      color: AppTheme.whiteColor, // Set the desired color
                      size: 25, // Set the desired size
                    ),
                    title: Text(
                      "Event history",
                      style: AppTheme.appText(
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      nextScreen(context, Interests());
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
                      "Your Interests",
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
                      nextScreen(context, UserAboutUs());
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
                                    SizedBox(
                                      width: 20,
                                    ),
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
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("/cards/profile.jpg"),
          ),
          15.pH,
          Text(
            "UserName",
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
              nextScreen(context, UserHome());
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
              nextScreen(context, UserProfile());
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
