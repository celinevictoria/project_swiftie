import 'dart:ui';

class Album {
  final String albumName;
  final String albumCover;
  final Color albumColor;
  final List<String> songList;

  const Album(this.albumName, this.albumCover, this.albumColor, this.songList);
}
