import 'package:audio_player/StateManager/GetXStorage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChangePlayer extends StatelessWidget {
  ChangePlayer({super.key});

  GlobalThemes globalThemes = GlobalThemes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Player",
          style: TextStyle(color: globalThemes.colors2['textColor2']),
        ),
        elevation: 0,
        backgroundColor: globalThemes.colors2['bgColor'],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(children: [
                          InkWell(
                            onTap: () {
                              context.read<manager>().PlayerChange(0);
                              Get.back(result: true);
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 - 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset("assets/images/Player1.jpg"),
                            ),
                          ),
                          Consumer<manager>(
                            builder: (context, value, child) {
                              return value.CurrentPlayerThemeId == 0
                                  ? CheckBox(context)
                                  : Container();
                            },
                          )
                        ]),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Stack(children: [
                          InkWell(
                            onTap: () {
                              context.read<manager>().PlayerChange(1);
                              Get.back(result: true);
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 - 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset("assets/images/Player2.jpg"),
                            ),
                          ),
                          Consumer<manager>(
                            builder: (context, value, child) {
                              return value.CurrentPlayerThemeId == 1
                                  ? CheckBox(context)
                                  : Container();
                            },
                          )
                        ]),
                      ),
                    ],
                  ),
                ),

                //row 2

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(children: [
                          InkWell(
                            onTap: () {
                              context.read<manager>().PlayerChange(2);
                              Get.back(result: true);
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 - 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset("assets/images/Player3.jpg"),
                            ),
                          ),
                          Consumer<manager>(
                            builder: (context, value, child) {
                              return value.CurrentPlayerThemeId == 2
                                  ? CheckBox(context)
                                  : Container();
                            },
                          )
                          // : musicData.read("player") == 0
                          //     ? Container(
                          //         height:
                          //             MediaQuery.of(context).size.height / 2 -
                          //                 30,
                          //         width: MediaQuery.of(context).size.width,
                          //         decoration: BoxDecoration(
                          //             color: Colors.grey,
                          //             backgroundBlendMode: BlendMode.multiply,
                          //             borderRadius:
                          //                 BorderRadius.circular(10)),
                          //         child: Center(
                          //           child: Container(
                          //             child: Icon(Icons.check),
                          //             width: 50,
                          //             height: 50,
                          //             decoration: BoxDecoration(
                          //                 color: Colors.black,
                          //                 borderRadius:
                          //                     BorderRadius.circular(200)),
                          //           ),
                          //         ),
                          //       )
                          //     : Container()
                        ]),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Stack(children: [
                          InkWell(
                            onTap: () {
                              // context.read<manager>().PlayerChange(2);
                              // Get.back(result: true);
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 - 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                color: globalThemes.colors2['bgColor'],
                              ),
                            ),
                          ),
                          Consumer<manager>(
                            builder: (context, value, child) {
                              return value.CurrentPlayerThemeId == 5
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  2 -
                                              30,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          backgroundBlendMode:
                                              BlendMode.multiply,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Container(
                                          child: Icon(Icons.check),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(200)),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          )
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget CheckBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2 - 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.multiply,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Container(
          child: Icon(Icons.check),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(200)),
        ),
      ),
    );
  }
}
