import 'package:audio_player/Components/Players/player3.dart';
import 'package:audio_player/Components/Visualizer.dart';
import 'package:audio_player/Player2.dart';
import 'package:audio_player/Screens/BottomSheetPlayer.dart';
import 'package:audio_player/StateManager/GetXStorage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class BottomPlayContainer extends StatefulWidget {
  BottomPlayContainer({super.key});

  @override
  State<BottomPlayContainer> createState() => _BottomPlayContainerState();
}

class _BottomPlayContainerState extends State<BottomPlayContainer> {
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  late GlobalThemes globalThemes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalThemes = GlobalThemes();
  }

  @override
  Widget build(BuildContext context) {
    print("Buld Context Bottom");
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          // context.read<manager>().initEqalizer();
          // if (context.read<manager>().isEqEnabled) {
          //   context.read<manager>().setEqEnabled(true);
          // }
          showModalBottomSheet(
            useRootNavigator: true,
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => Consumer<manager>(
              builder: (context, value, child) {
                return value.currentPlayer;
              },
            ),
          );
        },

        // Consumer<manager>(builder: (context, value, child) {
        //   return value.CurrentThemes;

        // })

        // value ?? Player2());
        // }),
        //
        // showModalBottomSheet(
        //     useRootNavigator: true,
        //     isDismissible: true,
        //     enableDrag: true,
        //     isScrollControlled: true,
        //     context: context,
        //     builder: (context) =>
        //         // Consumer<manager>(builder: (context, value, child) {
        //         //   return value.CurrentThemes;
        //         // })

        //         ),

        child: Container(
          height: 65,
          width: MediaQuery.of(context).size.width,
          color: globalThemes.colors['bgColor'],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-1, -1),
                        color: globalThemes.colors['boxShadowWhite']!,
                        blurRadius: 5),
                    BoxShadow(
                        offset: Offset(4, 4),
                        color: globalThemes.colors['boxShadowDark']!,
                        blurRadius: 5),
                  ],
                  color: globalThemes.colors2['bgColor'],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 2),
                          child: Stack(children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 2),
                              width: 70,
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(-1, -1),
                                        color: globalThemes
                                            .colors['boxShadowWhite']!,
                                        blurRadius: 2),
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: globalThemes
                                            .colors['boxShadowDark']!,
                                        blurRadius: 2),
                                  ],
                                  color: globalThemes.colors2['bgColor'],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Consumer<manager>(
                                builder: (context, value, child) {
                                  // return Container();

                                  return value.currentIndex <=
                                          value.songs.length - 1
                                      ? QueryArtworkWidget(
                                          nullArtworkWidget: Container(
                                            width: 70,
                                            height: 60,
                                            child: Stack(children: [
                                              Container(
                                                width: 70,
                                                height: 60,
                                                child: Image.asset(
                                                    "assets/images/music4.jpg"),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    backgroundBlendMode:
                                                        BlendMode.multiply,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              )
                                            ]),
                                          ),
                                          artworkFit: BoxFit.cover,
                                          keepOldArtwork: true,
                                          artworkHeight: 70,
                                          artworkWidth: 60,
                                          artworkBorder: BorderRadius.all(
                                              Radius.circular(10)),
                                          id: int.parse(value
                                              .songs[value.currentIndex].id),
                                          type: ArtworkType.AUDIO,
                                        )
                                      : Container();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              width: 69,
                              height: 59,
                              decoration: BoxDecoration(
                                color:
                                    globalThemes.colors2['playerThemesColor2'],
                                backgroundBlendMode: globalThemes.PlayerTheme2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            )
                          ]),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Consumer<manager>(
                                builder: (context, value, child) {
                                  return value.currentIndex <=
                                          value.songs.length - 1
                                      ? TextScroll(
                                          "${value.songs[value.currentIndex].displayName}",
                                          style: TextStyle(
                                              color: globalThemes
                                                  .colors2['textColor2'],
                                              fontFamily: "BebasNeue-Regular"),
                                          velocity: Velocity(
                                              pixelsPerSecond: Offset(10, 20)),
                                        )
                                      : Text("");
                                },
                              )),
                          Text(
                            "Sub titles ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 10,
                                color: globalThemes.colors2['textColor2']),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(children: [
                          InkWell(onTap: () {
                            context.read<manager>().playPause();
                          }, child: Consumer<manager>(
                            builder: (context, value, child) {
                              return Icon(
                                  value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                  color: globalThemes.colors2['IconBtn']);
                            },
                          )

                              //  Icon(
                              //     Icons.play_arrow,
                              //     size: 30,
                              //     color: Colors.white,
                              //   ),
                              ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<manager>().next();
                            },
                            child: Icon(
                              Icons.skip_next,
                              size: 30,
                              color: globalThemes.colors2['IconBtn'],
                            ),
                          ),
                        ])),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
