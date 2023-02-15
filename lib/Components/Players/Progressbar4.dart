import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PlayerProgress4 extends StatefulWidget {
  PlayerProgress4({super.key});

  @override
  State<PlayerProgress4> createState() => _PlayerProgress4State();
}

class _PlayerProgress4State extends State<PlayerProgress4> {
  GlobalThemes globalThemes = GlobalThemes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Buld Context ProgressBar");
    return SleekCircularSlider(
      min: 0,
      max: Provider.of<manager>(context, listen: true).MaxValue,
      initialValue: Provider.of<manager>(context, listen: true).currentPosition,
      onChangeEnd: (value) async {
        context.read<manager>().isPlaying = true;
        await context
            .read<manager>()
            .player
            .seek(Duration(microseconds: value.toInt()));
      },
      onChangeStart: (value) {
        context.read<manager>().isPlaying = false;
      },
      // globalThemes.colors2['SeekBarHandler'],
      appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
            progressBarColor: globalThemes.colors2['bgCOlor'],
            dotColor: Colors.grey.shade600,
            trackColor: Colors.teal.shade900,
            hideShadow: true,
            shadowColor: Colors.cyan.shade600,
            dynamicGradient: true,
          ),
          size: 330,
          angleRange: 360,
          startAngle: 180,
          spinnerDuration: 600,
          spinnerMode: true,
          animationEnabled: false,
          customWidths: CustomSliderWidths(
              trackWidth: 10, handlerSize: 20, progressBarWidth: 10)),
      innerWidget: (percentage) {
        return Text(
          textAlign: TextAlign.center,
          "",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}
