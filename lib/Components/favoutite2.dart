// import 'package:audio_player/StateManager/MusicProvider.dart';
// import 'package:equalizer_flutter/equalizer_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';

// class Favorite2 extends StatefulWidget {
//   const Favorite2({super.key});

//   @override
//   State<Favorite2> createState() => _Favorite2State();
// }

// class _Favorite2State extends State<Favorite2> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     EqualizerFlutter.setEnabled(true);

//     getdata();
//   }

//   getdata() async {
//     await EqualizerFlutter.init(
//         context.read<manager>().player.androidAudioSessionId!);
//     print("band${await EqualizerFlutter.getBandLevelRange()}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Equalizer")),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               SwitchListTile(
//                 value: false,
//                 onChanged: (value) {},
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               FutureBuilder<List<int>>(
//                 future: EqualizerFlutter.getBandLevelRange(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return CustomEq(
//                       bandRange: snapshot.data!,
//                     );
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomEq extends StatefulWidget {
//   CustomEq({super.key, required this.bandRange});

//   List<int> bandRange;

//   @override
//   State<CustomEq> createState() => _CustomEqState();
// }

// class _CustomEqState extends State<CustomEq> {
//   late double min, max;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     min = widget.bandRange[0].toDouble();
//     max = widget.bandRange[1].toDouble();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int bandid = 0;
//     return Container(
//       child: FutureBuilder<List<int>>(
//         future: EqualizerFlutter.getCenterBandFreqs(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: snapshot.data!
//                       .map((freq) => slider(freq, bandid++))
//                       .toList(),
//                 )
//               ],
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   Widget slider(freq, bandid) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         FutureBuilder(
//           future: EqualizerFlutter.getBandLevel(bandid),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return FlutterSlider(
//                 values: [snapshot.hasData ? snapshot.data!.toDouble() : 0.00],
//                 min: min,
//                 onDragCompleted: (handlerIndex, lowerValue, upperValue) {},
//                 max: max,
//                 rtl: true,
//                 disabled: false,
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         )
//       ],
//     );
//   }
// }
