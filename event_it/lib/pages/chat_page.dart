import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_it/pages/groupinfo_page.dart';
import 'package:event_it/pages/messageTile.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String EventId;
  final String orgId;
  final String EventName;
  final String EventBanner;

  const ChatPage({
    super.key,
    required this.EventId,
    required this.orgId,
    required this.EventName,
    required this.EventBanner,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isLoading = false;
  Stream<QuerySnapshot>? chats;
  String sId = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getChat();
    super.initState();
  }

  getChat() async {
    DatabaseServices().getChat(widget.EventId).then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
            backgroundColor: AppTheme.backgroundColor,
            centerTitle: true,
            elevation: 0,
            // leading: CircleAvatar(
            //     radius: 40, backgroundImage: AssetImage("/cards/cat.jpg")),
            title: Text(
              widget.EventName,
              style: AppTheme.appText(size: 21, weight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      GroupInfoPage(
                        EventId: widget.EventId,
                        orgId: widget.orgId,
                        EventName: widget.EventName,
                        EventBanner: widget.EventBanner,
                      ));
                },
                icon: const Icon(Icons.info_outline_rounded),
                color: AppTheme.whiteColor,
              ),
            ]),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.blueColor),
              )
            : Stack(
                children: <Widget>[
                  chatMessages(),
                  Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: deviceHeight / 14,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        color: AppTheme.slightBlack,
                        child: Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Icon(
                            //     Icons.insert_photo_outlined,
                            //     size: 26,
                            //     color: AppTheme.whiteColor,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 12,
                            // ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: AppTheme.appText(
                                      size: deviceWidth / 24,
                                      weight: FontWeight.w300),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                sendMessage();
                              },
                              child: Icon(
                                Icons.send,
                                size: 26,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ));
  }

  chatMessages() {
    print("hello");
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      // sender: snapshot.data.docs[index]['sender'],
                      orgid: widget.orgId,
                      sid: snapshot.data.docs[index]['senderId'],
                      sentByMe: sId == snapshot.data.docs[index]['senderId']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessaggeMap = {
        "message": messageController.text,
        "senderId": sId,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseServices().sendMessage2(widget.EventId, chatMessaggeMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
