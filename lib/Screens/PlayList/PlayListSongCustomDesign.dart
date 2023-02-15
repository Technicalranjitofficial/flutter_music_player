import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListSongCustomDesign extends StatelessWidget {
  PlayListSongCustomDesign({super.key, required this.songInfo});

  SongInfo songInfo;

  GlobalThemes globalThemes = GlobalThemes();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: globalThemes.colors2['bgColor'],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(-2, -2),
                    color: globalThemes.colors2['boxShadowWhite']!,
                    blurRadius: 2),
                BoxShadow(
                    offset: Offset(2, 2),
                    color: globalThemes.colors2['boxShadowDark']!,
                    blurRadius: 2)
              ]),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.all(Radius.circular(10)),
                        artworkWidth: MediaQuery.of(context).size.width / 2,
                        keepOldArtwork: true,
                        artworkHeight: 150,
                        size: 1000,
                        quality: 100,
                        id: int.parse(songInfo.id),
                        type: ArtworkType.AUDIO),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: globalThemes.colors2['playerThemesColor2'],
                        backgroundBlendMode: BlendMode.multiply),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    "${songInfo.displayName}..",
                    maxLines: 1,
                    style: TextStyle(
                      color: globalThemes.colors2['textColor2'],
                      fontSize: 15,
                      fontFamily: "Oswald-Regular",
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
