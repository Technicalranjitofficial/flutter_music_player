import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class PLayListCustom extends StatelessWidget {
  PLayListCustom({super.key, required this.playListId});

  PlayListId playListId;

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
                    child: Image.asset("assets/images/music4.jpg"),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        gradient: globalThemes.LinearGradient1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: globalThemes.colors2['bgColor'],
                        backgroundBlendMode: BlendMode.hue),
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
                    "${playListId.playListId}",
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
