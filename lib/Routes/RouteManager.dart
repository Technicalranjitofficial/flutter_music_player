import 'package:audio_player/Components/SplashScreen.dart';
import 'package:audio_player/Pages/ArtistPage.dart';
import 'package:audio_player/Screens/Artists.dart';
import 'package:audio_player/Screens/CommonStyle.dart';
import 'package:audio_player/Screens/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String Home = "./";
  static const String Artist = "./artist";
  static const String Common = "./common";
  static const String BottomSheetModal = "./bottomsheet";
  static const String BottomPlayer = "./bottom";
  static const String splashScreen = "./splashscreen";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Home:
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
      case Artist:
        return MaterialPageRoute(
          builder: (context) => FetcArtist(),
        );
      case Home:
        return MaterialPageRoute(
          builder: (context) => MyHomePage(),
        );
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      default:
        throw FormatException("Wrong Format Value");
    }
  }
}
