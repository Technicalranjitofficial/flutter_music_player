import 'package:audio_player/Components/Modal/FetchModal.dart';
import 'package:audio_player/Pages/ArtistPage.dart';
import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/StateManager/GetXStorage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FetcArtist extends StatefulWidget {
  FetcArtist({super.key});

  // bool isPlaying;
  // AudioPlayer player;
  // int CurrentIndex;
  // List<SongInfo> currentSongList;

  // bool isplay;

  @override
  State<FetcArtist> createState() => _FetcArtistState();
}

class _FetcArtistState extends State<FetcArtist> {
  late List<ArtistInfo> artistModel = [];
  bool isLoaded = false;
  late GlobalThemes globalThemes;
  late FlutterAudioQuery audioQuery;

  late FetchModal fetchModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalThemes = GlobalThemes();
    // audioQuery = FlutterAudioQuery();
    // fetchModal = FetchModal();
    getArtist();
  }

  void getArtist() async {
    artistModel = context.read<manager>().ArtistList;

    setState(() {
      artistModel = artistModel;
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
                        itemCount: artistModel.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("${artistModel.length} Artists",
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
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
                                    builder: (context) => ArtistPage(
                                      artistId: artistModel[index - 1].id,
                                      PlayListid: index - 1,
                                    ),
                                  ));
                            },
                            child: ListTile(
                              title: Text(
                                "${artistModel[index - 1].name}",
                                style: TextStyle(
                                    color: globalThemes.colors2['textColor2'],
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Oswald-Regular",
                                    wordSpacing: 1,
                                    letterSpacing: 1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // widget.isplay
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
