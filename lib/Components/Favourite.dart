import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  GlobalThemes globalThemes = GlobalThemes();

  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<manager>(
      builder: (context, value, child) {
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: ListView.builder(
            itemCount: value.FavouriteSongsList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("${value.FavouriteSongsList.length} Favourite",
                        style: TextStyle(
                            color: globalThemes.colors2['textColor2'],
                            fontFamily: "Oswald-Regular",
                            fontWeight: FontWeight.w400)),
                  ),
                );
              }
              return InkWell(
                onTap: () async {
                  value.setSongs(value.FavouriteSongsList, index - 1, 2000,
                      value.FavouriteSongsList[index - 1].id);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListTile(
                    title: Text(
                      "${value.FavouriteSongsList[index - 1].displayName}",
                      maxLines: 1,
                      style: TextStyle(
                          color: globalThemes.colors2['textColor2'],
                          wordSpacing: 1,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Oswald-Regular",
                          fontWeight: FontWeight.lerp(
                              FontWeight.bold, FontWeight.w300, 20)),
                    ),
                    leading: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: globalThemes.colors2['bgColor'],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(-1, -1),
                                color: globalThemes.colors['boxShadowWhite']!,
                                blurRadius: 1),
                            BoxShadow(
                                offset: Offset(2, 2),
                                color: globalThemes.colors['boxShadowDark']!,
                                blurRadius: 2),
                          ],
                          shape: BoxShape.rectangle),
                      child: Stack(children: [
                        Container(
                          child: QueryArtworkWidget(
                              keepOldArtwork: true,
                              nullArtworkWidget: Center(
                                  child: Stack(
                                children: [
                                  Container(
                                    child: Image.asset(
                                        "assets/images/music4.jpg",
                                        fit: BoxFit.contain),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      backgroundBlendMode:
                                          globalThemes.PlayerTheme2,
                                    ),
                                  )
                                ],
                              )),
                              artworkWidth: 70,
                              artworkHeight: 70,
                              artworkBorder: BorderRadius.horizontal(
                                  left: Radius.zero, right: Radius.zero),
                              artworkFit: BoxFit.cover,
                              id: int.parse(
                                  value.FavouriteSongsList[index - 1].id),
                              type: ArtworkType.AUDIO),
                        ),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: globalThemes.colors2['playerThemesColor2'],
                            backgroundBlendMode: globalThemes.PlayerTheme2,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
