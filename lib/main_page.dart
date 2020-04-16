import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_player/screens/favourites_screen.dart';
import 'package:test_player/screens/loading_spinner.dart';
import 'package:test_player/screens/main_tracks_screen.dart';
import 'package:test_player/screens/now_playing_screen.dart';
import 'package:test_player/screens/playlist_screen.dart';
import 'package:test_player/screens/search_screen.dart';

// import './screens/loading_spinner.dart';
// import './widgets/music_tile.dart';
// import './widgets/recents_tile.dart';
import 'package:provider/provider.dart';
import './provider/songs_provider.dart';

Color backgroundColor = Color(0xff7800ee);

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Songs(null),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (ctx) => LoadingScreen(),
          MainPage.routeName: (ctx) => MainPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  static const routeName = '/main-page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final _controller = ScrollController();
  // final _controller1 = ScrollController();
  // static List<Song> _songs = [];
  @override
  void initState() {
    super.initState();
    // _songs = widget.songs;
    // widget.songs.forEach((ele) => _songs.add(ele));
    // print(_songs.length);
    // print(_songs[25].title);
    _setPage(0);
  }

  // List get songs => _songs;
  static BuildContext ctx;
  List<Widget> pages = [
    MainTracksScreen(),
    FavouritesScreen(),
    null,
    // NowPlayingScreen(
    //     // song: Provider.of<Songs>(ctx)
    //     //     .songgsget[Provider.of<Songs>(ctx).currentIndex],
    //     // songData: Provider.of<Songs>(ctx),
    //     // nowPlayTap: true,
    //     ),
    PlaylistScreen(),
    SearchScreen(),
  ];

  // Future _playLocal(String url) async {
  //   final result = await audioPlayer.play(url, isLocal: true);
  // }

  int _selectedpageindex = 0;

  void _setPage(int index) {
    setState(() {
      _selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: pages[_selectedpageindex],
      // MainTracksScreen(),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: backgroundColor,
        color: Colors.yellow,
        // Colors.blue[50],
        // animationDuration: Duration(seconds: 3),
        // index: 3,
        items: <Widget>[
          Icon(
            MdiIcons.musicNote,
          ),
          Icon(
            MdiIcons.heart,
          ),
          Icon(
            MdiIcons.playPause,
            // size: 36,
          ),
          Icon(
            MdiIcons.playlistMusic,
          ),
          Icon(
            MdiIcons.magnify,
          ),
        ],
        height: 52,
        onTap: (i) {
          if (i == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NowPlayingScreen(
                  song: songData.songgsget[songData.currentIndex],
                  songData: Provider.of<Songs>(context),
                  nowPlayTap: false,
                ),
              ),
            );
            return;
          } else
            _setPage(i);
        },

        // animationCurve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }
}

// class SongsSearch extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     final songs = Provider.of<Songs>(context).songgsget;
//     return null;
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return null;
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     return null;
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     return null;
//   }
// }
