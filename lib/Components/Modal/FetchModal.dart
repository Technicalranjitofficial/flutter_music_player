import 'package:flutter_audio_query/flutter_audio_query.dart';

class FetchModal {
  late FlutterAudioQuery audioQuery;
  FetchModal() {
    audioQuery = FlutterAudioQuery();
  }

  Future<List<SongInfo>> ListSongs() async {
    return await audioQuery.getSongs();
  }

  Future<List<ArtistInfo>> ListArtist(ids) async {
    return await audioQuery.getArtistsById(ids: ids);
  }

  Future<List<AlbumInfo>> ListAlbum(ids) async {
    return await audioQuery.getAlbumsById(ids: ids);
  }
}
