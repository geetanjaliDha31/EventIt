import 'package:event_it/pages/chat_page.dart';
import 'package:event_it/pages/event_form.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EventPage extends StatefulWidget {
  final String orgId;
  final String EventName;
  final String EventAddress;
  final String EventDate;
  final bool isEventPaid;
  final String EventFee;
  final String EventTime;
  final String EventBanner;
  final String EventId;
  final String EventDesc;
  // final String orgName;
  const EventPage({
    super.key,
    required this.EventName,
    required this.EventAddress,
    required this.EventFee,
    required this.EventDate,
    required this.EventTime,
    required this.isEventPaid,
    required this.EventBanner,
    required this.orgId,
    required this.EventId,
    required this.EventDesc,
    // required this.orgName
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late InAppWebViewController controller;
  String url = "";
  double progress = 0;
  String orgName = "";
  String userName = "";
  bool isJoined = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrgName();
    getUserName();
    // joinedOrNot(userName, widget.EventId, widget.EventName);
  }

  getOrgName() async {
    DatabaseServices().getOrg(widget.orgId).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }

  getUserName() async {
    DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserName()
        .then((value) {
      setState(() {
        userName = value;
      });
    });
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            // Image.asset("cards/banner.jpg"),
            Image.network(widget.EventBanner),
            Column(
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      // "Event Name",
                      widget.EventName,
                      style:
                          AppTheme.appText(size: 12, weight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, color: Colors.white),
                    Text(
                      // "Thu May 16 • 8.30am",
                      widget.EventDate + " • " + widget.EventTime,
                      style:
                          AppTheme.appText(size: 12, weight: FontWeight.normal),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_sharp, color: Colors.white),
                    Text(
                      // "Jio World Convention Center",
                      widget.EventAddress,
                      style:
                          AppTheme.appText(size: 12, weight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
            Text(
              "About this event",
              style: AppTheme.appText(size: 14, weight: FontWeight.bold),
            ),
            Text(
              // "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
              widget.EventDesc,
              style: AppTheme.appText(size: 12, weight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                nextScreen(context, EventForm());
              },
              child: Text("Register for event"),
              style: AppTheme.buttonStyle3(
                  backColor: Color.fromARGB(255, 14, 99, 169)),
            ),
            SizedBox(height: 25),
            clipReact()
          ],
        ),
      )),
    );
  }

  joinedOrNot(String userName, String groupId, String groupName) async {
    var eventId = groupId + "_" + groupName;
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .isUserJoined(groupName, eventId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  clipReact() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    joinedOrNot(userName, widget.EventId, widget.EventName);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: deviceHeight / 3.2,
        width: deviceWidth / 2,
        color: AppTheme.greyColor,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "About the organizer",
              style: AppTheme.appText(
                  size: deviceWidth / 33, weight: FontWeight.w600),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            Text(
              "Organized by",
              style: AppTheme.appText(size: 15, weight: FontWeight.w400),
            ),
            SizedBox(height: 5),
            Text(
              orgName,
              style: AppTheme.appText(size: 12, weight: FontWeight.w300),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: InkWell(
                onTap: () async {
                  DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
                      .toggleGroupJoin(
                          widget.EventId, widget.EventName, userName);
                  if (isJoined) {
                    setState(() {
                      isJoined = !isJoined;
                    });
                    showSnackbar(context, Colors.red,
                        "Left the Event Group " + widget.EventName);
                  } else {
                    setState(() {
                      isJoined = !isJoined;
                    });
                    showSnackbar(context, Colors.green,
                        "Successfully Joined Group " + widget.EventName);
                    Future.delayed(const Duration(seconds: 2), () {
                      nextScreen(
                          context,
                          ChatPage(
                            EventId: widget.EventId,
                            orgId: widget.orgId,
                            EventName: widget.EventName,
                            EventBanner: widget.EventBanner,
                          ));
                    });
                  }
                },
                child: isJoined
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Text(
                          "Joined",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          "Join",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
            // style: AppTheme.buttonStyle3(
            //     backColor: Color.fromARGB(255, 14, 99, 169)),
            // )
          ],
        ),
      ),
    );
  }
}
