class PlayListModal {
  final int? id;
  String songId;
  String playListId;
  PlayListModal({this.id, required this.songId, required this.playListId});

  factory PlayListModal.fromJson(Map<String, dynamic> json) => PlayListModal(
      id: json['id'], songId: json['songId'], playListId: json['playListId']);

  Map<String, dynamic> toMap() =>
      {"id": id, "songId": songId, "playListId": playListId};
}

class PlayListId {
  final int? id;
  String playListId;

  PlayListId({this.id, required this.playListId});

  factory PlayListId.fromJson(Map<String, dynamic> json) =>
      PlayListId(id: json['id'], playListId: json['playListId']);

  Map<String, dynamic> toMap() => {"id": id, "playListId": playListId};
}

class FavouriteModal {
  final int? id;
  String songId;

  FavouriteModal({this.id, required this.songId});

  factory FavouriteModal.fromJson(Map<String, dynamic> json) =>
      FavouriteModal(id: json['id'], songId: json['songId']);

  Map<String, dynamic> toMap() => {"id": id, "songId": songId};
}
