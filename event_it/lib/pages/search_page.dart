import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/utils/loading_theme.dart';
import 'package:event_it/widgets/event_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearch = false;
  String userName = "";
  User? user;
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppTheme.whiteColor),
          backgroundColor: AppTheme.backgroundColor,
          title: Text(
            "E-vent it!",
            style: LoadingTheme.appText(
                size: 22, weight: FontWeight.w500, color: AppTheme.whiteColor),
          ),
        ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintText: "Search Events",
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : groupList(),
        ],
      ),
    );
  }
  groupList(){
     return hasUserSearch
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return EventTile(
                  EventName: searchSnapshot!.docs[index]["EventName"],
                  EventBanner: searchSnapshot!.docs[index]["EventBanner"],
                  EventAddress: searchSnapshot!.docs[index]["EventAddress"],
                  EventDate: searchSnapshot!.docs[index]["EventDate"],
                  EventTime: searchSnapshot!.docs[index]["EventTime"],
                  EventDesc: searchSnapshot!.docs[index]["EventDesc"],
                  EventFee: searchSnapshot!.docs[index]["EventFee"],
                  isEventPaid: true,
                  EventId: searchSnapshot!.docs[index]["eventId"],
                  orgId: searchSnapshot!.docs[index]["orgId"]);      
            })
        : Container();
  }
  initiateSearchMethod()async{
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseServices()
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearch = true;
        });
      });
    }
  }
}
