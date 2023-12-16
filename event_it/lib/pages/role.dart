import 'package:event_it/pages/login.dart';
import 'package:event_it/pages/loginOrg.dart';
import 'package:event_it/pages/org_register.dart';
import 'package:event_it/pages/user_register.dart';
import 'package:event_it/utils/app_theme.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : Container(
              height: deviceHeight,
              width: deviceWidth,
              color: AppTheme.backgroundColor,
              padding: const EdgeInsets.only(
                  top: 150, left: 40, right: 40, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: deviceWidth / 5,
                    height: deviceHeight / 5,
                  ),
                  SizedBox(height: 0),
                  Text("Select Your Role",
                      style: AppTheme.appText(
                        size: deviceWidth / 18,
                        weight: FontWeight.bold,
                      )),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: deviceHeight / 15,
                    width: deviceWidth / 1.7,
                    child: ElevatedButton(
                      style: AppTheme.buttonStyle(
                        fontSize: deviceWidth / 24,
                        backColor: AppTheme.slightBlack,
                      ),
                      onPressed: () {
                        nextScreen(context, LoginOrg());
                      },
                      child: Text(
                        "Organizer",
                        style: TextStyle(
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: deviceHeight / 15,
                    width: deviceWidth / 1.7,
                    child: ElevatedButton(
                      style: AppTheme.buttonStyle(
                        fontSize: deviceWidth / 24,
                        backColor: AppTheme.slightBlack,
                      ),
                      onPressed: () {
                        nextScreen(context, Login());
                      },
                      child: Text(
                        "User",
                        style: TextStyle(
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
