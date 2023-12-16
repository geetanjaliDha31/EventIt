import 'dart:io';
import 'package:event_it/pages/createEvent2.dart';
import 'package:event_it/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import '../utils/app_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool _isLoading = false;

  File? image1;

  String imgUrl= "";

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      XFile? file = image;
      print('${file?.path}');

      if (file == null) return;

      // get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      String uniqueName = DateTime.now().toString();

      // get a reference to file
      Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

      try {
        //store image
        await referenceImageToUpload.putFile(File(file!.path));
        //success get download link
        imgUrl = await referenceImageToUpload.getDownloadURL();
      } catch (e) {
        print("error code : $e");
      }

      // Directory tempDir = await getTemporaryDirectory();
      // final String path = tempDir.path;
      // final File newImage = await image.copy('$path/image1.png');

      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image1 = imageTemp;
      });
    } on PlatformException catch (e) {
      print('failed to pick $e');
    }
  }

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
                  image1 != null
                      ? Image.file(image1!,
                          width: 160, height: 160, fit: BoxFit.cover)
                      : Image.asset(
                          "assets/logo.png",
                          width: deviceWidth / 5,
                          height: deviceHeight / 5,
                        ),
                  SizedBox(height: 0),
                  Text("Create Your Event",
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
                        pickImage(ImageSource.gallery);
                      },
                      child: Text(
                        "Pick Gallery",
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
                        pickImage(ImageSource.camera);
                      },
                      child: Text(
                        "Pick camera",
                        style: TextStyle(
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: deviceHeight / 15,
                    width: deviceWidth / 1.7,
                    child: ElevatedButton(
                      style: AppTheme.buttonStyle(
                        fontSize: deviceWidth / 24,
                        backColor: AppTheme.slightBlack,
                      ),
                      onPressed: () {
                        nextScreen(context, createEvent2(image: image1!, imgUrl: imgUrl,));
                      },
                      child: Text(
                        "Next",
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
