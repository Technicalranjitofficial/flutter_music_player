import 'package:audio_player/Components/ButtonRow.dart';
import 'package:audio_player/Components/Players/ProgressBar3.dart';
import 'package:audio_player/Components/ProgressBar2.dart';
import 'package:audio_player/Components/moreDialog.dart';
import 'package:audio_player/Screens/Progressbar.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:text_scroll/text_scroll.dart';

class Player3 extends StatelessWidget {
  Player3({super.key});

// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();

//   context.read<manager>().initEqalizer();
//   if (context.read<manager>().isEqEnabled) {
//     context.read<manager>().setEqEnabled(true);
//   }
  GlobalThemes globalThemes = GlobalThemes();

  @override
  Widget build(BuildContext context) {
    print("Player 2");

    print("Player 2${context.read<manager>().player.androidAudioSessionId}");
    return Scaffold(
      backgroundColor: globalThemes.colors2['bgColor'],
      body: ColorfulSafeArea(
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).viewInsets.top + 130,
              decoration: BoxDecoration(
                // color: Colors.white38
                color: globalThemes.colors2['bgColor'],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Card(
                  color: globalThemes.colors2['bgColor'],
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: [
                        btnShuffle(
                            globalThemes.colors2['btnColor'],
                            globalThemes.colors2['IconBtn'],
                            globalThemes.colors2['boxShadowWhite'],
                            globalThemes.colors2['boxShadowDark']),
                        Spacer(),
                        Text(
                          "Playing Now",
                          style: TextStyle(
                              fontFamily: "BebasNeue-Regular",
                              fontSize: 25,
                              color: globalThemes.colors2['textColor1']),
                        ),
                        Spacer(),
                        BtnMenu(
                            Icons.menu,
                            globalThemes.colors2['btnColor'],
                            globalThemes.colors2['IconBtn'],
                            globalThemes.colors2['boxShadowWhite'],
                            globalThemes.colors2['boxShadowDark'],
                            globalThemes.colors2['textColor2'])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // CircleImage(context),
            Spacer(),
            circleView(
              context,
              globalThemes.colors2['bgColor'],
              globalThemes.colors2['boxShadowWhite'],
              globalThemes.colors2['boxShadowDark'],
              globalThemes.PlayerTheme,
              globalThemes.colors2['playerThemesColor'],
            ),
            // Songs title
            Spacer(),
            SongsInfo(globalThemes.colors2['textColor2']),
            Spacer(),

            //Seekbar
            // seekbar(
            //   globalThemes.colors2['SeekBarBaseColor'],
            //   globalThemes.colors2['SeekBarColor'],
            //   globalThemes.colors2['SeekBarHandler'],
            //   globalThemes.colors2['boxShadowWhite'],
            //   globalThemes.colors2['boxShadowDark'],
            // ),

            ButtonRow(
                context,
                globalThemes.colors2['bgColor'],
                globalThemes.colors2['boxShadowWhite'],
                globalThemes.colors2['boxShadowDark'],
                globalThemes.colors2['IconBtn'],
                globalThemes.colors2['textColor2']),

            Spacer(),
            Container(
              height: 70,
              // color: Color.fromARGB(255, 49, 48, 48),
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // btn1(Icons.skip_previous, prev),
                  btnPrev(
                      context,
                      Icons.skip_previous,
                      globalThemes.colors2['btnColor'],
                      globalThemes.colors2['IconBtn'],
                      globalThemes.colors2['boxShadowWhite'],
                      globalThemes.colors2['boxShadowDark']),
                  // btn1(Icons.play_arrow, Colors.cyan.shade900),
                  btnplay(
                    context,
                    globalThemes.colors2['BtnPlay'],
                    globalThemes.colors2['boxShadowWhite'],
                    globalThemes.colors2['boxShadowDark'],
                    globalThemes.colors2['BtnPlayIcon'],
                  ),
                  // btn1(Icons.skip_next, next(context)),
                  btnnext(
                      context,
                      Icons.skip_next,
                      globalThemes.colors2['btnColor'],
                      globalThemes.colors2['IconBtn'],
                      globalThemes.colors2['boxShadowWhite'],
                      globalThemes.colors2['boxShadowDark']),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget SongsInfo(textColor2) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Consumer<manager>(
                    builder: (context, value, child) {
                      return Text(
                          "${value.Cmin < 10 ? "0${value.Cmin}" : value.Cmin} : ${value.Csec < 10 ? "0${value.Csec}" : value.Csec}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.oswald(
                              fontSize: 12,
                              textStyle: TextStyle(color: textColor2)));
                    },
                  )),
            ),
            Expanded(
                flex: 10,
                child: Consumer<manager>(
                  builder: (context, value, child) {
                    return TextScroll(
                      "${value.songs[value.currentIndex].displayName}",
                      textDirection: TextDirection.ltr,
                      mode: TextScrollMode.endless,
                      textAlign: TextAlign.justify,
                      velocity: Velocity(pixelsPerSecond: Offset(20, 20)),
                      style: TextStyle(
                        fontFamily: "Oswald-Regular",
                        color: globalThemes.colors2['textColor2'],
                        fontSize: 20,
                      ),
                    );
                  },
                )),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Consumer<manager>(
                    builder: (context, value, child) {
                      return Text(
                          "${value.Tmin < 10 ? "0${value.Tmin}" : value.Tmin} : ${value.Tsec < 10 ? "0${value.Tsec}" : value.Tsec}",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.oswald(
                              textStyle:
                                  TextStyle(color: textColor2, fontSize: 12)));
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget circleView(BuildContext context, bgcolor, whiteShadow, blackShadow,
      playerTheme, PlayerThemeColor) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgcolor,
        boxShadow: [
          BoxShadow(offset: Offset(-4, -4), color: whiteShadow, blurRadius: 5),
          BoxShadow(offset: Offset(4, 4), color: blackShadow, blurRadius: 5),
        ],
      ),
      child: Stack(
        children: [
          Consumer<manager>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: QueryArtworkWidget(
                    artworkFit: BoxFit.fill,
                    nullArtworkWidget: CircleAvatar(
                        radius: 2000,
                        backgroundImage:
                            AssetImage("assets/images/music4.jpg")),
                    artworkWidth: 380,
                    artworkHeight: 380,
                    artworkQuality: FilterQuality.high,
                    artworkBlendMode: BlendMode.hue,
                    size: 1000,
                    quality: 100,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(200),
                    id: int.parse(value.songs[value.currentIndex].id),
                    type: ArtworkType.AUDIO),
              );
            },
          ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PlayerThemeColor,
              backgroundBlendMode: playerTheme,
            ),
          ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
              backgroundBlendMode: BlendMode.multiply,
            ),
          ),
          PlayerProgress3(),
        ],
      ),
    );
  }

  Widget BtnMenu(
      IconData icon, bgColor, IconBtn, shadowWhite, shadowBlack, textColor2) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              offset: Offset(-1, -1),
              color: shadowWhite,
              // spreadRadius: 0.5,
              blurRadius: 5),
          BoxShadow(
              offset: Offset(2, 2),
              color: shadowBlack,
              blurRadius: 5,
              spreadRadius: 2),
        ],
      ),
      child: IconButton(
        // iconSize: 20,
        icon: Icon(icon, color: IconBtn),
        onPressed: () {
          Get.defaultDialog(
              title: "Menu",
              content: DialogMore(),
              titleStyle: TextStyle(color: textColor2));
        },
      ),
    );
  }

  Widget btnShuffle(bgColor, IconBtn, shadowWhite, shadowBlack) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
              offset: Offset(-1, -1),
              color: shadowWhite,
              // spreadRadius: 0.5,
              blurRadius: 5),
          BoxShadow(
              offset: Offset(2, 2),
              color: shadowBlack,
              blurRadius: 5,
              spreadRadius: 2),
        ],
      ),
      child: Consumer<manager>(
        builder: (context, value, child) {
          return IconButton(
              // iconSize: 20,
              icon: Icon(
                  value.isSuffleOn
                      ? Icons.shuffle
                      : value.isLoopAll
                          ? Icons.loop
                          : Icons.repeat_one,
                  color: IconBtn),
              onPressed: () {
                context.read<manager>().clickToSuffle();
                Get.snackbar(
                    "Smart Music Player",
                    "${value.isLoopAll ? "Loop Mode" : value.isLoopOne ? "Loop Current" : "Suffle Mode"}",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundGradient: LinearGradient(colors: [
                      Colors.cyan,
                      Colors.purple,
                      Colors.deepPurple
                    ]),
                    borderRadius: 15,
                    dismissDirection: DismissDirection.horizontal,
                    isDismissible: true,
                    duration: Duration(seconds: 1),
                    overlayColor: Colors.black,
                    animationDuration: Duration(milliseconds: 500),
                    boxShadows: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Colors.black,
                          spreadRadius: 20,
                          offset: Offset(10, 1))
                    ]);
              });
        },
      ),
    );
  }

  Widget btn1(IconData icon, Function getfun, bgColor, IconBtn, shadowWhite,
      shadowBlack) {
    return Container(
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle,

            // borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1, -1),
                  color: shadowWhite,
                  // spreadRadius: 0.5,
                  blurRadius: 5),
              BoxShadow(
                  offset: Offset(2, 2),
                  color: shadowBlack,
                  blurRadius: 5,
                  spreadRadius: 2),
            ]),
        child: IconButton(
            splashRadius: 40,
            padding: EdgeInsets.all(20),
            splashColor: Color.lerp(Colors.cyan, Colors.purpleAccent, 10),
            onPressed: () {
              getfun();
            },
            icon: Icon(icon, color: IconBtn)));
  }

  Widget btnnext(BuildContext context, IconData icon, bgColor, IconBtn,
      shadowWhite, shadowBlack) {
    return Container(
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle,

            // borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1, -1),
                  color: shadowWhite,
                  // spreadRadius: 0.5,
                  blurRadius: 5),
              BoxShadow(
                  offset: Offset(2, 2),
                  color: shadowBlack,
                  blurRadius: 5,
                  spreadRadius: 2),
            ]),
        child: IconButton(
            splashRadius: 40,
            padding: EdgeInsets.all(20),
            splashColor: Color.lerp(Colors.cyan, Colors.purpleAccent, 10),
            onPressed: () {
              context.read<manager>().next();
            },
            icon: Icon(icon, color: IconBtn)));
  }

  Widget btnPrev(BuildContext context, IconData icon, bgColor, IconBtn,
      shadowWhite, shadowBlack) {
    return Container(
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle,

            // borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1, -1),
                  color: shadowWhite,
                  // spreadRadius: 0.5,
                  blurRadius: 5),
              BoxShadow(
                  offset: Offset(2, 2),
                  color: shadowBlack,
                  blurRadius: 5,
                  spreadRadius: 2),
            ]),
        child: IconButton(
            splashRadius: 40,
            padding: EdgeInsets.all(20),
            splashColor: Color.lerp(Colors.cyan, Colors.purpleAccent, 10),
            onPressed: () {
              context.read<manager>().prev();
            },
            icon: Icon(icon, color: IconBtn)));
  }

  Widget btnplay(
      BuildContext context, btnPlay, whiteShadow, blackShadow, BtnPlayIcon) {
    return Container(
        decoration: BoxDecoration(color: btnPlay, shape: BoxShape.circle,

            // borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-1, -1),
                  color: whiteShadow,
                  // spreadRadius: 0.5,
                  blurRadius: 5),
              BoxShadow(
                  offset: Offset(2, 2),
                  color: blackShadow,
                  blurRadius: 5,
                  spreadRadius: 2),
            ]),
        child: IconButton(
          splashRadius: 40,
          padding: EdgeInsets.all(20),
          splashColor: Color.lerp(Colors.cyan, Colors.purpleAccent, 10),
          onPressed: () {
            context.read<manager>().playPause();
          },
          icon: Consumer<manager>(
            builder: (context, value, child) {
              return Icon(
                value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: BtnPlayIcon,
              );
            },
          ),
        ));
  }
}
