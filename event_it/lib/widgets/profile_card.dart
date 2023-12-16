import 'package:event_it/pages/event_page.dart';
import 'package:event_it/pages/login.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
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
  const ProfileCard({
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
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        nextScreen(context, EventPage(EventName: widget.EventName, EventAddress: widget.EventAddress, EventFee: widget.EventFee, EventDate: widget.EventDate, EventTime: widget.EventTime, isEventPaid: widget.isEventPaid, EventBanner: widget.EventBanner, orgId: widget.orgId, EventId: widget.EventId, EventDesc: widget.EventDesc));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth / 18, vertical: deviceHeight / 75),
            height: deviceHeight / 4.6,
            width: deviceWidth,
            color: AppTheme.interest1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      // "/cards/banner.jpg",
                      widget.EventBanner,
                      width: deviceWidth / 2,
                      height: deviceHeight / 5.3,
                    ),
                    10.pW,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.EventName,
                          style:
                              AppTheme.appText(size: 10, weight: FontWeight.w400),
                        ),
                        10.pH,
                        Text(
                          widget.EventDate
                          // +" • "+widget.EventTime
                          ,
                          style:
                              AppTheme.appText(size: 10, weight: FontWeight.w400),
                        ),
                        10.pH,
                        Text(
                          widget.EventAddress,
                          style:
                              AppTheme.appText(size: 10, weight: FontWeight.w400),
                        ),
                        10.pH,
                        Text(
                          widget.EventFee,
                          style:
                              AppTheme.appText(size: 10, weight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.pH,
        ],
      ),
    );
  }
}
