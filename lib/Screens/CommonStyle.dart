import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CommonStyle extends StatefulWidget {
  CommonStyle({super.key, required this.songs});

  late SongInfo songs;

  @override
  State<CommonStyle> createState() => _CommonStyleState();
}

class _CommonStyleState extends State<CommonStyle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.black,
      textColor: Colors.white,
      title: Text(
        "",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
        maxLines: 1,
      ),
      subtitle: Text(
        "hello${widget.songs.artist?.replaceAll('>', '').replaceFirst('<', '')}-${widget.songs.album}",
        style: TextStyle(fontSize: 11, color: Colors.white),
        maxLines: 1,
      ),
    );

    // Text("hello"),
  }
}
