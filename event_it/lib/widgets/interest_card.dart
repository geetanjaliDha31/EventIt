import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import '../utils/app_theme.dart';

class InterestCard extends StatefulWidget {
  final String Interest;
  final String ImgPath;
  final Color ColorBg;
  final List<String> selectedInterests; // Pass the selectedInterests list
  // final ValueChanged<String> onSelectionChanged;

  InterestCard({
    required this.Interest,
    required this.ImgPath,
    required this.ColorBg,
    List<String>? selectedInterests, // Change to optional
    // required this.onSelectionChanged,
  }) : selectedInterests = selectedInterests ?? [];

  @override
  State<InterestCard> createState() => _InterestCardState();
}

class _InterestCardState extends State<InterestCard> {
  bool isSelected= false;
  List<String> selectedInterests = [];
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });

        if (isSelected) {
          widget.selectedInterests.add(widget.Interest);
          print(widget.selectedInterests);
        } else {
          widget.selectedInterests.remove(widget.Interest);
          print(widget.selectedInterests);
        }

        // Notify the parent widget about the selection change
        // widget.onSelectionChanged(widget.Interest);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.ColorBg,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color:
                    isSelected ? AppTheme.whiteColor : AppTheme.backgroundColor,
                width: isSelected ? 3 : 0)),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: -70,
              child: Image.asset(
                widget.ImgPath,
                height: deviceHeight / 4,
                width: deviceWidth / 4,
              ),
            ),
            Positioned(
              left: 0,
              child: Text(
                widget.Interest,
                style: AppTheme.appText(
                    size: deviceWidth / 20, weight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
