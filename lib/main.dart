import 'package:flutter/material.dart';
import 'theme_changer/model_theme.dart';
import 'package:provider/provider.dart';

import 'album.dart';
import 'home_page.dart';
import 'info_map.dart';
import 'rgba_to_color.dart';

void main() {
  final Map<String, List<String>> songList = infoMap();

  final List<String> albumCoverList = [
    "assets/images/lover_cover.jpeg",
    "assets/images/fearless_cover.jpeg",
    "assets/images/evermore_cover.jpeg",
    "assets/images/reputation_cover.jpeg",
    "assets/images/speak_now_cover.jpeg",
    "assets/images/red_cover.jpeg",
    "assets/images/folklore_cover.jpeg",
    "assets/images/1989_cover.jpeg",
    "assets/images/midnights_cover.jpeg",
  ];

  final Map<String, List<int>> albumColors = {
    "Lover" : [255, 247, 187, 212],
    "Fearless" : [255, 242, 202, 141],
    "evermore" : [255, 205, 181, 155],
    "Reputation" : [255, 127, 121, 123],
    "Speak Now" : [255, 208, 179, 209],
    "Red" : [255, 134, 56, 70],
    "folklore": [255, 210, 207, 200],
    "1989" : [255, 194, 235, 252],
    "Midnights" : [255, 55, 62, 90]
  };

  runApp(MyApp(
      songList: songList,
      albumCoverList: albumCoverList,
      albumColors: albumColors));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.songList,
      required this.albumCoverList,
      required this.albumColors});

  final Map<String, List<String>> songList;
  final List<String> albumCoverList;
  final Map<String, List<int>> albumColors;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
              title: "Project Swiftie",
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.isDark
                  ? ThemeData(brightness: Brightness.dark)
                  : ThemeData(brightness: Brightness.light),
              home: MyHomePage(
                  albums: List.generate(
                      songList.length,
                      (index) => Album(
                          songList.keys.elementAt(index),
                          albumCoverList[index],
                          listToColor(albumColors[albumColors.keys.elementAt(index)]!),
                          songList[songList.keys.elementAt(index)]!))));
        },
      ),
    );
  }
}
