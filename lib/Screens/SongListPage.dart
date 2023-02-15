import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SOngListPage extends StatefulWidget {
  SOngListPage({super.key});

  @override
  State<SOngListPage> createState() => _SOngListPageState();
}

class _SOngListPageState extends State<SOngListPage> {
  GlobalThemes globalThemes = GlobalThemes();
  late ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollTo(context.read<manager>().currentIndex));
  }

  Future scrollTo(int index) async {
    // Future.delayed(Duration(seconds: 5));
    itemScrollController.jumpTo(index: index);
    // itemScrollController.scrollTo(
    //     index: index, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: globalThemes.colors2['bgColor'],
          actions: [
            IconButton(onPressed: () {
              context.read<manager>().clickToSuffle();
            }, icon: Consumer<manager>(
              builder: (context, value, child) {
                return Icon(
                  value.isLoopAll
                      ? Icons.loop
                      : value.isLoopOne
                          ? Icons.repeat_one
                          : Icons.shuffle,
                  color: globalThemes.colors2['IconBtn'],
                );
              },
            )),
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.delete,
            //       color: Color.fromARGB(255, 173, 53, 53),
            //     )),
          ],
          automaticallyImplyLeading: false,
          title: Consumer<manager>(
            builder: (context, value, child) {
              return Padding(
                  padding: const EdgeInsets.only(left: 1, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "${value.isLoopAll ? "LoopAll" : value.isLoopOne ? "Loop One" : "Shuffle"}",
                        style: TextStyle(
                            color: globalThemes.colors2['textColor2'],
                            fontWeight: FontWeight.w500,
                            fontFamily: "Oswald-Regular",
                            fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          value.songs.length.toString(),
                          style: TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                              fontFamily: "Oswald-Regular"),
                        ),
                      ),
                    ],
                  ));
            },
          )),
      body: Container(child: Consumer<manager>(
        builder: (context, value, child) {
          return ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemCount: value.songs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (value.currentIndex == index) {
                    Navigator.pop(context);
                  } else {
                    value.setSongs(value.songs, index, 2);
                    Navigator.pop(context);
                  }
                },
                child: value.currentIndex == index
                    ? ListTile(
                        selected: true,
                        title: Text(
                          "${value.songs[index].displayName}",
                          maxLines: 1,
                          style: TextStyle(color: Colors.cyan.shade700),
                        ),
                        subtitle: Text(
                          "Now Playing",
                          style: TextStyle(
                              fontFamily: "Oswald-Regular",
                              letterSpacing: 1,
                              color: Colors.green.shade800),
                        ),

                        // trailing: ,

                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: 30,
                            height: 30,

                            // color: Colors.white,
                            child: MiniMusicVisualizer(
                              color: Colors.cyan,
                              width: 4,
                              height: 15,
                            ),
                          ),
                        )
                        // trailing: IconButton(
                        //   splashRadius: 15,
                        //   padding: EdgeInsets.only(left: 10),
                        //   iconSize: 20,
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.pause,
                        //     color: globalThemes.colors['textColor'],
                        //   ),
                        // ),
                        )
                    : ListTile(
                        title: Text(
                          "${value.songs[index].displayName}",
                          maxLines: 1,
                          style: TextStyle(
                              color: globalThemes.colors2['textColor2'],
                              fontFamily: "Oswald-Regular"),
                        ),
                        subtitle: Text(
                          "${value.songs[index].artist.toString().replaceAll('<', '').replaceAll('>', '')}",
                          style: TextStyle(
                              fontFamily: "Oswald-Regular",
                              letterSpacing: 1,
                              color: Colors.grey.shade600),
                        ),
                        trailing: IconButton(
                          splashRadius: 15,
                          padding: EdgeInsets.only(left: 10),
                          iconSize: 20,
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_arrow,
                            color: globalThemes.colors['textColor2'],
                          ),
                        ),
                      ),
              );
            },
          );
        },
      )),
    );
  }
}
