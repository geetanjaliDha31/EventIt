// ignore_for_file: prefer_const_constructors

import 'package:event_it/services/dbServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_it/utils/app_theme.dart';

class GroupInfoPage extends StatefulWidget {
  final String EventName;
  final String EventId;
  final String orgId;
  final String EventBanner;

  const GroupInfoPage({
    super.key,
    required this.EventId,
    required this.orgId,
    required this.EventName,
    required this.EventBanner,
  });

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  Stream? members;
  String orgName = "";
  String userName = "";
  @override
  void initState() {
    super.initState();
    getMember();
    getOrgName();
  }

  getOrgName() async {
    DatabaseServices().getOrg(widget.orgId).then((value) {
      setState(() {
        orgName = value;
      });
    });
  }

  getUserName(id) async {
    DatabaseServices().getMemberUsersName(id).then((value) {
      userName = value;
    });
    return userName;
  }

  getMember() async {
    DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.EventId)
        .then((value) {
      setState(() {
        members = value;
      });
    });
  }

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.EventName,
          style: AppTheme.appText(size: 21, weight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  //height
                  Image.network(widget.EventBanner, width: 500, height: 200),
                  Center(
                    child: Text(
                      widget.EventName,
                      style:
                          AppTheme.appText(size: 20, weight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.slightBlack),
                    alignment: Alignment.center,
                    width: deviceWidth / 1,
                    height: deviceHeight / 15,
                    child: Text(orgName,
                        style: AppTheme.appText(
                            size: 15, weight: FontWeight.normal)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 3,
              ),
              // memberList()
            ],
          ),
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data["members"] != null) {
            if (snapshot.data["members"].length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data["members"].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          title: Center(
                            child: Text(
                              getUserName(snapshot.data["members"][index])
                                  .toString(),
                              style: AppTheme.appText(
                                size: 14,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                          tileColor: AppTheme.slightBlack,
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    );
                  });
            } else {
              return Center(
                child: const Text(
                  "NO Members!",
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                "NO Members!",
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }

  Future<String> convertFutureToString(Future<dynamic> futureDynamic) async {
    // Wait for the future to resolve
    dynamic result = await futureDynamic;

    // Convert the dynamic result to a string
    String stringResult = result.toString();

    // Return the string result
    return stringResult;
  }
}
