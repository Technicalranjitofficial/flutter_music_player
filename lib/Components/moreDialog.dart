import 'package:audio_player/Components/InfoDialog.dart';
import 'package:audio_player/Components/fav.dart';
import 'package:audio_player/Screens/ChangePlayer.dart';
import 'package:audio_player/Screens/SongListPage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DialogMore extends StatelessWidget {
  DialogMore({super.key});

  GlobalThemes globalThemes = GlobalThemes();
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      height: 250,
      child: Column(
        children: [
          ListTile(
            title: Container(
                child: TextButton(
                    onPressed: () async {
                      var x = await Get.to(() => ChangePlayer(),
                          preventDuplicates: false,
                          curve: Curves.linear,
                          fullscreenDialog: true,
                          transition: Transition.circularReveal,
                          opaque: false,
                          duration: Duration(milliseconds: 1000));

                      if (x) {
                        Get.back();
                      }
                    },
                    child: Text(
                      "Choose Theme",
                      style:
                          TextStyle(color: globalThemes.colors2['textColor2']),
                    ))),
          ),
          ListTile(
            title: Container(
                child: TextButton(
                    onPressed: () async {
                      Get.to(() => SOngListPage(),
                          preventDuplicates: false,
                          curve: Curves.easeInQuint,
                          fullscreenDialog: true,
                          transition: Transition.circularReveal,
                          opaque: false,
                          duration: Duration(milliseconds: 1000));
                    },
                    child: Text(
                      "Current Playlist",
                      style:
                          TextStyle(color: globalThemes.colors2['textColor2']),
                    ))),
          ),
          ListTile(
            title: Container(
                child: TextButton(
                    onPressed: () async {
                      Get.to(() => Fav(),
                          preventDuplicates: false,
                          curve: Curves.easeInQuint,
                          fullscreenDialog: true,
                          transition: Transition.circularReveal,
                          opaque: false,
                          duration: Duration(milliseconds: 1000));
                    },
                    child: Text(
                      "Equalizer",
                      style:
                          TextStyle(color: globalThemes.colors2['textColor2']),
                    ))),
          ),
          ListTile(
            title: Container(
                child: TextButton(
                    onPressed: () async {
                      Get.bottomSheet(InfoDialog(context),
                          enableDrag: true,
                          isScrollControlled: true,
                          isDismissible: true,
                          ignoreSafeArea: true);
                    },
                    child: Text(
                      "Info",
                      style:
                          TextStyle(color: globalThemes.colors2['textColor2']),
                    ))),
          ),
        ],
      ),
    );
  }
}
