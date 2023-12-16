import 'package:event_it/helper/helperFunc.dart';
import 'package:event_it/pages/forgot_pass.dart';
import 'package:event_it/pages/forgot_pass2.dart';
import 'package:event_it/pages/forgot_pass3.dart';
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/notification_page.dart';
import 'package:event_it/pages/org_home.dart';
import 'package:event_it/pages/org_register.dart';
import 'package:event_it/pages/role.dart';
import 'package:event_it/pages/search_page.dart';
import 'package:event_it/pages/user_home.dart';
import 'package:event_it/pages/interests.dart';
import 'package:event_it/pages/user_register.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/home_card.dart';
import 'package:event_it/pages/org_profile.dart';
import 'package:event_it/pages/createEvent.dart';
// import 'package:event_it/pages/edit_org_pro.dart';
import 'package:event_it/pages/interests.dart';
import 'package:event_it/pages/user_home.dart';
// import 'package:event_it/pages/edit_user_pro.dart';
import 'package:event_it/pages/loading_page.dart';
import 'package:event_it/pages/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:event_it/shared/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: Constants.apiKey,
  //     authDomain: Constants.authDomain,
  //     projectId: Constants.projectId,
  //     storageBucket: Constants.storageBucket,
  //     messagingSenderId: Constants.messagingSenderId,
  //     appId: Constants.appId,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = true;
  // bool isOrg = true;
  // var org;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
    // getIsOrg();
  }

  // getIsOrg() async {
  //   DatabaseServices()
  //       .isOrg(FirebaseAuth.instance.currentUser!.uid)
  //       .then((value) {
  //     print(value);
  //     setState(() {
  //       org = value;
  //     });
  //   });
  //   if (org == "true") {
  //     setState(() {
  //       isOrg = true;
  //     });
  //   } else {
  //     isOrg = false;
  //   }
  //   print(isOrg);
  //   print(org);
  // }

  getUserLoggedInStatus() async {
    await helperFun.getUserLoggedInStatus2().then((value) {
      if (value != null) {
        isSignedIn = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "E-vent it!",
        debugShowCheckedModeBanner: false,
        // home: Interests(),
        home:
            // isSignedIn ? UserHome() : 
            LoadingPage()
            // isSignedIn
            //     ? isOrg
            //         ? OrgHome()
            //         : UserHome()
            //     : LoadingPage()
            );
  }
}
