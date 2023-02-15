import 'dart:ffi';

import 'package:audio_player/Components/CustomSlider.dart';
import 'package:audio_player/Components/Players/Presets.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Fav extends StatefulWidget {
  const Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EqualizerFlutter.init(
        context.read<manager>().player.androidAudioSessionId!);

    WidgetsBinding.instance.addPostFrameCallback((_) => deffun());
  }

  deffun() async {
    if (context.read<manager>().isEqEnabled) {
      context.read<manager>().setEqEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Custom Equalizer",
          style: TextStyle(color: globalThemes.colors2['textColor2']),
        ),
        actions: [
          Consumer<manager>(
            builder: (context, value, child) {
              return Switch(
                value: value.isEqEnabled,
                onChanged: (data) {
                  value.isEqEnabled
                      ? value.setEqEnabled(false)
                      : value.setEqEnabled(true);
                },
                inactiveTrackColor: Colors.grey.shade600,
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: EqualizerFlutter.getBandLevelRange(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Customeq(snapshot.data![0].toDouble(),
                        snapshot.data![1].toDouble());
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Consumer<manager>(
                      builder: (context, value, child) {
                        return value.isEqEnabled
                            ? SleekCircularSlider(
                                min: 0,
                                max: 1000,
                                initialValue: value.bassval,
                                onChangeEnd: (val) {
                                  value.setbassval(val);
                                },
                              )
                            : SleekCircularSlider(
                                min: 0,
                                max: 1000,
                                initialValue: value.bassval,
                                appearance: CircularSliderAppearance(
                                    customColors: CustomSliderColors(
                                  dotColor: Colors.grey.shade500,
                                  dynamicGradient: false,
                                  progressBarColor: Colors.grey.shade500,
                                  trackColor: Colors.grey.shade500,
                                )),
                              );
                      },
                    ),
                    Text(
                      "Bass",
                      style:
                          TextStyle(color: globalThemes.colors2['textColor2']),
                    )
                  ],
                ),
                Container(
                  child: TextButton(
                      onPressed: () async {
                        if (context.read<manager>().isEqEnabled) {
                          var res = await Get.bottomSheet(
                            Presets(),
                            enableDrag: true,
                            isScrollControlled: true,
                          );

                          if (res) {
                            setState(() {});
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enable Equalizer first");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: globalThemes.colors2['bgColor'],
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(-1, -1),
                                  blurRadius: 1,
                                  color:
                                      globalThemes.colors2['boxShadowWhite']!),
                              BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  color:
                                      globalThemes.colors2['boxShadowDark']!),
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(10),
                        child: Consumer<manager>(
                          builder: (context, value, child) {
                            return Text(
                              "${value.custom ? "Custom" : value.CurrentPresets}",
                              style: TextStyle(
                                  color: globalThemes.colors2['textColor2']),
                            );
                          },
                        ),
                      )),
                )
              ],
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}

Widget Customeq(min, max) {
  int bandId = 0;
  return FutureBuilder<List<int>>(
    future: EqualizerFlutter.getCenterBandFreqs(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data!
                  .map(
                      (freq) => CustomSlider(context, bandId++, freq, min, max))
                  // .map((freq) => Container())
                  .toList(),
            )
          ],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

// class Customeq extends StatefulWidget {
//   Customeq({super.key, required this.bandLevelRange});

//   List<int> bandLevelRange;
//   @override
//   State<Customeq> createState() => _CustomeqState();
// }

// class _CustomeqState extends State<Customeq> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(milliseconds: 500));
//     WidgetsBinding.instance.addPostFrameCallback((_) => applyChnages());
//   }

//   applyChnages() {
//     context.read<manager>().bandLevelRange = widget.bandLevelRange;
//     context.read<manager>().setMinMaxEq();
//   }

//   int bandId = 0;

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

// class CustomSlider extends StatefulWidget {
//   CustomSlider({
//     super.key,
//     required this.bandId,
//     required this.frequesncies
//   });

//   int bandId;
//   List<int> frequesncies;

//   @override
//   State<CustomSlider> createState() => _CustomSliderState();
// }

// class _CustomSliderState extends State<CustomSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
