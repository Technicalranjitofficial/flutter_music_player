import 'dart:async';

import 'package:audio_player/Screens/HomePage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<manager>().getSongsListMain();
    context.read<manager>().getSongsList();
    context.read<manager>().getPlayList();
    context.read<manager>().ListArtist();
    // await context.read<manager>().getSongsList();
    context.read<manager>().ListArtist();
    WidgetsBinding.instance.addPostFrameCallback((_) => gotonext());
  }

  GlobalThemes globalThemes = GlobalThemes();
  var colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  var colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
  gotonext() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalThemes.colors2['bgColor'],
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: globalThemes.colors2['bgColor'],
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'MUSIC',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
          ),
        ),
      ),
    );
  }
}
