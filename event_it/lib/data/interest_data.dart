import 'package:flutter/material.dart';
import 'package:event_it/utils/app_theme.dart';

class ImageData {
  final String imagePath;
  final String name;
  final Color bgcolor;

  ImageData({
    required this.imagePath,
    required this.name,
    required this.bgcolor,
  });
}

class InterestList{
  List<ImageData> imageDataList = [
      ImageData(
        imagePath: "/Interests/football.png",
        name: "Football",
        bgcolor: AppTheme.interest1
      ),
      ImageData(
        imagePath: "/Interests/tech.png",
        name: "Tech",
        bgcolor: AppTheme.interest2
      ),
      ImageData(
        imagePath: "/Interests/swimming.png",
        name: "Swimming",
        bgcolor: AppTheme.interest3
      ),
      ImageData(
        imagePath: "/Interests/chess.png",
        name: "Chess",
        bgcolor: AppTheme.interest4
      ),
      ImageData(
        imagePath: "/Interests/carrom.png",
        name: "Carrom",
        bgcolor: AppTheme.interest5
      ),
      ImageData(
        imagePath: "/Interests/health.png",
        name: "Health",
        bgcolor: AppTheme.interest6
      ),
      ImageData(
        imagePath: "/Interests/table_tennis.png",
        name: "Table Tennis",
        bgcolor: AppTheme.interest7
      ),
      ImageData(
        imagePath: "/Interests/art.png",
        name: "Art",
        bgcolor: AppTheme.interest8
      ),
      ImageData(
        imagePath: "/Interests/cricket.png",
        name: "Cricket",
        bgcolor: AppTheme.interest9
      ),
      ImageData(
        imagePath: "/Interests/music.png",
        name: "Music",
        bgcolor: AppTheme.interest10
      ),
      
    ];
}