import 'dart:collection';

import 'package:audio_player/DBHandling/DB.dart';
import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/Screens/PlayList/AddPlayListSongPage.dart';
import 'package:audio_player/Screens/PlayList/PlayListAddCustom.dart';
import 'package:audio_player/Screens/PlayList/PlayListSongCustomDesign.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SongListOfPlayList extends StatefulWidget {
  SongListOfPlayList({super.key, required this.PlayListId});

  String PlayListId;

  @override
  State<SongListOfPlayList> createState() => _SongListOfPlayListState();
}

class _SongListOfPlayListState extends State<SongListOfPlayList> {
  // late List<SongInfo> songList;
  DB db = DB();
  late List<String> ListOfId = [];
  late List<SongInfo> currentPlayListSOng = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    currentPlayListSOng.clear();
    ListOfId.clear();
    await db.getPlayListSongData(widget.PlayListId).then((value) async {
      for (var each in value) {
        ListOfId.add(each.songId);
      }
      // final Matching = HashSet.from(songsList);
      final Matching = HashSet.from(ListOfId);
      currentPlayListSOng.addAll(context
          .read<manager>()
          .getSongList
          .where((element) => Matching.contains(element.id.toString())));
    });
    setState(() {
      currentPlayListSOng = currentPlayListSOng;
      print("Here is the length:${ListOfId.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.PlayListId}",
            style: TextStyle(color: globalThemes.colors2['textColor3']),
          ),
          backgroundColor: globalThemes.colors2['bgColor'],
        ),
        body: Stack(
          children: [
            Consumer<manager>(
              builder: (context, value, child) {
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                    return;
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 200,
                        mainAxisSpacing: 10),
                    itemCount: currentPlayListSOng.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return InkWell(
                            onTap: () async {
                              context.read<manager>().generate();
                              var x = await Get.to(
                                  () => AddPlayListSongPage(
                                      PlayListId: widget.PlayListId),
                                  fullscreenDialog: true,
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500),
                                  transition: Transition.zoom,
                                  preventDuplicates: true);
                              if (x) {
                                setState(() {
                                  getdata();
                                });
                              }
                            },
                            child: CustomAdd(context, "Add Song"));
                      }
                      return InkWell(
                        onLongPress: () async {
                          var res = await Get.defaultDialog(
                              title: "Menu",
                              content: TextButton(
                                  onPressed: () async {
                                    try {
                                      if (value.playerAvailable) {
                                        if (currentPlayListSOng[index - 1].id ==
                                            value
                                                .songs[value.currentIndex].id) {
                                          Fluttertoast.showToast(
                                              msg: "Currently Playing");
                                          return;
                                        } else {
                                          var res = await value.deleteSOngs(
                                              widget.PlayListId,
                                              currentPlayListSOng[index - 1]
                                                  .id
                                                  .toString());

                                          if (res) {
                                            Fluttertoast.showToast(
                                                msg: "Song Removed");
                                            Get.back(result: true);
                                          } else {
                                            Get.back(result: false);
                                          }
                                        }
                                      } else {
                                        var res = await value.deleteSOngs(
                                            widget.PlayListId,
                                            currentPlayListSOng[index - 1]
                                                .id
                                                .toString());

                                        if (res) {
                                          Get.back(result: true);
                                        } else {
                                          Get.back(result: false);
                                        }
                                      }
                                    } catch (e) {
                                      Fluttertoast.showToast(msg: e.toString());
                                    }
                                  },
                                  child: Text("Remove")));

                          if (res) {
                            setState(() {
                              getdata();
                            });
                          }
                        },
                        onTap: () {
                          // final getCurrentSonglist = songList;
                          context.read<manager>().setSongs(
                              currentPlayListSOng, index - 1, 10000 + index);
                        },
                        child: PlayListSongCustomDesign(
                            songInfo: currentPlayListSOng[index - 1]),
                      );
                    },
                  ),
                );
                // return ListView.builder(
                //   itemCount: context.read<manager>().currentPlayListSOng.length + 1,
                //   itemBuilder: (context, index) {
                // if (index == 0) {
                //   return InkWell(
                //     onTap: () async {
                //       var x = await Get.to(
                //           () => AddPlayListSongPage(
                //               PlayListId: widget.PlayListId),
                //           fullscreenDialog: true,
                //           curve: Curves.linear,
                //           duration: Duration(milliseconds: 500),
                //           transition: Transition.zoom,
                //           preventDuplicates: true);
                //       if (x) {
                //         value.getData(widget.PlayListId);
                //       }
                //     },
                //     child: ListTile(
                //       title: Text("Add Songs"),
                //     ),
                //   );
                // }
                // return InkWell(
                //   onTap: () {
                //     // context.read<manager>().insertSongPlaylist(
                //     //     context.read<manager>().getSongList[index].id,
                //     //     widget.PlayListId);

                //     context.read<manager>().setSongs(
                //         value.currentPlayListSOng, index, 10000 + index);
                //   },
                //   child: ListTile(
                //     title: Text(
                //         "${value.currentPlayListSOng[index - 1].displayName}"),
                //   ),
                //     // );
                //   },
                // );
              },
            ),
            Consumer<manager>(
              builder: (context, value, child) {
                return value.playerAvailable
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomPlayContainer(),
                      )
                    : Container();
              },
            )
          ],
        ));
  }
}
