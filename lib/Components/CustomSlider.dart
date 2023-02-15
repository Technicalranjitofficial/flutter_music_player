import 'dart:ui';

import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

GlobalThemes globalThemes = GlobalThemes();

Widget CustomSlider(context, int bandId, int freq, min, max) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                    color: globalThemes.colors2['bgColor'],
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, -2),
                        color: globalThemes.colors2['boxShadowWhite']!,
                      ),
                      BoxShadow(
                        offset: Offset(2, 2),
                        color: globalThemes.colors2['boxShadowDark']!,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: FutureBuilder<int>(
                  future: EqualizerFlutter.getBandLevel(bandId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      context
                          .read<manager>()
                          .setBandRange(bandId, snapshot.data!);
                      // print("BandInfo:bandId-${bandId}: ${snapshot.data}");
                      return Consumer<manager>(
                        builder: (context, value, child) {
                          return FlutterSlider(
                            trackBar: FlutterSliderTrackBar(
                              inactiveTrackBar: BoxDecoration(
                                  color: globalThemes.colors2['SeekBarColor']),
                              centralWidget: Container(
                                color: Colors.grey.shade800,
                                child: Icon(
                                  Icons.drag_handle,
                                  color: value.isEqEnabled
                                      ? Colors.cyan.shade700
                                      : Colors.grey.shade600,
                                ),
                              ),
                              activeDisabledTrackBarColor:
                                  globalThemes.colors2['bgColor']!,
                              inactiveDisabledTrackBarColor:
                                  globalThemes.colors2['bgColor']!,
                              activeTrackBar: BoxDecoration(
                                  color: value.bands[bandId].toDouble() >
                                          max / 2 - 3
                                      ? Colors.pink.shade600
                                      : Colors.cyan),
                            ),
                            axis: Axis.vertical,
                            jump: true,
                            visibleTouchArea: true,
                            // lockHandlers: true,
                            disabled: !value.isEqEnabled,

                            handler: FlutterSliderHandler(
                                child: Stack(
                              children: [
                                Container(
                                  // color: Colors.cyan,

                                  decoration: BoxDecoration(
                                      color: value.isEqEnabled
                                          ? Colors.cyan
                                          : Colors.grey.shade700,
                                      shape: BoxShape.rectangle,
                                      gradient: value.isEqEnabled
                                          ? globalThemes.LinearGradient1
                                          : globalThemes.LinearGradient2),

                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(20))),
                                  // child: Icon(
                                  //   Icons.drag_indicator,
                                  //   color: value.isEqEnabled
                                  //       ? Colors.cyan
                                  //       : Colors.grey.shade600,
                                  // ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.black45,
                                  child: Icon(
                                    Icons.drag_indicator,
                                    size: 25,
                                    color: value.isEqEnabled
                                        ? Colors.cyan
                                        : Colors.grey.shade600,
                                  ),
                                )
                              ],
                            )),
                            values: [value.bands[bandId].toDouble()],
                            rtl: true,
                            // visibleTouchArea: true,
                            max: max,
                            min: min,

                            // onDragging:
                            //     (handlerIndex, lowerValue, upperValue) async {

                            // },
                            onDragCompleted:
                                (handlerIndex, lowerValue, upperValue) {
                              value.changeFreq(bandId, lowerValue.toInt());
                            },
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "${(freq / 1000).toStringAsFixed(0)}HZ",
              style: TextStyle(
                  fontSize: 12, color: globalThemes.colors2['textColor2']),
            ),
          )
        ],
      ),
    ),
  );
}
