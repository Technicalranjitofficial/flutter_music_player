import 'package:audio_player/Components/CustomSlider.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Presets extends StatelessWidget {
  Presets({super.key});

  bool changed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
          color: globalThemes.colors2['bgColor'],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: FutureBuilder<List<String>>(
        future: context.read<manager>().getPresest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    changed = true;
                    context
                        .read<manager>()
                        .setPresets(snapshot.data![index].toString());
                    Get.back(result: changed);
                  },
                  child: ListTile(
                    title: Text("${snapshot.data![index]}"),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
