import 'package:audio_player/Components/Modal/PlayListModal.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database> initDB() async {
    final String path = await getDatabasesPath();

    return openDatabase(
      join(path, "Music2.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("""

CREATE TABLE MUSIC(

  id INTEGER PRIMARY KEY AUTOINCREMENT,
  songId TEXT NOT NULL,
  playListId TEXT NOT NULL
)

""");

        db.execute("""

CREATE TABLE Playlist(

  id INTEGER PRIMARY KEY AUTOINCREMENT,
  playListId TEXT NOT NULL
)

""");

        db.execute("""

CREATE TABLE Favourite(

  id INTEGER PRIMARY KEY AUTOINCREMENT,
  songId TEXT NOT NULL
)

""");
      },
    );
  }

//   Future<Database> initDB2() async {
//     final String path = await getDatabasesPath();

//     return openDatabase(
//       join(path, "Music.db"),
//       version: 1,
//       onCreate: (db, version) {
//         return

//         db.execute("""

// CREATE TABLE Playlist(

//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   playListId TEXT NOT NULL
// )

// """);
//       },
//     );
//   }

  Future<bool> insertData(PlayListModal modal) async {
    final Database db = await initDB();
    if (await check(modal.playListId, modal.songId)) {
      print("Already Exist");
    } else {
      await db.insert("MUSIC", modal.toMap());
      return true;
    }

    return false;
  }

  Future<List<PlayListModal>> getPlayListSongData(playListId) async {
    final Database db = await initDB();

    List<Map<String, Object?>> datas =
        await db.query("MUSIC", where: "playListId=?", whereArgs: [playListId]);
    return datas.map((e) => PlayListModal.fromJson(e)).toList();
  }

  Future<bool> insertData2(PlayListId modal) async {
    final Database db = await initDB();
    if (await checkPlayListIFEXIST(modal.playListId)) {
      print("Playlist Exist");
      return false;
    }
    await db.insert("Playlist", modal.toMap());
    return true;
  }

  Future<List<PlayListId>> getPlayListData() async {
    final Database db = await initDB();
    List<Map<String, Object?>> datas = await db.query("Playlist");
    return datas.map((e) => PlayListId.fromJson(e)).toList();
  }

  Future<bool> check(PlayListId, songId) async {
    final Database db = await initDB();
    var res = await db.query("MUSIC",
        where: 'songId=? and playListId=?', whereArgs: [songId, PlayListId]);

    if (res.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<bool> checkPlayListIFEXIST(PlayListId) async {
    final Database db = await initDB();
    var res =
        await db.query("MUSIC", where: 'playListId=?', whereArgs: [PlayListId]);

    if (res.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<bool> deleteSong(PlayListId, songId) async {
    final Database db = await initDB();
    await db.delete("MUSIC",
        where: 'songId=? and playListId=?', whereArgs: [songId, PlayListId]);
    return true;
  }

  Future<bool> deletePlayList(PlayListId) async {
    final Database db = await initDB();
    final Database db2 = await initDB();
    await db.delete("MUSIC", where: 'playListId=?', whereArgs: [PlayListId]);
    await db2
        .delete("Playlist", where: 'playListId=?', whereArgs: [PlayListId]);
    return true;
  }

  Future<bool> renamePlayList(PlayListId modal, id) async {
    final Database db = await initDB();
    await db.update("Playlist", modal.toMap(), where: 'id=?', whereArgs: [id]);

    return true;
  }

  //favourite

  Future<bool> insertFavourite(FavouriteModal modal) async {
    final Database db = await initDB();
    if (await checkFavExist(modal.songId)) {
      print("Favourite Exist");
      return false;
    }
    await db.insert("Favourite", modal.toMap());
    return true;
  }

  Future<bool> checkFavExist(songId) async {
    final Database db = await initDB();
    var res =
        await db.query("Favourite", where: 'songId=?', whereArgs: [songId]);

    if (res.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<List<PlayListModal>> getFavouriteSong() async {
    final Database db = await initDB();
    List<Map<String, Object?>> datas = await db.query(
      "Favourite",
    );
    return datas.map((e) => PlayListModal.fromJson(e)).toList();
  }

  Future<bool> deleteFavourite(songId) async {
    final Database db = await initDB();
    await db.delete("Favourite", where: 'songId=?', whereArgs: [songId]);
    return true;
  }
}
