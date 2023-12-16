import 'package:event_it/pages/user_home.dart';
import 'package:event_it/services/dbServices.dart';
import 'package:event_it/widgets/interest_card.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:event_it/utils/app_theme.dart';
import '../Data/Interest_data.dart';
import 'package:event_it/Data/Interest_data.dart' show InterestList;

class Interests extends StatefulWidget {
  const Interests({
    super.key,
  });

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  bool _isLoading = false;
  bool isSelected = false;
  List<String> selectedInterests = [];
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    List imgData = InterestList().imageDataList;

  updateUserInterests() async {
    DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .setUserInterests(selectedInterests);
  }

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.blueColor),
            )
          : SingleChildScrollView(
              child: Container(
                height: deviceHeight,
                width: deviceWidth,
                color: AppTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                      Text("Select Your Interest",
                          style: AppTheme.appText(
                            size: deviceWidth / 16,
                            weight: FontWeight.bold,
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                          height: deviceHeight / 1.6,
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 3 / 2),
                              itemCount: imgData.length,
                              itemBuilder: (context, index) {
                                return InterestCard(
                                  Interest: imgData[index].name,
                                  ImgPath: imgData[index].imagePath,
                                  ColorBg: imgData[index].bgcolor,
                                  selectedInterests:
                                      selectedInterests, // Pass the selectedInterests list
                                  // onSelectionChanged: (value) {
                                    
                                  // },
                                );
                              })),
                      SizedBox(
                        height: deviceHeight / 20,
                        width: deviceWidth / 1.7,
                        child: ElevatedButton(
                          style: AppTheme.buttonStyle(
                              backColor: AppTheme.blueColor),
                          onPressed: () {
                             print(selectedInterests);
                             updateUserInterests();
                            nextScreen(context, UserHome());
                          },
                          child: Text("Next",
                              style: AppTheme.appText(
                                  size: deviceWidth / 26,
                                  weight: FontWeight.w300)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
