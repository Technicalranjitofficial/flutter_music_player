import 'package:audio_player/Routes/RouteManager.dart';
import 'package:audio_player/Screens/HomePage.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<manager>(
        create: (context) => manager(),
        builder: (context, child) {
          return GetMaterialApp(
            title: "Smart Audio Player",
            initialRoute: RouteManager.splashScreen,
            onGenerateRoute: RouteManager.generateRoutes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
          );
        },
      )
    ]);
  }
}


// return MaterialApp(
//               title: 'Music Player',
//               initialRoute: RouteManager.Home,
//               onGenerateRoute: RouteManager.generateRoutes,
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                 primarySwatch: Colors.blue,
//               ));
