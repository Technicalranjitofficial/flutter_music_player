// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// // Widget showModal(BuildContext context) {
// //   return StatefulBuilder(
// //     builder: (context, setState) {
// //       return Scaffold(
// //         backgroundColor: Colors.black,
// //         primary: true,
// //         body: Container(
// //           height: MediaQuery.of(context).size.height,
// //           width: MediaQuery.of(context).size.width,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 20),
// //                 child: Container(
// //                   width: MediaQuery.of(context).size.width,
// //                   child: Column(children: [
// //                     Text(
// //                       "${songModel.displayName}",
// //                       maxLines: 1,
// //                       textAlign: TextAlign.start,
// //                       style: TextStyle(
// //                           fontSize: 18,
// //                           letterSpacing: 1,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white),
// //                     ),
// //                     Text(
// //                       "Unknown",
// //                       textAlign: TextAlign.start,
// //                       style: TextStyle(fontSize: 12, color: Colors.white),
// //                     ),
// //                   ]),
// //                 ),
// //               ),
// //               Container(
// //                 width: MediaQuery.of(context).size.width - 100,
// //                 child: CircleAvatar(
// //                   radius: 150,
// //                   backgroundImage: AssetImage("assets/images/music.jpg"),
// //                 ),
// //                 decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     border: Border.all(color: Colors.grey, width: 1)),
// //               ),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                       child: Icon(
// //                     Icons.logo_dev,
// //                     size: 25,
// //                     color: Colors.white,
// //                   )),
// //                   Expanded(
// //                       child: Icon(
// //                     Icons.logo_dev,
// //                     size: 25,
// //                     color: Colors.white,
// //                   )),
// //                   Expanded(
// //                       child: Icon(
// //                     Icons.info,
// //                     size: 25,
// //                     color: Colors.white,
// //                   )),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: MediaQuery.of(context).size.height / 60,
// //               ),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                       child: InkWell(
// //                     onTap: () {
// //                       if (CurrentIndex >= 0) {
// //                         setState(() {
// //                           CurrentIndex = CurrentIndex - 1;
// //                           songModel = songs[CurrentIndex];
// //                           player.setUrl(songModel.data);
// //                           player.play();
// //                           isplay = true;
// //                           changes();
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.skip_previous,
// //                       size: 40,
// //                       color: Colors.white,
// //                     ),
// //                   )),
// //                   Expanded(
// //                       child: InkWell(
// //                     onTap: () {
// //                       if (player.playing) {
// //                         player.pause();
// //                         setState(() {
// //                           isplay = false;
// //                           changes();
// //                         });
// //                       } else {
// //                         player.play();
// //                         setState(() {
// //                           isplay = true;
// //                           changes();
// //                         });
// //                       }
// //                     },
// //                     child: CircleAvatar(
// //                       radius: 30,
// //                       backgroundColor: Colors.white,
// //                       child: isplay
// //                           ? Icon(
// //                               Icons.pause,
// //                               size: 40,
// //                               color: Colors.black,
// //                             )
// //                           : Icon(
// //                               Icons.play_arrow,
// //                               size: 40,
// //                               color: Colors.black,
// //                             ),
// //                     ),
// //                   )),
// //                   Expanded(
// //                       child: InkWell(
// //                     onTap: () {
// //                       if (CurrentIndex <= songs.length - 1) {
// //                         setState(() {
// //                           CurrentIndex = CurrentIndex + 1;
// //                           songModel = songs[CurrentIndex];
// //                           player.setUrl(songModel.data);
// //                           player.play();
// //                           isplay = true;
// //                           changes();
// //                         });
// //                       }
// //                     },
// //                     child: Icon(
// //                       Icons.skip_next,
// //                       size: 40,
// //                       color: Colors.white,
// //                     ),
// //                   )),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }
