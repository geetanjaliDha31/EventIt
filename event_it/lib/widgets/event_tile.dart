import 'package:event_it/pages/event_page.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
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
  const EventTile({
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
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        nextScreen(context, EventPage(EventName: widget.EventName, EventAddress: widget.EventAddress, EventFee: widget.EventFee, EventDate: widget.EventDate, EventTime: widget.EventTime, isEventPaid: widget.isEventPaid, EventBanner: widget.EventBanner, orgId: widget.orgId, EventId: widget.EventId, EventDesc: widget.EventDesc));
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
