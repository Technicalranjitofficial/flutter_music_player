import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalThemes globalThemes = GlobalThemes();
Widget InfoDialog(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height / 2,
    width: 200,
    decoration: BoxDecoration(
      color: globalThemes.colors2['bgColor'],
      borderRadius: BorderRadius.circular(20),
    ),
    // color: Colors.grey.shade600,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text(
                      "Details",
                      style: TextStyle(
                          fontFamily: "Oswald-Regular",
                          fontSize: 18,
                          color: globalThemes.colors2['textColor2']),
                    ),
                  ),
                  col(
                      "Song:",
                      context
                          .read<manager>()
                          .songs[context.read<manager>().currentIndex]
                          .displayName),
                  col(
                      "Artist:",
                      context
                          .read<manager>()
                          .songs[context.read<manager>().currentIndex]
                          .artist
                          .toString()
                          .replaceAll('<', '')
                          .replaceAll('>', '')),
                  col(
                      "Album:",
                      context
                          .read<manager>()
                          .songs[context.read<manager>().currentIndex]
                          .album),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    child: Column(
                      children: [
                        col2(context, "Duration:",
                            "${context.read<manager>().Tmin < 10 ? "0${context.read<manager>().Tmin}" : context.read<manager>().Tmin}:${context.read<manager>().Tsec < 10 ? "0${context.read<manager>().Tsec}" : context.read<manager>().Tsec}"),
                        col2(context, "Size:        ",
                            "${(int.parse(context.read<manager>().songs[context.read<manager>().currentIndex].fileSize) / 1000000).toStringAsFixed(2)} MB"),
                        col2(context, "Location:",
                            "${context.read<manager>().songs[context.read<manager>().currentIndex].filePath}"),
                        col2(context, "ID:          ",
                            "${context.read<manager>().songs[context.read<manager>().currentIndex].id}"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget col(title, subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title}",
          style: TextStyle(
              fontFamily: "Oswald-Regular",
              color: globalThemes.colors2['textColor2']),
        ),
        SizedBox(
          height: 5,
        ),
        Text("${subtitle}",
            style: TextStyle(
              fontFamily: "Oswald-Regular",
              color: Colors.grey.shade400,
            )),
      ],
    ),
  );
}

Widget col2(context, title, subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            "${title}",
            style: TextStyle(
                color: globalThemes.colors2['textColor2'],
                fontFamily: "Oswald-Regular"),
          )),
          SizedBox(
            width: 50,
          ),
          Container(
            child: Text(
              "${subtitle}",
              style: TextStyle(
                overflow: TextOverflow.clip,
                fontFamily: "Oswald-Regular",
                color: Colors.grey.shade400,
              ),
            ),
            width: MediaQuery.of(context).size.width - 100,
          ),
        ],
      ),
    ),
  );
}
