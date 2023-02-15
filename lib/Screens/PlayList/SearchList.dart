import 'package:audio_player/Screens/BottomPlayContainer.dart';
import 'package:audio_player/Screens/BottomSheetContainer2.dart';
import 'package:audio_player/Screens/PlayList.dart';
import 'package:audio_player/StateManager/MusicProvider.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  GlobalThemes globalThemes = GlobalThemes();

  String search = "";
  List<SongInfo> songs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songs = context.read<manager>().getSongList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: globalThemes.colors2['bgColor'],
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            Future.delayed(Duration(milliseconds: 500));

            if (searchController.text.isEmpty) {
              songs = context.read<manager>().getSongList;
            } else {
              setState(() {
                songs = context
                    .read<manager>()
                    .getSongList
                    .where((element) => element.displayName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                    .toList();
              });
            }
          },
          decoration: InputDecoration(
            hintText: "Search Songs",
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            fillColor: globalThemes.colors2['textColor'],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              return;
            },
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                if (songs.isNotEmpty) {
                  return InkWell(
                      onTap: () {
                        context
                            .read<manager>()
                            .setSongs(songs, index, 2000, songs[index].id);

                        // showModalBottomSheet(
                        //   useRootNavigator: true,
                        //   isDismissible: true,
                        //   enableDrag: true,
                        //   isScrollControlled: true,
                        //   context: context,
                        //   builder: (context) => Consumer<manager>(
                        //     builder: (context, value, child) {
                        //       return value.currentPlayer;
                        //     },
                        //   ),
                        // );
                      },
                      child: PlayList(
                          songs[index], globalThemes.colors2['textColor2']));
                } else {
                  return Container();
                }
                // return ListTile(

                //   title: Text(
                //       "${context.read<manager>().getSongList[index].displayName}"),
                // );
              },
            ),
          )),
          Consumer<manager>(
            builder: (context, value, child) {
              return value.playerAvailable
                  ? BottomPlayContainer2()
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
