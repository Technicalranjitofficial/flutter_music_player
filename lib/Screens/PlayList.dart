import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:on_audio_query/on_audio_query.dart';

GlobalThemes globalThemes = GlobalThemes();
Widget PlayList(SongInfo songs, color) {
  return ListTile(
    tileColor: globalThemes.colors2['bgColor'],
    textColor: globalThemes.colors2['textColor2'],
    leading: Stack(children: [
      Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(-1, -1),
              color: globalThemes.colors['boxShadowWhite']!,
              blurRadius: 1),
          BoxShadow(
              offset: Offset(2, 2),
              color: globalThemes.colors['boxShadowDark']!,
              blurRadius: 2),
        ], color: Colors.white, shape: BoxShape.circle),
        child: QueryArtworkWidget(
            nullArtworkWidget: CircleAvatar(
              radius: 27,
              backgroundImage: AssetImage("assets/images/music4.jpg"),
            ),
            keepOldArtwork: true,
            id: int.parse(songs.id),
            type: ArtworkType.AUDIO),
      ),
      Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: globalThemes.colors2['playerThemesColor2'],
          shape: BoxShape.circle,
          backgroundBlendMode: globalThemes.PlayerTheme2,
        ),
      )
    ]),
    // title: Text("title"),
    title: Text(
      "${songs.displayName}",
      style: TextStyle(
          fontFamily: "BebasNeue-Regular",
          fontSize: 19,
          fontWeight: FontWeight.w200,
          color: color,
          letterSpacing: 1),
      maxLines: 1,
    ),
    subtitle: Text(
      "${songs.artist?.replaceAll('>', '').replaceFirst('<', '')}-${songs.album}",
      style: TextStyle(
          fontSize: 10,
          color: globalThemes.colors2['subTitles'],
          letterSpacing: 2),
      maxLines: 1,
    ),
  );
}
