import 'package:flutter/material.dart';
import 'theme_changer/model_theme.dart';
import 'album.dart';
import 'detail_screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.albums});
  final List<Album> albums;

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              title: const Text("Project Swiftie"),
              backgroundColor: const Color.fromARGB(255,55,62,90),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny),
                  onPressed: () {
                    themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                  },
                )
              ],
            ),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.only(top:8),
              itemCount: widget.albums.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        leading: Image.asset(widget.albums[index].albumCover),
                        title: Text(
                          widget.albums[index].albumName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    album: widget.albums[index]),
                              ));
                        }),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                );
              }),
          bottomNavigationBar: const BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                'Version 1.0.4',
                style: TextStyle(color: Colors.grey),
              )
            ]),
          ),
        );
      },
    );
  }
}
