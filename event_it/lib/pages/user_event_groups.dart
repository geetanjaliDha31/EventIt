import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/messageTile.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/user_home.dart';
import 'package:event_it/pages/user_profile.dart';
import 'package:event_it/pages/user_setting.dart';
import 'package:event_it/pages/your_saved.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/event_group_tile.dart';
import 'package:event_it/widgets/event_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_theme.dart';
import '../widgets/widgets.dart';

class UserEventGroup extends StatefulWidget {
  const UserEventGroup({super.key});

  @override
  State<UserEventGroup> createState() => _UserEventGroupState();
}

class _UserEventGroupState extends State<UserEventGroup> {
  bool _isLoading = false;
  bool _light = false;
  Stream<QuerySnapshot>? eventGroups;
  Stream<QuerySnapshot>? groups;

  String eventId = "";
  AuthServices authServices = new AuthServices();
   String orgName = "";
  @override

  getUserName() async {
    DatabaseServices().getUser(FirebaseAuth.instance.currentUser!.uid).then((value) {
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
    eventGroups = DatabaseServices().getHomeCards();
    gettingUserData();
  }

  gettingUserData() async {
    //getting the list of snapshot in our stream
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  String getId(String res) {
    setState(() {
      eventId = res.substring(0, res.indexOf("_"));
    });
    return res.substring(0, res.indexOf("_"));
  }

  getEventName() async {
    String eventName = "";
    DatabaseServices().getEventName(eventId).then((value) {
      setState(() {
        eventName = value;
      });
    });
    return eventName;
  }

  getEventBanner() async {
    String eventBanner = "";
    DatabaseServices().getEventBanner(eventId).then((value) {
      setState(() {
        eventBanner = value;
      });
    });
    return eventBanner;
  }

  getEventOrgId() async {
    String eventOrgId = "";
    DatabaseServices().getEventOrgId(eventId).then((value) {
      setState(() {
        eventOrgId = value;
      });
    });
    return eventOrgId;
  }

  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Center(
          child: Text(
            'Event Groups',
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
      body: groupList(),
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
            selected: true,
            selectedTileColor: AppTheme.greyColor,
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
                            SizedBox(
                              width: 20,
                            ),
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

  groupList() {
    return StreamBuilder(
      stream: eventGroups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.docs;

          return Container(
            height: MediaQuery.of(context)
                .size
                .height, // Set a fixed height or use Expanded
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> eventData =
                    documents[index].data() as Map<String, dynamic>;
                print(eventData);
                return
                EventGroupTile(
                  EventName: eventData['EventName'],
                  EventBanner: eventData['EventBanner'],
                  orgId: eventData['orgId'],
                  EventId: eventData['eventId'],
                );
              },
            ),
          );
        } else {
          return Text("No data");
        }
      },
      
    );
  }

  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "You have not join any group, Tap on the Add icon to create a group or else search on the top search button ",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
