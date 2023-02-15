import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:audio_player/Components/Players/player3.dart';
import 'package:audio_player/Components/Players/player4.dart';
import 'package:audio_player/DBHandling/DB.dart';
import 'package:audio_player/Player2.dart';
import 'package:audio_player/Screens/BottomSheetPlayer.dart';
import 'package:audio_player/StateManager/GetXStorage.dart';
import 'package:audio_player/Themes/GlobalThemes.dart';

import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class manager with ChangeNotifier {
  late List<SongInfo> songs;
  late List<AudioSource> songsSource = [];

  late int currentIndex = 0;
  double currentPosition = 0.00;
  late double MaxValue = 0.0;
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  bool isSuffleOn = false;
  bool isLoopOne = false;
  bool isLoopAll = true;
  int playListId = 0;
  List items = [];
  int Tmin = 0;
  int Tsec = 0;
  int Cmin = 0;
  int Csec = 0;
  bool player1 = false;
  bool player2 = true;
  bool playerAvailable = false;

  bool isArtistLoaded = false;
  bool isAlbumLoaded = false;

  late String sourceId;

  FlutterAudioQuery flutterAudioQuery = FlutterAudioQuery();
  List<SongInfo> getSongList = [];
  List<SongInfo> getSongListMain = [];

  List<PlayListId> currentPlayList = [];
  List<SongInfo> currentPlayListSOng = [];
  List<String> ListOfId = [];

  List<AlbumInfo> AlbumList = [];
  List<ArtistInfo> ArtistList = [];
  List<bool> isSelected = [];
  bool Songadded = false;

  List<String> ids = [];
  List<String> Artistids = [];

  int CurrentbandId = 0;
  int Currentfreq = 0;

  bool initEqualizer = false;

  bool custom = true;

  bool isEqEnabled =
      musicData.read("Eq") != null ? musicData.read("Eq") : false;

  List<SongInfo> searchList = [];

  // late BassBoost bassBoost;

  List<int> bandLevelRange = [];

  late double eqMinVal = -15;
  late double eqMaxVal = 15;

  late double bassval = 500;

  var bands = <int>[0, 0, 0, 0, 0];

  bool EqInit = false;

  DB db = DB();

  List<String> presets = [];

  String CurrentPresets = "Classic";

  late int CurrentPlayerThemeId;

  List<String> FavouriteIdList = [];
  List<SongInfo> FavouriteSongsList = [];

  void generate() {
    isSelected = List.generate(getSongList.length, (index) => false);
  }

  void changeListTile(index) {
    isSelected[index] = true;
    Songadded = true;
    notifyListeners();
  }

  late Widget currentPlayer;
  List PlayerThemes = [
    Player2(),
    Player3(),
    Player4(),
    BottomSheetPlayer(),
  ];

  manager() {
    currentPlayer = musicData.read("player") != null
        ? PlayerThemes[musicData.read("player")]
        : Player2();
    CurrentPlayerThemeId =
        musicData.read("player") != null ? musicData.read("player") : 0;
    isEqEnabled = musicData.read("Eq") != null ? musicData.read("Eq") : false;
    notifyListeners();
  }

  void setEqEnabled(bool cond) {
    isEqEnabled = cond;
    musicData.write("Eq", cond);
    readyEqualiser(cond);
    notifyListeners();
  }

  // setSearchList(keyword) {
  //   if (keyword.isEmpty) {
  //     searchList.clear();
  //     searchList.addAll(getSongList);
  //   } else {
  //     searchList.clear();
  //     searchList.addAll(getSongList
  //         .where((element) =>
  //             element.displayName.toLowerCase().contains(keyword.toLowerCase()))
  //         .toList());
  //   }

  //   notifyListeners();
  // }

  // void SetSourceID() {
  //   sourceId = player.androidAudioSessionId.toString();
  //   notifyListeners();
  // }
  void setEqDisabled() {
    musicData.write("Eq", false);
    notifyListeners();
  }

  void PlayerChange(index) {
    if (CurrentPlayerThemeId != index) {
      musicData.write("player", index);
      currentPlayer = musicData.read("player") != null
          ? PlayerThemes[musicData.read("player")]
          : Player2();
      CurrentPlayerThemeId =
          musicData.read("player") != null ? musicData.read("player") : 0;
      notifyListeners();
    }
  }

  setBandRange(int id, int val) {
    bands[id] = val;
    if (id == 5) {
      notifyListeners();
    }
    // notifyListeners();
  }

  setBandRangeBTN(int id, int val) {
    bands[id] = val;
    notifyListeners();
    // notifyListeners();
  }

  // void chnagePlayerThemes(index) async {
  //   CurrentThemes = PlayerThemes[0];
  //   notifyListeners();
  // }

  // manager({required this.songs, required this.currentIndex});

  // void chnages() {}

  void clickToSuffle() {
    if (isLoopAll) {
      isSuffleOn = true;
      isLoopAll = false;
      isLoopOne = false;
      // if (!player.shuffleModeEnabled) {
      //   player.setShuffleModeEnabled(true);
      // }
      // player.setLoopMode(LoopMode.all);
    } else if (isSuffleOn) {
      isSuffleOn = false;
      isLoopAll = false;
      isLoopOne = true;
      // player.setShuffleModeEnabled(false);
      // player.setLoopMode(LoopMode.one);
    } else {
      isLoopAll = true;
      isSuffleOn = false;
      isLoopOne = false;
      player.setShuffleModeEnabled(false);
      // player.setLoopMode(LoopMode.all);
    }

    notifyListeners();
  }

  setSongs(List<SongInfo> songsList, int currentIdx, int listId, [songId = 0]) {
    // currentIndex = currentIdx;
    // notifyListeners();

    if (listId == 2000) {
      songs = getSongList;
      currentIndex = getSongList.indexWhere((element) => element.id == songId);
      for (var element in songs) {
        songsSource.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              album: element.album ?? "No Album",
              title: element.displayName,
              // artUri: Uri.parse(element.id.toString()),
            ),
          ),
        );
      }
      player.setAudioSource(
          ConcatenatingAudioSource(
              useLazyPreparation: true, children: songsSource),
          initialIndex: currentIndex);
    } else {
      if (songsSource.isEmpty) {
        currentIndex = currentIdx;
        playListId = listId;
        songs = songsList;
        for (var element in songsList) {
          songsSource.add(
            AudioSource.uri(
              Uri.parse(element.uri!),
              tag: MediaItem(
                id: element.id.toString(),
                album: element.album ?? "No Album",
                title: element.displayName,
                // artUri: Uri.parse(element.id.toString()),
              ),
            ),
          );
        }
        player.setAudioSource(
            ConcatenatingAudioSource(
                useLazyPreparation: true, children: songsSource),
            initialIndex: currentIndex);
      } else if (playListId == listId) {
        currentIndex = currentIdx;
        player.seek(Duration.zero, index: currentIndex);
      } else {
        Future.delayed(Duration(milliseconds: 500));
        currentIndex = currentIdx;
        songs = songsList;
        playListId = listId;
        songsSource.clear();
        for (var element in songsList) {
          songsSource.add(
            AudioSource.uri(
              Uri.parse(element.uri!),
              tag: MediaItem(
                id: element.id.toString(),
                album: element.album ?? "No Album",
                title: element.displayName,
                // artUri: Uri.parse(element.id.toString()),
              ),
            ),
          );
        }
        player.setAudioSource(
            ConcatenatingAudioSource(
                useLazyPreparation: true, children: songsSource),
            initialIndex: currentIndex);
      }
    }

    player.play();
    playerAvailable = true;
    isPlaying = true;
    listenToSOngIndex();
    listenToDuration();
    listenToPosition();
    listenPlayerState();

    // if (!EqInit) {
    //   EqualizerFlutter.init(player.androidAudioSessionId!);
    //   EqInit = true;
    // }

    notifyListeners();
  }

  next() {
    Future.delayed(Duration(milliseconds: 500));
    if (isSuffleOn) {
      currentIndex = getRandom();
      player.seek(Duration.zero, index: currentIndex);
    } else if (isLoopAll) {
      if (currentIndex == songs.length - 1) {
        currentIndex = 0;
        player.seek(Duration.zero, index: currentIndex);
      } else {
        player.seekToNext();
      }
    } else {
      if (isLoopOne && player.hasNext) {
        currentIndex++;
        player.seek(Duration.zero, index: currentIndex);
      } else {
        player.seekToNext();
      }
    }
    notifyListeners();
  }

  playernext() async {
    Future.delayed(Duration(milliseconds: 1000));
    if (isSuffleOn) {
      currentIndex = getRandom();
      player.seek(Duration.zero, index: currentIndex);
    } else if (isLoopAll) {
      if (currentIndex == songs.length - 1) {
        currentIndex = 0;
        player.seek(Duration.zero, index: currentIndex);
      } else {
        player.seekToNext();
      }
    } else {
      if (player.hasNext) {
        player.seek(Duration.zero, index: currentIndex + 0);
      }
    }
    notifyListeners();
  }

  prev() {
    if (isSuffleOn) {
      currentIndex = getRandom();
      player.seek(Duration.zero, index: currentIndex);
    } else if (isLoopAll) {
      if (currentIndex == 0) {
        currentIndex = songs.length - 1;
        player.seek(Duration.zero, index: currentIndex);
      } else {
        player.seekToPrevious();
      }
    } else {
      if (player.hasPrevious) {
        player.seekToPrevious();
      }
    }
  }

  void listenToSOngIndex() {
    player.currentIndexStream.listen((event) {
      if (event != null) {
        currentIndex = event;
        notifyListeners();
      }
    });
  }

  void listenToDuration() {
    player.durationStream.listen((event) {
      if (player.playing) {
        MaxValue = event!.inMicroseconds.toDouble();
        Tmin = event.inMinutes;
        var temp = event.inSeconds;
        Tsec = temp - Tmin * 60;
        notifyListeners();
      }
    });
  }

  void listenToPosition() {
    player.positionStream.listen((event) {
      if (isPlaying) {
        if (event.inSeconds != 0 && event.inSeconds == Tsec + Tmin * 60) {
          playernext();
        }

        currentPosition = event.inMicroseconds.toDouble();
        if (event.inSeconds == 60) {
          Csec = 1;
        } else {
          if (event.inSeconds > 60) {
            var temp = event.inSeconds;
            Csec = temp - (Cmin * 60);
          } else {
            Csec = event.inSeconds;
          }
        }

        Cmin = event.inMinutes;
      }

      notifyListeners();
    });
  }

  void listenPlayerState() {
    player.playerStateStream.listen((state) {
      if (state.playing) {
        isPlaying = true;
      } else {
        isPlaying = false;
        switch (state.processingState) {
          case ProcessingState.idle:
          case ProcessingState.loading:
          case ProcessingState.buffering:
          case ProcessingState.ready:
          case ProcessingState.completed:
        }
      }

      notifyListeners();
    });
  }

  playPause() {
    if (player.playerState.playing) {
      player.pause();
    } else {
      player.play();
    }
    notifyListeners();
  }

  int convertToMin(int microSecond) {
    return (microSecond / 1000000 * 60).toInt();
  }

  int convertTosecond(int microSecond) {
    return (microSecond / 1000000).toInt();
  }

  getRandom() {
    return Random().nextInt(max(0, songs.length));
  }

  Future<void> getPlayList() async {
    currentPlayList.clear();
    currentPlayList = await db.getPlayListData();
    notifyListeners();
  }

  Future<bool> insertData(playListId) async {
    var res = await db.insertData2(PlayListId(playListId: playListId));
    if (res) {
      getPlayList();

      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> getSongsList() async {
    getSongList.clear();

    List<SongInfo> getSongList2 = await flutterAudioQuery.getSongs();
    for (var each in getSongList2) {
      if (each.duration != null) {
        if (int.parse(each.duration) > 35000) {
          getSongList.add(each);
          if (each.albumId != null) {
            ids.add(each.albumId);
          }
        }
      }
    }
    getSongList = getSongList;
    notifyListeners();
  }

  Future<void> changeFreq(int bandid, int lowervalue) async {
    EqualizerFlutter.setBandLevel(bandid, lowervalue);
    setBandRangeBTN(bandid, lowervalue);
    custom = true;
    // setMinMaxEq();
    notifyListeners();
  }

  void readyEqualiser(bool cond) {
    EqualizerFlutter.setEnabled(cond);
    // bassBoost.setEnabled(enabled: cond);
    notifyListeners();
  }

  initEqalizer() async {
    try {
      await EqualizerFlutter.init(player.androidAudioSessionId!);
    } catch (e) {}
    print("base:${bassval}");
    notifyListeners();
  }

  Future<List<String>> getPresest() async {
    presets = await EqualizerFlutter.getPresetNames();
    return presets;
  }

  setPresets(presetName) {
    EqualizerFlutter.setPreset(presetName);
    CurrentPresets = presetName;
    custom = false;
    notifyListeners();
  }

  setbassval(val) {
    bassval = val.toDouble();
    // bassBoost.setStrength(strength: bassval.toInt());
    print("base:${bassval}");
    notifyListeners();
  }

  setMinMaxEq() {
    eqMinVal = bandLevelRange[0].toDouble();
    eqMaxVal = bandLevelRange[1].toDouble();
    notifyListeners();
  }

  getSongsListMain() async {
    // getSongListMain = await flutterAudioQuery.getSongs();
    // getSongListMain = getSongListMain;
    getSongListMain.clear();

    List<SongInfo> getSongList2 = await flutterAudioQuery.getSongs();
    for (var each in getSongList2) {
      if (each.duration != null) {
        if (int.parse(each.duration) > 35000) {
          getSongListMain.add(each);
          if (each.albumId != null) {
            ids.add(each.albumId);
          }
        }
      }
    }
    getSongListMain = getSongListMain;

    notifyListeners();
  }

  Future<List<SongInfo>> getData(PlayListId) async {
    currentPlayListSOng.clear();
    ListOfId.clear();
    await db.getPlayListSongData(PlayListId).then((value) async {
      for (var each in value) {
        ListOfId.add(each.songId);
      }
      // final Matching = HashSet.from(songsList);
      final Matching = HashSet.from(ListOfId);
      currentPlayListSOng.addAll(getSongList
          .where((element) => Matching.contains(element.id.toString())));
    });

    notifyListeners();
    return currentPlayListSOng;
  }

  Future<bool> insertSongPlaylist(songId, playListId) async {
    var res = await db
        .insertData(PlayListModal(songId: songId, playListId: playListId));
    if (res) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> ListArtist() async {
    if (!isArtistLoaded) {
      ArtistList = await flutterAudioQuery.getArtists();
      ArtistList = ArtistList;
      notifyListeners();
      isArtistLoaded = true;
    }
  }

  Future<void> ListAlbum(ids) async {
    if (!isAlbumLoaded) {
      AlbumList = await flutterAudioQuery.getAlbumsById(ids: ids);
      AlbumList = AlbumList;
      notifyListeners();
    }
  }

  Future<bool> deleteSOngs(PlayListId, songId) async {
    var res = await db.deleteSong(PlayListId, songId);
    if (res) {
      return true;
    }
    return false;
  }

  Future<bool> deletePlayList(PlayListId) async {
    var res = await db.deletePlayList(PlayListId);
    if (res) {
      getPlayList();
      notifyListeners();
      return true;
    }
    return false;
  }

//Favourite Section

  Future<List<SongInfo>> getFavourite() async {
    FavouriteSongsList.clear();
    FavouriteIdList.clear();
    await db.getFavouriteSong().then((value) async {
      for (var each in value) {
        FavouriteIdList.add(each.songId);
      }
      // final Matching = HashSet.from(songsList);
      final Matching = HashSet.from(FavouriteIdList);
      FavouriteSongsList.addAll(getSongList
          .where((element) => Matching.contains(element.id.toString())));
    });

    notifyListeners();
    return FavouriteSongsList;
  }

  bool checkIfExistFav(songId) {
    var res = FavouriteIdList.where((element) => element.contains(songId));
    if (res.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  getSongIndex(songId) {
    getSongList.indexWhere((element) => element.id == songId);
  }
}
