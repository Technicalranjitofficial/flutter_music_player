import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seekbar/seekbar.dart';

Widget seekbar(
    baseColor, seekbarColor, handlerColor, shadowWhite, ShadowBlack) {
  return Container(
      // color: Color.fromARGB(255, 49, 48, 48),

      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(offset: Offset(-1, -1), blurRadius: 1, color: shadowWhite),
          BoxShadow(offset: Offset(2, 2), color: ShadowBlack, blurRadius: 2)
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      alignment: Alignment.center,
      child: Consumer<manager>(
        builder: (context, value, child) {
          // return SeekBar(
          //   // progressWidth: 20,
          //   value: 1,
          //   secondValue: 200,
          //   thumbColor: Color.fromARGB(255, 134, 131, 131),
          //   progressColor: Color.fromARGB(255, 49, 48, 48),
          //   barColor: Color.fromARGB(255, 49, 48, 48),
          //   thumbRadius: 12,
          //   onProgressChanged: (value) async {
          //     await context
          //         .read<manager>()
          //         .player
          //         .seek(Duration(milliseconds: value.toInt()));
          //   },
          // );

          return ProgressBar(
            thumbColor: Colors.cyan.shade700,
            progressBarColor: seekbarColor,
            thumbRadius: 5,
            thumbGlowColor: handlerColor,
            thumbCanPaintOutsideBar: false,
            timeLabelLocation: TimeLabelLocation.none,

            baseBarColor: baseColor, //   thumbRadius: 12,
            // progressWidth: 20,
            progress: Duration(microseconds: value.currentPosition.toInt()),
            total: Duration(microseconds: value.MaxValue.toInt()),
            onDragStart: (details) {
              value.isPlaying = false;
            },
            onSeek: (val) async {
              await value.player
                  .seek(Duration(microseconds: val.inMicroseconds));
            },

            onDragEnd: () {
              value.isPlaying = true;
            },
          );
        },
      ));
}



//  return ProgressBar(
//             // progressWidth: 20,
//             progress: Duration(microseconds: value.currentPosition.toInt()),
//             total: Duration(microseconds: value.MaxValue.toInt()),
//             onDragStart: (details) {
//               value.isPlaying = false;
//             },
//             onSeek: (val) async {
//               await value.player
//                   .seek(Duration(microseconds: val.inMicroseconds));
//             },

//             onDragEnd: () {
//               value.isPlaying = true;
//             },
//           );