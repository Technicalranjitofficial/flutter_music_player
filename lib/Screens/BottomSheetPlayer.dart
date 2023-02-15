import 'dart:io';
import 'dart:ui';

import 'package:audio_player/Components/ButtonRow.dart';
import 'package:audio_player/Screens/Progressbar.dart';
import 'package:audio_player/Screens/SongListPage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:get/get.dart';

class BottomSheetPlayer extends StatefulWidget {
  BottomSheetPlayer({super.key});

  @override
  State<BottomSheetPlayer> createState() => _BottomSheetPlayerState();
}

class _BottomSheetPlayerState extends State<BottomSheetPlayer> {
  double maximumValue = 0.0;
  double currentValue = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void setSong(SongInfo songs, int currentIndex) {
  //   currentIndex = widget.CurrentIndex;
  //   songs = widget.currentSongList[currentIndex];
  //   widget.player.setUrl(songs.filePath);
  //   widget.player.play();
  // }

  @override
  Widget build(BuildContext context) {
    print("Buld Context Bottom Sheet");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        primary: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.black,
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                Container(
                  height: 10,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Card(
                          elevation: 20,
                          color: Colors.black,
                          shadowColor: Colors.grey,
                          child: Consumer<manager>(
                            builder: (context, value, child) {
                              return TextScroll(
                                // value.songs[value.currentIndex].displayName,
                                "rem2",
                                delayBefore: Duration(milliseconds: 500),
                                velocity:
                                    Velocity(pixelsPerSecond: Offset(30, 0)),
                                mode: TextScrollMode.endless,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    fontFamily: "poppins",
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            },
                          )),
                      Consumer<manager>(
                        builder: (context, value, child) {
                          return Text(
                            // "${value.songs[value.currentIndex].artist.replaceAll('<', '').replaceAll('>', '')}"
                            "remaining",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          );
                        },
                      )
                    ]),
                  ),
                ),
                Spacer(),
                Card(
                  elevation: 20,
                  borderOnForeground: true,
                  margin: EdgeInsets.all(20),
                  shadowColor: Colors.grey,
                  color: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(250)),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 300,
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Consumer<manager>(
                                builder: (context, value, child) {
                              return QueryArtworkWidget(
                                  nullArtworkWidget: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/music2.jpg")),
                                  keepOldArtwork: true,
                                  size: 400,
                                  artworkBorder: BorderRadius.circular(2000),
                                  id: int.parse(
                                      value.songs[value.currentIndex].id),
                                  type: ArtworkType.AUDIO);
                            }))),
                    Container(
                        width: MediaQuery.of(context).size.width - 45,
                        decoration: BoxDecoration(),
                        child: PlayerProgress())
                  ]),
                ),
                Spacer(),
                // ButtonRow(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: Card(
                    color: Colors.black,
                    // shadowColor: Colors.blueGrey,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          splashRadius: 25,
                          autofocus: true,
                          alignment: Alignment.center,
                          iconSize: 40,
                          hoverColor: Colors.brown,
                          highlightColor: Colors.cyan,
                          splashColor: Colors.accents[12],
                          style: ButtonStyle(
                              animationDuration: Duration(seconds: 1),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black38)),
                          tooltip: "Prev",
                          enableFeedback: true,
                          icon: Icon(
                            Icons.skip_previous_rounded,
                          ),
                          onPressed: () {
                            context.read<manager>().prev();
                          },
                          color: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            iconSize: 40,
                            icon: Consumer<manager>(
                              builder: (context, value, child) {
                                return Icon(
                                  value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                );
                              },
                            ),
                            onPressed: () {
                              context.read<manager>().playPause();
                            },
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          splashRadius: 25,
                          autofocus: true,
                          alignment: Alignment.center,
                          iconSize: 40,
                          hoverColor: Colors.brown,
                          highlightColor: Colors.cyan,
                          splashColor: Colors.accents[12],
                          style: ButtonStyle(
                              animationDuration: Duration(seconds: 1),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black38)),
                          tooltip: "Next",
                          enableFeedback: true,
                          icon: Icon(
                            Icons.skip_next_rounded,
                          ),
                          onPressed: () {
                            // context.read<manager>().next();
                          },
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
