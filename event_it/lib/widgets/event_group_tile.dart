import 'package:event_it/pages/chat_page.dart';
import 'package:event_it/pages/event_page.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EventGroupTile extends StatefulWidget {
  final String orgId;
  final String EventName;
 
  final String EventBanner;
  final String EventId;
  const EventGroupTile({
    super.key,
    required this.EventName,
    
    required this.EventBanner,
    required this.orgId,
    required this.EventId,
  });

  @override
  State<EventGroupTile> createState() => _EventGroupTileState();
}

class _EventGroupTileState extends State<EventGroupTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // nextScreen(context, EventPage(EventName: widget.EventName, EventAddress: widget.EventAddress, EventFee: widget.EventFee, EventDate: widget.EventDate, EventTime: widget.EventTime, isEventPaid: widget.isEventPaid, EventBanner: widget.EventBanner, orgId: widget.orgId, EventId: widget.EventId, EventDesc: widget.EventDesc));
        nextScreen(context, ChatPage(EventId: widget.EventId,orgId: widget.orgId,EventName: widget.EventName,EventBanner: widget.EventBanner,));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1),
          side: BorderSide(
            color: AppTheme.slightBlack,
          ),
        ),
        elevation: 6,
        shadowColor: AppTheme.whiteColor,
        child: ListTile(
          tileColor: AppTheme.greyColor,
          leading: Container(
            child: FittedBox(
                fit: BoxFit.contain,
                child: CircleAvatar(
                    radius: 4,
                    backgroundImage: NetworkImage(widget.EventBanner))),
            height: deviceHeight / 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          title: Text(
            widget.EventName,
            style: AppTheme.appText(size: 14, weight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
