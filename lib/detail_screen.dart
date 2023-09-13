import 'package:flutter/material.dart';
import 'album.dart';

class DetailScreen extends StatefulWidget {
  final Album album;

  const DetailScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  List<bool> selected = [];
  
  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        s = s.toLowerCase();
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < widget.album.songList.length; i++) {
            if (widget.album.songList[i].toLowerCase().contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.white60,
            fontSize: 20,
          )),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length, //edit
        itemBuilder: (context, index) {
          index = _searchIndexList[index]; //add
          return Card(
              child: ListTile(title: Text(widget.album.songList[index])));
        });
  }

  Widget _defaultListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.album.songList.length,
      itemBuilder: (BuildContext context, int i) {
        selected.add(false);
        return Column(
          children: [
            ListTile(
              trailing: IconButton(
                icon: selected.elementAt(i)
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow_rounded),
                onPressed: () {
                  setState(() {
                    selected[i] = selected[i] == false ? true : false;
                  });
                },
              ),
              title: Text(
                widget.album.songList[i],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            title: !_searchBoolean
                ? Text(widget.album.albumName)
                : _searchTextField(),
            backgroundColor: widget.album.albumColor,
            elevation: 0,
            actions: !_searchBoolean
                ? [
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = true;
                            _searchIndexList = [];
                          });
                        })
                  ]
                : [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      },
                    )
                  ]),
        ),
        body: !_searchBoolean ? _defaultListView() : _searchListView());
  }
}
