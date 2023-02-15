import 'dart:io';

import 'package:audio_player/Components/Modal/FetchModal.dart';
import 'package:audio_player/Pages/ArtistPage.dart';
import 'package:audio_player/Screens/AlbumPage.dart';
import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FetchAlbum extends StatefulWidget {
  FetchAlbum({super.key, required this.ids});

  // bool isPlaying;
  // AudioPlayer player;
  // int CurrentIndex;
  // List<SongInfo> currentSongList;

  List<String> ids;

  @override
  State<FetchAlbum> createState() => _FetcArtistState();
}

class _FetcArtistState extends State<FetchAlbum> {
  late final FlutterAudioQuery audioQuery;

  late FetchModal fetchModal;
  bool isLoaded = false;

  List<AlbumInfo> Album = [];
  List<AlbumInfo> Album2 = [];
  late GlobalThemes globalThemes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalThemes = GlobalThemes();
    fetchModal = FetchModal();
    getArtist();
  }

  void getArtist() async {
    await context.read<manager>().ListAlbum(widget.ids);
    Album = context.read<manager>().AlbumList;
    setState(() {
      Album = Album;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoaded
            ? Stack(
                children: [
                  Container(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                        return;
                      },
                      child: ListView.builder(
                        itemCount: Album.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("${Album.length} Album",
                                    style: TextStyle(
                                        color:
                                            globalThemes.colors2['textColor2'],
                                        fontFamily: "Oswald-Regular",
                                        fontWeight: FontWeight.w400)),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () async {
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlbumPage(
                                      AlbumId: Album[index - 1].id,
                                      AlbumName: Album[index - 1].title,
                                      PlayListId: index - 1,
                                    ),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ListTile(
                                title: Text(
                                  "${Album[index - 1].title}",
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: globalThemes.colors2['textColor2'],
                                      wordSpacing: 1,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: "Oswald-Regular",
                                      fontWeight: FontWeight.lerp(
                                          FontWeight.bold,
                                          FontWeight.w300,
                                          20)),
                                ),
                                leading: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: globalThemes.colors2['bgColor'],
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(-1, -1),
                                            color: globalThemes
                                                .colors['boxShadowWhite']!,
                                            blurRadius: 1),
                                        BoxShadow(
                                            offset: Offset(2, 2),
                                            color: globalThemes
                                                .colors['boxShadowDark']!,
                                            blurRadius: 2),
                                      ],
                                      shape: BoxShape.rectangle),
                                  child: Stack(children: [
                                    Container(
                                      child: QueryArtworkWidget(
                                          keepOldArtwork: true,
                                          nullArtworkWidget: Center(
                                              child: Stack(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                    "assets/images/music4.jpg",
                                                    fit: BoxFit.contain),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade400,
                                                  backgroundBlendMode:
                                                      globalThemes.PlayerTheme2,
                                                ),
                                              )
                                            ],
                                          )),
                                          artworkWidth: 70,
                                          artworkHeight: 70,
                                          artworkBorder:
                                              BorderRadius.horizontal(
                                                  left: Radius.zero,
                                                  right: Radius.zero),
                                          artworkFit: BoxFit.cover,
                                          id: int.parse(Album[index - 1].id),
                                          type: ArtworkType.ALBUM),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: globalThemes
                                            .colors2['playerThemesColor2'],
                                        backgroundBlendMode:
                                            globalThemes.PlayerTheme2,
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // widget.isplay || context.read<manager>().playerAvailable
                  //     ? BottomPlayContainer()
                  //     : Container(),

                  Consumer<manager>(
                    builder: (context, value, child) {
                      return value.playerAvailable
                          ? BottomPlayContainer()
                          : Container();
                    },
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ));
  }
}
