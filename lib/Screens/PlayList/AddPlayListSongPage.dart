import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddPlayListSongPage extends StatefulWidget {
  AddPlayListSongPage({super.key, required this.PlayListId});
  String PlayListId;

  @override
  State<AddPlayListSongPage> createState() => _AddPlayListSongPageState();
}

class _AddPlayListSongPageState extends State<AddPlayListSongPage> {
  GlobalThemes globalThemes = GlobalThemes();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<manager>().Songadded) {
          Get.back(result: true);
        } else {
          Get.back(result: false);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Song"),
          actions: [
            TextButton(
                onPressed: () {
                  if (context.read<manager>().Songadded) {
                    Get.back(result: true);
                  } else {
                    Get.back(result: false);
                  }
                },
                child: Text("Done"))
          ],
          elevation: 0,
          backgroundColor: globalThemes.colors2['bgColor'],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
            return;
          },
          child: ListView.builder(
            itemCount: context.read<manager>().getSongList.length,
            itemBuilder: (context, index) {
              // return InkWell(onTap: () async {
              //   try {
              //     var result = await context.read<manager>().insertSongPlaylist(
              //         context.read<manager>().getSongList[index].id,
              //         widget.PlayListId);

              //     if (result) {
              //       print("Song Inserted");
              //       Get.back(result: true);
              //     } else {
              //       print("Error");
              //     }
              //   } catch (e) {
              //     print(e.toString());
              //   }
              // },
              // child: ListTile(
              //   title: Text(
              //     "${context.read<manager>().getSongList[index].displayName}",
              //     maxLines: 1,
              //     style: TextStyle(
              //       color: globalThemes.colors2['textColor2'],

              //     ),

              //   ),
              // ),

              return Consumer<manager>(
                builder: (context, value, child) {
                  return ListTile(
                    title: Text(
                      "${value.getSongList[index].displayName}",
                      maxLines: 1,
                      selectionColor:
                          value.isSelected[index] ? Colors.red : Colors.white,
                      style: TextStyle(
                          color: globalThemes.colors2['textColor2'],
                          fontFamily: "Oswald-Regular"),
                    ),
                    subtitle: Text(
                      "${value.getSongList[index].artist.toString().replaceAll('<', '').replaceAll('>', '')}",
                      style: TextStyle(
                          fontFamily: "Oswald-Regular",
                          letterSpacing: 1,
                          color: Colors.grey.shade600),
                    ),
                    tileColor: value.isSelected[index]
                        ? Colors.black
                        : globalThemes.colors2['bgColor'],
                    onLongPress: () async {
                      value.changeListTile(index);
                      await context.read<manager>().insertSongPlaylist(
                          context.read<manager>().getSongList[index].id,
                          widget.PlayListId);
                      Fluttertoast.showToast(
                        msg: "Song Added",
                      );
                    },
                    onTap: () async {
                      value.changeListTile(index);
                      await context.read<manager>().insertSongPlaylist(
                          context.read<manager>().getSongList[index].id,
                          widget.PlayListId);
                      Fluttertoast.showToast(msg: "Song Added");
                    },
                    trailing: InkWell(
                      onTap: () async {
                        value.changeListTile(index);
                        await context.read<manager>().insertSongPlaylist(
                            context.read<manager>().getSongList[index].id,
                            widget.PlayListId);
                        Fluttertoast.showToast(
                            msg: "Song Added", toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: value.isSelected[index]
                                ? Colors.grey.shade600
                                : Colors.red.shade600,
                          ),
                          child: Icon(
                            value.isSelected[index] ? Icons.check : Icons.add,
                            color: Colors.grey.shade300,
                            size: 18,
                          )),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
