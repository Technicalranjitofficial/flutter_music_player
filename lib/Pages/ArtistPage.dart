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

class ArtistPage extends StatefulWidget {
  ArtistPage({super.key, required this.artistId, required this.PlayListid});
  String artistId;
  int PlayListid;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late FlutterAudioQuery audioQuery;
  List<SongInfo> songs = [];

  late GlobalThemes globalThemes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalThemes = GlobalThemes();
    audioQuery = FlutterAudioQuery();
    getArtist();
  }

  late bool isPlaying;

  getArtist() async {
    songs = await audioQuery.getSongsFromArtist(artistId: widget.artistId);
    setState(() {
      songs = songs;
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
            textWidthBasis: TextWidthBasis.longestLine,
            "ARTIST",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 5,
              fontFamily: "BebasNeue-Regular",
              color: globalThemes.colors2['textColor2'],
              shadows: [
                // Shadow(
                //     blurRadius: 50,
                //     color:globalThemes.colors2 ,
                //     offset: Offset(0, 30))
              ],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: globalThemes.colors2['bgColor'],
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
                              color: globalThemes.colors2['textColor2'],
                              fontFamily: "Oswald-Regular"),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                      onTap: () {
                        context
                            .read<manager>()
                            .setSongs(songs, index - 1, widget.PlayListid);
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
