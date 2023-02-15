import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PlayerProgress extends StatelessWidget {
  PlayerProgress({super.key});

  GlobalThemes globalThemes = GlobalThemes();

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
      appearance: CircularSliderAppearance(
          customColors: CustomSliderColors(
              progressBarColor: globalThemes.colors2['bgCOlor'],
              dotColor: Colors.pink,
              trackColor: Colors.grey.shade500),
          size: 330,
          angleRange: 360,
          startAngle: 180,
          animationEnabled: false,
          customWidths: CustomSliderWidths(
            trackWidth: 10,
            handlerSize: 20,
            progressBarWidth: 20,
          )),
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
