// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:event_it/pages/org_setting.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OrgAboutUs extends StatefulWidget {
  const OrgAboutUs({Key? key}) : super(key: key);

  @override
  State<OrgAboutUs> createState() => _OrgAboutUsState();
}

class _OrgAboutUsState extends State<OrgAboutUs> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(
          "About Us",
          style: AppTheme.appText(
            size: 21,
            weight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            color: AppTheme.whiteColor,
            size: 26,
          ),
          onPressed: () {
            nextScreen(context, OrgSettingPage());
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: deviceHeight / 5),
                    child: Text(
                      'The Event Management System using Artificial Intelligence in Android aims to revolutionize the conventional event management process, offering a more efficient, accurate, and easy alternative. The proposed system will reduce organizational workload, minimize errors, and facilitate easier registration for events. By leveraging AI recommendation technology and the convenience of mobile devices, this application will offer a modern solution to advertise and register events, workshops, and competitions.',
                      textAlign: TextAlign.center,
                      style: AppTheme.appText(
                        size: 14,
                        weight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
