import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/user_event_groups.dart';
import 'package:event_it/pages/user_profile.dart';
import 'package:event_it/pages/user_setting.dart';
import 'package:event_it/pages/your_saved.dart';
import 'package:event_it/services/authServices.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/loading_theme.dart';
import '../widgets/home_card.dart';
import '../widgets/widgets.dart';
import 'search_page.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool _isLoading = false;
  AuthServices authServices = new AuthServices();
  bool _light = false;
  Stream<QuerySnapshot>? homecards;
  String orgName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     homecards = DatabaseServices().getHomeCards();
    getUserName();
  }

  getUserName() async {
    DatabaseServices().getUser(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }

  



  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppTheme.whiteColor),
          backgroundColor: AppTheme.backgroundColor,
          title: Text(
            "E-vent it!",
            style: LoadingTheme.appText(
                size: 22, weight: FontWeight.w500, color: AppTheme.whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: const Icon(
                Icons.search_sharp,
                color: AppTheme.whiteColor,
              ),
            ),
          ],
        ),
        drawer: _drawer(context),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth / 20,
                      vertical: deviceHeight / 80),
                  child:
                    homeCards(),  
                ),
              ));
  }

  homeCards() {
  return StreamBuilder(
    stream: homecards,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<DocumentSnapshot> documents = snapshot.data.docs;

        return Container(
          height: MediaQuery.of(context).size.height, // Set a fixed height or use Expanded
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> eventData = documents[index].data() as Map<String, dynamic>;
              print(eventData);
              return HomeCard(
                EventName: eventData['EventName'],
                EventAddress: eventData['EventAddress'],
                EventDate: eventData['EventDate'],
                EventFee: eventData['EventFee'],
                EventTime: eventData['EventTime'],
                isEventPaid: eventData['isEventPaid'],
                EventBanner: eventData['EventBanner'],
                orgId: eventData['orgId'],
                EventId: eventData['eventId'],
                EventDesc: eventData['EventDesc'],
                // Add other fields as needed
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
              nextScreen(context, UserHome());
            },
            selected: true,
            selectedTileColor: AppTheme.greyColor,
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

// rules_version = '2';

// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /{document=**} {
//       allow read, write: if request.auth!=null;
//     }
//   }
// }