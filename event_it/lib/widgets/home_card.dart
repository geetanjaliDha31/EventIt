import 'package:event_it/pages/event_page.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class HomeCard extends StatefulWidget {
  final String? orgId;
  final String? EventName;
  final String? EventAddress;
  final String? EventDate;
  final bool isEventPaid;
  final String? EventFee;
  final String? EventTime;
  final String? EventBanner;
  final String EventId;
  final String? EventDesc;

  const HomeCard({
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
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool _saved = false;
  String orgName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrgName();
  }

  getOrgName() async {
    DatabaseServices().getOrg(widget.orgId!).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
                context,
                EventPage(
                    EventName: widget.EventName!,
                    EventAddress: widget.EventAddress!,
                    EventFee: widget.EventFee!,
                    EventDate: widget.EventDate!,
                    EventTime: widget.EventTime!,
                    isEventPaid: widget.isEventPaid,
                    EventBanner: widget.EventBanner!,
                    orgId: widget.orgId!,
                    EventId: widget.EventId!,
                    EventDesc: widget.EventDesc!));
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppTheme.interest1,
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: deviceWidth / 40,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.slightBlack,
                          child: Text(
                            orgName.substring(0, 1).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth / 40,
                        ),
                        DefaultTextStyle(
                          style: AppTheme.appText(
                              size: deviceWidth / 26,
                              weight: FontWeight.bold,
                              color: AppTheme.backgroundColor),
                          child: Text(
                            // "eveOrg",
                            orgName,
                            style: AppTheme.appText(
                                letterSpacing: 1,
                                size: deviceWidth / 25,
                                weight: FontWeight.w700,
                                color: AppTheme.backgroundColor),
                          ),
                        ),
                      ],
                    ),
                    180.pw,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _saved = !_saved;
                        });
                        // _saved? DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).removeEventFromUser(widget.EventId):DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).saveEventToUser(widget.EventId) ;
                        DatabaseServices(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .saveEventToUser(widget.EventId!);
                        // addevent();
                      },
                      child: Icon(
                        _saved ? Icons.bookmark : Icons.bookmark_border,
                        color: AppTheme.backgroundColor,
                      ),
                    )
                  ],
                ),
                Image.network(
                  widget.EventBanner!,
                  width: deviceWidth / 1.3,
                  height: deviceHeight / 3.5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth / 25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            // "Intel Pro Gamers",
                            widget.EventName!,
                            style: AppTheme.appText(
                                letterSpacing: 1,
                                size: deviceWidth / 28,
                                weight: FontWeight.w700,
                                color: AppTheme.backgroundColor),
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Icon(
                          //     CupertinoIcons.arrowshape_turn_up_right_fill,
                          //     color: AppTheme.backgroundColor,
                          //     size: deviceHeight / 37,
                          //   ),
                          // )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            // "Thu, May 16",
                            widget.EventDate!,
                            style: AppTheme.appText(
                                letterSpacing: 1,
                                size: deviceWidth / 32,
                                weight: FontWeight.w500,
                                color: AppTheme.backgroundColor),
                          ),
                          SizedBox(
                            width: deviceWidth / 60,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: deviceHeight / 150,
                          ),
                          SizedBox(
                            width: deviceWidth / 60,
                          ),
                          Text(
                            // "5:08 PM",
                            widget.EventTime!,
                            style: AppTheme.appText(
                                letterSpacing: 1,
                                size: deviceWidth / 32,
                                weight: FontWeight.w500,
                                color: AppTheme.backgroundColor),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // "JIO world convention centre",
                            widget.EventAddress!,
                            style: AppTheme.appText(
                                size: deviceWidth / 32,
                                weight: FontWeight.w500,
                                letterSpacing: 1,
                                color: AppTheme.backgroundColor),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: AppTheme.backgroundColor,
                            ),
                            width: deviceWidth / 9,
                            height: deviceHeight / 50,
                            child: Center(
                              child: widget.isEventPaid
                                  ? Text(
                                      widget.EventFee! + "/-",
                                      style: AppTheme.appText(
                                          size: deviceWidth / 50,
                                          weight: FontWeight.w600,
                                          color: AppTheme.whiteColor),
                                    )
                                  : Text(
                                      "FREE",
                                      style: AppTheme.appText(
                                          size: deviceWidth / 50,
                                          weight: FontWeight.w600,
                                          color: AppTheme.whiteColor),
                                    ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: deviceHeight / 50,
        )
      ],
    );
  }
  //  addevent() {
  //   print("object");
  //     Map<String, dynamic> chatMessaggeMap = {
  //       "eventId": widget.EventId,
  //       "EventName": widget.EventName,
  //       "EventAddress": widget.EventAddress,
  //       "EventFee": widget.EventFee,
  //       "EventDate": widget.EventDate,
  //       "EventTime": widget.EventTime,
  //       "EventDesc": widget.EventDesc,
  //       "EventBanner": widget.EventBanner,
  //       "isEventPaid": widget.isEventPaid,
  //       "orgId": widget.orgId,

  //     };
  //     DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid).addSaveEvent(widget.EventId, chatMessaggeMap);

  // }
}

extension Padding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}
