import 'dart:math';
import 'dart:ui';

import 'package:audio_player/Components/Favourite.dart';
import 'package:audio_player/Components/Modal/FetchModal.dart';
import 'package:audio_player/Components/Visualizer.dart';
import 'package:audio_player/Components/fav.dart';
import 'package:audio_player/Components/favoutite2.dart';
import 'package:audio_player/Player2.dart';
import 'package:audio_player/Screens/Album.dart';
import 'package:audio_player/Screens/Artists.dart';
import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/Screens/BottomSheetPlayer.dart';
import 'package:audio_player/Screens/PlayList.dart';
import 'package:audio_player/Screens/PlayList/PlayListDesign.dart';
import 'package:audio_player/Screens/PlayList/SearchList.dart';
import 'package:audio_player/Screens/ShowModal.dart';
import 'package:audio_player/Screens/playerScreen.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:circular_clip_route/circular_clip_route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  OnAudioQuery audioQuery = OnAudioQuery();
  // List<SongModel> songs = [];
  List<SongInfo> songs = [];
  List<SongInfo> songs2 = [];

  final playListId = 1;

  late FetchModal fetchModal;
  bool isPlaying = false;
  late GlobalThemes globalThemes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getFav());
    globalThemes = GlobalThemes();
    tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    // fetchModal = FetchModal();
    getsongs();
  }

  // getPlayList() async {

  //   // Future.delayed(Duration(
  //   //   milliseconds: 500,
  //   // ));
  // }

  getsongs() async {
    // await context.read<manager>().getSongsListMain();
    songs = context.read<manager>().getSongListMain;

    setState(() {
      songs = songs;
      // ids = ids;
      // Artistids = Artistids;
    });
  }

  getFav() {
    context.read<manager>().getFavourite();
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pink, Colors.green, Colors.cyan],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    print("Buld Context HomePage");
    isPlaying = context.read<manager>().isPlaying;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, left: 20),
                    child: Text(
                      "MUSIC",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          // color: globalThemes.colors2['headColor'],
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                ),
                TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: globalThemes.colors2['textColor1'],
                  labelColor: globalThemes.colors2['label'],
                  unselectedLabelColor: globalThemes.colors2['textColor2'],
                  tabs: [
                    tabs("FAVOURITE"),
                    tabs("MUSIC"),
                    tabs("ARTIST"),
                    tabs("ALBUM"),
                    tabs("PLAYLIST"),
                  ],
                )
              ]),
            ),
            preferredSize: Size.fromHeight(80)),
        elevation: 0,
        backgroundColor: globalThemes.colors2['bgColor'],
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: globalThemes.colors2['IconBtn'],
            ),
            onPressed: () {
              Get.to(() => SearchList(),
                  fullscreenDialog: true,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 500),
                  preventDuplicates: true,
                  transition: Transition.upToDown);
            },
          ),
          PopupMenuButton(
            iconSize: 25,
            icon: Icon(
              Icons.more_vert,
              color: globalThemes.colors2['IconBtn'],
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Developer:Ranjit Das"),
                  value: "hello",
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        color: globalThemes.colors2['bgColor'],
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            TabBarView(controller: tabController, children: [
              // Fav(),
              FavouritePage(),
              Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                      return;
                    },
                    child: ListView.builder(
                      itemCount: songs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == songs.length) {
                          return Container(
                            height: 50,
                          );
                        }

                        return InkWell(
                            onTap: () {
                              context
                                  .read<manager>()
                                  .setSongs(songs, index, playListId);
                              // setState(() {
                              //   isPlaying = true;
                              // });
                              // showModalBottomSheet(
                              //     useRootNavigator: true,
                              //     isDismissible: true,
                              //     enableDrag: true,
                              //     isScrollControlled: true,
                              //     context: context,
                              //     builder: (context) => zisualizer());
                            },
                            child: PlayList(songs[index],
                                globalThemes.colors2['textColor']));
                      },
                    ),
                  ),
                  isPlaying || context.read<manager>().playerAvailable
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomPlayContainer(),
                        )
                      : Container()
                ],
              ),

              // Text(
              //   "Music",
              //   style: TextStyle(color: Colors.white),
              // ),
              // Text("FetchArtist"),
              FetcArtist(),
              // Text("Artist"),
              FetchAlbum(
                ids: context.read<manager>().ids,
              ),
              PlayListDesign(),
            ]),
            // context.read<MusicProviderModel>().isPlaying
            //     ? BottomPlayContainer()
            //
            //
            //   : Container(),

            Consumer<manager>(
              builder: (context, value, child) {
                return value.playerAvailable
                    ? BottomPlayContainer()
                    : Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget showSongsInfo() {
    return Container(
      height: 100,
    );
  }

  Widget tabs(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
      child: Text(name),
    );
  }
}
