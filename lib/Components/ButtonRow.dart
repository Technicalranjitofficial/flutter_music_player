import 'package:audio_player/Components/InfoDialog.dart';
import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:audio_player/Components/moreDialog.dart';
import 'package:audio_player/Screens/SongListPage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

Widget ButtonRow(
    context, bgColor, whiteShadow, darkShadow, iconColor, textColor2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Consumer<manager>(
      //   builder: (context, value, child) {
      //     return IconButton(
      //       splashColor: Colors.cyan,
      //       splashRadius: 25,
      //       icon: Icon(
      //         value.isSuffleOn
      //             ? Icons.shuffle
      //             : value.isLoopAll
      //                 ? Icons.loop
      //                 : Icons.repeat_one,
      //         size: 25,
      //       ),
      //       onPressed: () {
      //         value.clickToSuffle();
      //         Get.snackbar(
      //             "Smart Music Player",
      //             "${value.isLoopAll ? "Loop Mode" : value.isLoopOne ? "Loop Current" : "Suffle Mode"}",
      //             snackPosition: SnackPosition.BOTTOM,
      //             backgroundGradient: LinearGradient(
      //                 colors: [Colors.cyan, Colors.purple, Colors.deepPurple]),
      //             borderRadius: 15,
      //             dismissDirection: DismissDirection.horizontal,
      //             isDismissible: true,
      //             duration: Duration(seconds: 1),
      //             overlayColor: Colors.black,
      //             animationDuration: Duration(milliseconds: 500),
      //             boxShadows: [
      //               BoxShadow(
      //                   blurRadius: 20,
      //                   color: Colors.black,
      //                   spreadRadius: 20,
      //                   offset: Offset(10, 1))
      //             ]);
      //       },
      //       color: Colors.white,
      //     );
      //   },
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(
                offset: Offset(-1, -1),
                color: whiteShadow,
                // spreadRadius: 0.5,
                blurRadius: 5),
            BoxShadow(
                offset: Offset(2, 2),
                color: darkShadow,
                blurRadius: 5,
                spreadRadius: 2),
          ],
        ),
        child: IconButton(
            splashColor: Colors.cyan,
            splashRadius: 25,
            iconSize: 25,
            icon: Icon(
              Icons.info,
              color: iconColor,
            ),
            onPressed: () {
              Get.bottomSheet(InfoDialog(context),
                  enableDrag: true,
                  isScrollControlled: true,
                  isDismissible: true,
                  ignoreSafeArea: true);
            }),
      ),
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(
                offset: Offset(-1, -1),
                color: whiteShadow,
                // spreadRadius: 0.5,
                blurRadius: 5),
            BoxShadow(
                offset: Offset(2, 2),
                color: darkShadow,
                blurRadius: 5,
                spreadRadius: 2),
          ],
        ),
        child: Consumer<manager>(builder: (context, value, child) {
          return IconButton(
            splashColor: Colors.cyan,
            splashRadius: 25,
            iconSize: 25,
            icon: Icon(
              Icons.favorite,
              color: value.checkIfExistFav(
                      value.songs[value.currentIndex].id.toString())
                  ? Colors.red
                  : iconColor,
            ),
            onPressed: () async {
              try {
                if (context
                    .read<manager>()
                    .checkIfExistFav(value.songs[value.currentIndex].id)) {
                  var res = await value.db
                      .deleteFavourite(value.songs[value.currentIndex].id);

                  if (res) {
                    Fluttertoast.showToast(msg: "Removed");
                    value.getFavourite();
                  }
                } else {
                  var res = await value.db.insertFavourite(FavouriteModal(
                      songId: value.songs[value.currentIndex].id));

                  if (res) {
                    Fluttertoast.showToast(msg: "Favourite Added");
                    value.getFavourite();
                  } else {
                    Fluttertoast.showToast(msg: "Already Exist");
                  }
                }
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
          );
        }),
      ),
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(
                offset: Offset(-1, -1),
                color: whiteShadow,
                // spreadRadius: 0.5,
                blurRadius: 5),
            BoxShadow(
                offset: Offset(2, 2),
                color: darkShadow,
                blurRadius: 5,
                spreadRadius: 2),
          ],
        ),
        child: IconButton(
          splashColor: Colors.cyan,
          splashRadius: 25,
          iconSize: 25,
          icon: Icon(
            Icons.list_alt,
            color: iconColor,
          ),
          onPressed: () {
            Get.to(() => SOngListPage(),
                preventDuplicates: false,
                curve: Curves.easeInQuint,
                fullscreenDialog: true,
                transition: Transition.circularReveal,
                opaque: false,
                duration: Duration(milliseconds: 1000));
          },
        ),
      )
    ],
  );
}
