import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  //   required this.songs,
  // required this.player,
  // required this.audioQuery,
  // required this.SongsList,
  // required this.index

  // final SongModel songs;
  // final AudioPlayer player;
  // final OnAudioQuery audioQuery;
  // final List<SongModel> SongsList;
  // final int index;
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isPlaying = true;
  late int index2;
  late SongModel songs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "${songs.displayName}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            CircleAvatar(
              radius: 130,
              backgroundImage: AssetImage("assets/images/music.jpg"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            LinearProgressIndicator(
              color: Colors.green,
              value: songs.duration! / 1000,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.skip_previous,
                      size: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: isPlaying
                        ? Icon(
                            Icons.pause,
                            size: 40,
                          )
                        : Icon(
                            Icons.play_arrow,
                            size: 40,
                          ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.skip_next,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
