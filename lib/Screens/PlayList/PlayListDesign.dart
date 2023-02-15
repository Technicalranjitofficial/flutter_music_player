import 'package:audio_player/Components/InfoDialog.dart';
import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:audio_player/DBHandling/DB.dart';
import 'package:audio_player/Screens/PlayList/AddPlayListSongPage.dart';
import 'package:audio_player/Screens/PlayList/PlayListAddCustom.dart';
import 'package:audio_player/Screens/PlayList/PlayListCustom.dart';
import 'package:audio_player/Screens/SongListOfPlayList.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class PlayListDesign extends StatelessWidget {
  PlayListDesign({super.key});

  TextEditingController textEditingController = TextEditingController();
  final DB db = DB();

  GlobalThemes globalThemes = GlobalThemes();

  TextEditingController playlistName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<manager>(
            builder: (context, value, child) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 10),
                itemCount: value.currentPlayList.length + 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                        onTap: () {
                          print("clicked");

                          Get.defaultDialog(
                              title: "Create Playlist",
                              titleStyle: TextStyle(
                                  color: globalThemes.colors2['textColor2']),
                              content: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: TextField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                          hintText: "Enter name",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: globalThemes
                                                      .colors2['textColor1']!)),
                                          labelText: "Create",
                                          labelStyle: TextStyle(
                                              color: globalThemes
                                                  .colors2['textColor2']),
                                          prefixIcon: Icon(
                                            Icons.playlist_add,
                                            color: globalThemes
                                                .colors2['textColor2'],
                                          )),
                                      style: TextStyle(
                                          color: globalThemes
                                              .colors2['textColor2']),
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Get.back(result: false);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: globalThemes
                                              .colors2['textColor2']),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      if (textEditingController
                                          .text.isNotEmpty) {
                                        try {
                                          var result = await value.insertData(
                                              textEditingController.text);

                                          if (result) {
                                            Navigator.pop(context);
                                            print("Created Sucessfully");
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "PlayList Already Exist");
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.toString());
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "PlayList can't be blank");
                                      }
                                    },
                                    child: Text(
                                      "Create",
                                      style: TextStyle(
                                          color: Colors.green.shade600),
                                    ))
                              ]);
                        },
                        child: CustomAdd(context, "Create"));
                  }
                  return InkWell(
                      onLongPress: () async {
                        await Get.defaultDialog(
                            title: "Menu",
                            titleStyle: TextStyle(
                                color: globalThemes.colors2['textColor2']),
                            content: Column(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      var res = await Get.defaultDialog(
                                          title: "Confirm",
                                          titleStyle: TextStyle(
                                              color: globalThemes
                                                  .colors2['textColor2']),
                                          content: Text(
                                            "Are you sure want to delete?",
                                            style: TextStyle(
                                              color: globalThemes
                                                  .colors2['textColor2'],
                                            ),
                                          ),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.back(result: false);
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red.shade300,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  Get.back(result: true);
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.green.shade400,
                                                )),
                                          ]);

                                      if (res) {
                                        var res = await value.deletePlayList(
                                            value.currentPlayList[index - 1]
                                                .playListId);
                                        if (res) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "PlayList Deleted Sucessfully");
                                          Get.back(result: true);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Error Occured");
                                          Get.back(result: false);
                                        }
                                      } else {
                                        Get.back(result: false);
                                      }
                                    },
                                    child: Text(
                                      "Delete",
                                      style:
                                          TextStyle(color: Colors.red.shade300),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      var res = await Get.defaultDialog(
                                          title: "Edit Playlist",
                                          titleStyle: TextStyle(
                                              color: globalThemes
                                                  .colors2['textColor2']),
                                          content: TextField(
                                            controller: playlistName
                                              ..text =
                                                  "${value.currentPlayList[index - 1].playListId.toString()}",
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: globalThemes
                                                                    .colors2[
                                                                'textColor1']!)),
                                                labelText: "Update",
                                                labelStyle: TextStyle(
                                                    color: globalThemes
                                                        .colors2['textColor2']),
                                                prefixIcon: Icon(
                                                  Icons.playlist_add,
                                                  color: globalThemes
                                                      .colors2['textColor2'],
                                                )),
                                            style: TextStyle(
                                                color: globalThemes
                                                    .colors2['textColor2']),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                            TextButton(
                                                onPressed: () async {
                                                  if (playlistName.text.length >
                                                      0) {
                                                    PlayListId newModel =
                                                        PlayListId(
                                                            id: value
                                                                .currentPlayList[
                                                                    index - 1]
                                                                .id,
                                                            playListId:
                                                                playlistName
                                                                    .text);

                                                    var res =
                                                        await db.renamePlayList(
                                                            newModel,
                                                            value
                                                                .currentPlayList[
                                                                    index - 1]
                                                                .id!
                                                                .toInt());

                                                    if (res) {
                                                      Fluttertoast.showToast(
                                                          msg: "Updated");
                                                      value.getPlayList();
                                                      Get.back(result: true);
                                                    } else {
                                                      Get.back(result: false);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Playlist can't be Empty");
                                                  }
                                                },
                                                child: Text("Done")),
                                          ]);

                                      Get.back();
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.green.shade600),
                                    )),
                              ],
                            ));
                      },
                      onTap: () {
                        Get.to(
                            () => SongListOfPlayList(
                                PlayListId: value
                                    .currentPlayList[index - 1].playListId),
                            fullscreenDialog: true,
                            curve: Curves.easeInQuint,
                            duration: Duration(milliseconds: 700),
                            transition: Transition.circularReveal,
                            preventDuplicates: true);
                      },
                      child: PLayListCustom(
                        playListId: value.currentPlayList[index - 1],
                      ));
                },
              );
            },
          )),
    );
  }
}
