import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/Screens/CommonStyle.dart';
import 'package:audio_player/Screens/PlayList.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatefulWidget {
  AlbumPage(
      {super.key,
      required this.AlbumId,
      required this.AlbumName,
      required this.PlayListId});
  String AlbumId;
  String AlbumName;
  int PlayListId;

  @override
  State<AlbumPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<AlbumPage> {
  late FlutterAudioQuery audioQuery;
  List<SongInfo> songs = [];
  late GlobalThemes globalThemes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioQuery = FlutterAudioQuery();
    globalThemes = GlobalThemes();
    getArtist();
  }

  late bool isPlaying;

  getArtist() async {
    songs = await audioQuery.getSongsFromAlbum(albumId: widget.AlbumId);
    setState(() {
      songs = songs;
      print(songs);
      print("Hello");
    });
  }

  @override
  Widget build(BuildContext context) {
    isPlaying = context.read<manager>().isPlaying;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(
            // textWidthBasis: TextWidthBasis.longestLine,
            "ALBUM",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 7,
              // decoration: TextDecoration.overline,

              fontFamily: "BebasNeue-Regular",
              color: globalThemes.colors2['textColor2'],
              // shadows: [
              //   Shadow(
              //       blurRadius: 50,
              //       color: Colors.white30,
              //       offset: Offset(0, 30))
              // ],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: globalThemes.colors2['bgColor'],
        bottom: PreferredSize(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                child: ListTile(
                  title: Text(
                    "${widget.AlbumName}",
                    maxLines: 1,
                    style: TextStyle(color: globalThemes.colors2['textColor2']),
                  ),
                  tileColor: globalThemes.colors2['bgColor'],
                  leading: Container(
                    width: 80,
                    height: 90,
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(children: [
                      QueryArtworkWidget(
                          nullArtworkWidget: Container(
                            height: 75,
                            width: 85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  "assets/images/music4.jpg",
                                )),
                          ),
                          artworkHeight: 90,
                          artworkWidth: 80,
                          artworkBorder: BorderRadius.all(Radius.circular(10)),
                          id: int.parse(widget.AlbumId),
                          type: ArtworkType.ALBUM),
                      Container(
                        height: 90,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: globalThemes.colors2['playerThemesColor2'],
                          backgroundBlendMode: globalThemes.PlayerTheme2,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                height: 10,
                indent: 15,
                endIndent: 20,
                color: globalThemes.colors2['divider'],
              )
            ],
          ),
          preferredSize: Size.fromHeight(80),
        ),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: globalThemes.colors2['bgColor'],
        child: Stack(
          children: [
            Container(
              child: ListView.builder(
                itemCount: songs.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.play_circle,
                            color: globalThemes.colors2['IconBtn']),
                        title: Text(
                          "Play All ${songs.length} song",
                          style: TextStyle(
                              color: globalThemes.colors2['textColor2']),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                      onTap: () {
                        // if (widget.PlayListId !=
                        //     context.read<manager>().playListId) {
                        //   context.read<manager>().songs = songs;
                        //   context.read<manager>().songs = songs;
                        // }
                        context
                            .read<manager>()
                            .setSongs(songs, index - 1, widget.PlayListId);
                        setState(() {
                          isPlaying = true;
                        });
                      },
                      child: PlayList(songs[index - 1],
                          globalThemes.colors2['textColor2']));
                },
              ),
            ),
            Provider.of<manager>(context, listen: false).isPlaying
                ? BottomPlayContainer()
                : Container(),
          ],
        ),
      ),

      // body: ElevatedButton(
      //   onPressed: () => showModalBottomSheet(
      //     isScrollControlled: true,
      //     context: context,
      //     builder: (context) => widget.showModal,
      //   ),
      //   child: Text("Click"),
      // ),
    );
  }
}
