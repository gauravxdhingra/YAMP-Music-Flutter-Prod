// import 'dart:io';
// import 'dart:math';

// import 'package:flute_music_player/flute_music_player.dart';
// import 'package:flutter/material.dart';
// import 'package:test_player/database/database_client.dart';
// import 'package:test_player/pages/artistcard.dart';
// import 'package:test_player/pages/card_detail.dart';
// import 'package:test_player/pages/list_songs.dart';
// import 'package:test_player/pages/now_playing.dart';
// import 'package:test_player/util/artistInfo.dart';
// import 'package:test_player/util/lastplay.dart';
// import 'package:test_player/util/utility.dart';
// // import 'package:musicplayer/util/artistInfo.dart';
// // import 'package:musicplayer/util/utility.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:musicplayer/database/database_client.dart';
// // import 'package:musicplayer/pages/artistcard.dart';
// // import 'package:musicplayer/pages/card_detail.dart';
// // import 'package:musicplayer/pages/list_songs.dart';
// // import 'package:musicplayer/pages/now_playing.dart';
// // import 'package:musicplayer/util/lastplay.dart';
// import 'package:flutter/cupertino.dart';

// class Home extends StatefulWidget {
//   final DatabaseClient db;

//   Home(this.db);

//   @override
//   State<StatefulWidget> createState() {
//     return new HomeState();
//   }
// }

// class HomeState extends State<Home> {
//   List<Song> songs;
//   bool isLoading = true;
//   int noOfFavorites;
//   Song last;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   dynamic getImage(Song song) {
//     return song.albumArt == null
//         ? null
//         : new File.fromUri(Uri.parse(song.albumArt));
//   }

//   void init() async {
//     noOfFavorites = await widget.db.noOfFavorites();
//     last = await widget.db.fetchLastSong();
//     songs = await widget.db.fetchSongs();
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Orientation orientation = MediaQuery.of(context).orientation;
//     return new CustomScrollView(
//       slivers: <Widget>[
//         new SliverAppBar(
//           expandedHeight: 180.0,
//           floating: false,
//           elevation: 0.0,
//           pinned: false,
//           primary: true,
//           title: Text("Grey",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.0)),
//           backgroundColor: Colors.white30,
//           brightness: Brightness.dark,
//           leading: Padding(
//             child: Image.asset(
//               "images/icon.png",
//             ),
//             padding: EdgeInsets.all(13.0),
//           ),
//           actions: <Widget>[
//             new IconButton(
//                 icon: Icon(
//                   Icons.info_outline,
//                   color: Colors.white,
//                 ),
//                 onPressed: (){}),
//             new IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   showSearch(context: context, delegate: SearchSong());
//                 })
//           ],
//           flexibleSpace: new FlexibleSpaceBar(
//             background: new Stack(
//               fit: StackFit.expand,
//               children: <Widget>[
//                 isLoading
//                     ? new Image.asset(
//                         "images/music.jpg",
//                         fit: BoxFit.fitWidth,
//                       )
//                     : getImage(last) != null
//                         ? new Image.file(
//                             getImage(last),
//                             fit: BoxFit.cover,
//                           )
//                         : new Image.asset(
//                             "images/back.jpg",
//                             fit: BoxFit.fitWidth,
//                           ),
//               ],
//             ),
//           ),
//         ),
//         new SliverList(
//           delegate: !isLoading
//               ? new SliverChildListDelegate(<Widget>[
//                   Padding(
//                     padding:
//                         EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
//                     child: Center(
//                       child: Text(
//                         last.artist.toUpperCase() +
//                             " - " +
//                             last.title.toUpperCase(),
//                         style: TextStyle(
//                             color: Colors.blueGrey[900],
//                             fontSize: 14.0,
//                             fontStyle: FontStyle.normal,
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 1.5),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         softWrap: true,
//                       ),
//                     ),
//                   ),
//                   new Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, top: 15.0, bottom: 10.0),
//                     child: new Text(
//                       "QUICK ACTIONS",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                           letterSpacing: 2.0,
//                           color: Colors.black.withOpacity(0.75)),
//                     ),
//                   ),
//                   new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       new Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           new RawMaterialButton(
//                             shape: CircleBorder(),
//                             fillColor: Colors.transparent,
//                             splashColor: Colors.blueGrey[200],
//                             highlightColor:
//                                 Colors.blueGrey[200].withOpacity(0.3),
//                             elevation: 15.0,
//                             highlightElevation: 0.0,
//                             disabledElevation: 0.0,
//                             onPressed: () {
//                               Navigator.of(context).push(
//                                   new MaterialPageRoute(builder: (context) {
//                                 return new ListSongs(widget.db, 1, orientation);
//                               }));
//                             },
//                             child: new Icon(
//                               CupertinoIcons.restart,
//                               size: 50.0,
//                               color: Colors.blueGrey[400],
//                             ),
//                           ),
//                           new Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0)),
//                           new Text(
//                             "RECENTS",
//                             style: new TextStyle(
//                                 fontSize: 12.0, letterSpacing: 2.0),
//                           ),
//                         ],
//                       ),
//                       new Column(children: <Widget>[
//                         new RawMaterialButton(
//                           shape: CircleBorder(),
//                           fillColor: Colors.transparent,
//                           splashColor: Colors.blueGrey[200],
//                           highlightColor: Colors.blueGrey[200].withOpacity(0.3),
//                           elevation: 15.0,
//                           highlightElevation: 0.0,
//                           disabledElevation: 0.0,
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .push(new MaterialPageRoute(builder: (context) {
//                               return new ListSongs(widget.db, 2, orientation);
//                             }));
//                           },
//                           child: new Icon(
//                             Icons.assessment,
//                             size: 50.0,
//                             color: Colors.blueGrey[400],
//                           ),
//                         ),
//                         new Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0)),
//                         new Text("TOP SONGS",
//                             style: new TextStyle(
//                                 fontSize: 12.0, letterSpacing: 2.0))
//                       ]),
//                       new Column(
//                         children: <Widget>[
//                           new RawMaterialButton(
//                             shape: CircleBorder(),
//                             fillColor: Colors.transparent,
//                             splashColor: Colors.blueGrey[200],
//                             highlightColor:
//                                 Colors.blueGrey[200].withOpacity(0.3),
//                             elevation: 15.0,
//                             highlightElevation: 0.0,
//                             disabledElevation: 0.0,
//                             onPressed: () {
//                               Navigator.of(context).push(
//                                   new MaterialPageRoute(builder: (context) {
//                                 return new NowPlaying(widget.db, songs,
//                                     new Random().nextInt(songs.length), 0);
//                               }));
//                             },
//                             child: new Icon(
//                               CupertinoIcons.shuffle_thick,
//                               size: 50.0,
//                               color: Colors.blueGrey[400],
//                             ),
//                           ),
//                           new Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0)),
//                           new Text("RANDOM",
//                               style: new TextStyle(
//                                   fontSize: 12.0, letterSpacing: 2.0))
//                         ],
//                       ),
//                     ],
//                   ),

//                   //Recents
//                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
//                   new Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, top: 15.0, bottom: 10.0),
//                     child: new Text(
//                       "YOUR RECENTS!",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                           letterSpacing: 2.0,
//                           color: Colors.black.withOpacity(0.75)),
//                     ),
//                   ),
//                   recentW(),

//                   //Top Albums
//                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
//                   new Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, top: 0.0, bottom: 10.0),
//                     child: new Text(
//                       "TOP ALBUMS",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                           letterSpacing: 2.0,
//                           color: Colors.black.withOpacity(0.75)),
//                     ),
//                   ),
//                   topAlbums(),

//                   //Top Artists
//                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
//                   new Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, top: 0.0, bottom: 10.0),
//                     child: new Text(
//                       "TOP ARTISTS",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                           letterSpacing: 2.0,
//                           color: Colors.black.withOpacity(0.75)),
//                     ),
//                   ),
//                   topArtists(),

//                   //Favorites

//                   noOfFavorites != 0 ? favorites1() : Container(),

//                   //May like
//                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
//                   new Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, top: 0.0, bottom: 20.0),
//                     child: new Text(
//                       "YOU MAY LIKE!",
//                       style: new TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.0,
//                           letterSpacing: 2.0,
//                           color: Colors.black.withOpacity(0.75)),
//                     ),
//                   ),

//                   randomW(),
//                 ])
//               : new SliverChildListDelegate(<Widget>[
//                   new Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 50.0),
//                       child: new CircularProgressIndicator(
//                         backgroundColor: Colors.blueGrey[400],
//                       ),
//                     ),
//                   )
//                 ]),
//         ),
//       ],
//     );
//   }

//   // Done
//   Widget topArtists() {
//     return new Container(
//       height: 180.0,
//       child: FutureBuilder(
//         future: widget.db.fetchTopArtists(),
//         builder: (context, AsyncSnapshot<List<Song>> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               break;
//             case ConnectionState.waiting:
//               break;
//             case ConnectionState.active:
//               return CircularProgressIndicator();
//             case ConnectionState.done:
//               List<Song> topArtist = snapshot.data;
//               return ListView.builder(
//                 itemCount: topArtist.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0, right: 0.0),
//                   child: Column(
//                     children: <Widget>[
//                       new InkResponse(
//                         child: SizedBox(
//                           child: Hero(
//                             tag: topArtist[i].artist,
//                             child: getImage(topArtist[i]) != null //Artist Image
//                                 ? Container(
//                                     height: 130.0,
//                                     width: 130.0,
//                                     child: Material(
//                                       elevation: 25.0,
//                                       color: Colors.transparent,
//                                       shape: CircleBorder(),
//                                       child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(65.0),
//                                           child: GetArtistDetail(
//                                             artist: topArtist[i].artist,
//                                             artistSong: topArtist[i],
//                                           )),
//                                     ),
//                                   )
//                                 : CircleAvatar(
//                                     backgroundImage:
//                                         AssetImage("images/back.jpg"),
//                                     radius: 60.0,
//                                   ),
//                           ),
//                         ),
//                         onTap: () {
//                           Navigator.of(context)
//                               .push(new MaterialPageRoute(builder: (context) {
//                             return new ArtistCard(widget.db, topArtist[i]);
//                           }));
//                         },
//                       ),
//                       SizedBox(
//                         width: 150.0,
//                         child: Padding(
//                           // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                           padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Center(
//                                 child: Text(
//                                   topArtist[i].artist,
//                                   style: new TextStyle(
//                                       fontSize: 14.0,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black.withOpacity(0.70)),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               SizedBox(height: 0.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//           }
//           return Text('end');
//         },
//       ),
//     );
//   }

//   // Done
//   Widget topAlbums() {
//     return new Container(
//       height: 215.0,
//       child: FutureBuilder(
//         future: widget.db.fetchTopAlbum(),
//         builder: (context, AsyncSnapshot<List<Song>> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               break;
//             case ConnectionState.waiting:
//               return CircularProgressIndicator();
//             case ConnectionState.active:
//               break;
//             case ConnectionState.done:
//               List<Song> topAlbum = snapshot.data;
//               return ListView.builder(
//                 itemCount: topAlbum.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 35.0),
//                   child: new Card(
//                     elevation: 12.0,
//                     child: new InkResponse(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               child: Hero(
//                                 tag: topAlbum[i].album,
//                                 child: getImage(topAlbum[i]) != null
//                                     ? new Image.file(
//                                         getImage(topAlbum[i]),
//                                         height: 120.0,
//                                         width: 180.0,
//                                         fit: BoxFit.cover,
//                                       )
//                                     : new Image.asset(
//                                         "images/back.jpg",
//                                         height: 120.0,
//                                         width: 180.0,
//                                         fit: BoxFit.cover,
//                                       ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 180.0,
//                               child: Padding(
//                                 // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                                 padding:
//                                     EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       topAlbum[i].album,
//                                       style: new TextStyle(
//                                           fontSize: 12.0,
//                                           fontWeight: FontWeight.w500,
//                                           color:
//                                               Colors.black.withOpacity(0.70)),
//                                       maxLines: 1,
//                                     ),
//                                     SizedBox(height: 5.0),
//                                     Padding(
//                                       padding: EdgeInsetsDirectional.only(
//                                           bottom: 5.0),
//                                       child: Text(
//                                         topAlbum[i].artist,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontSize: 10.0,
//                                             color:
//                                                 Colors.black.withOpacity(0.75)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(new MaterialPageRoute(builder: (context) {
//                           return new CardDetail(widget.db, topAlbum[i]);
//                         }));
//                       },
//                     ),
//                   ),
//                 ),
//               );
//           }
//           return Text('end');
//         },
//       ),
//     );
//   }

//   Widget favorites1() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(padding: EdgeInsets.symmetric(vertical: 0.0)),
//         new Padding(
//           padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
//           child: new Text(
//             "FAVORITES",
//             style: new TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.0,
//                 letterSpacing: 2.0,
//                 color: Colors.black.withOpacity(0.75)),
//           ),
//         ),
//         favoritesList()
//       ],
//     );
//   }

//   // Done
//   Widget favoritesList() {
//     return new Container(
//       //aspectRatio: 16/15,
//       height: 215.0,
//       child: FutureBuilder(
//         future: widget.db.fetchFavSong(),
//         builder: (context, AsyncSnapshot<List<Song>> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               break;
//             case ConnectionState.waiting:
//               return CircularProgressIndicator();
//             case ConnectionState.active:
//               break;
//             case ConnectionState.done:
//               List<Song> favorites = snapshot.data;
//               return ListView.builder(
//                 itemCount: favorites.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 35.0),
//                   child: new Card(
//                     elevation: 12.0,
//                     child: new InkResponse(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               child: getImage(favorites[i]) != null
//                                   ? new Image.file(
//                                       getImage(favorites[i]),
//                                       height: 120.0,
//                                       width: 180.0,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : new Image.asset(
//                                       "images/back.jpg",
//                                       height: 120.0,
//                                       width: 180.0,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                             SizedBox(
//                               width: 180.0,
//                               child: Padding(
//                                 // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                                 padding:
//                                     EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       favorites[i].title,
//                                       style: new TextStyle(
//                                           fontSize: 12.0,
//                                           fontWeight: FontWeight.w500,
//                                           color:
//                                               Colors.black.withOpacity(0.70)),
//                                       maxLines: 1,
//                                     ),
//                                     SizedBox(height: 5.0),
//                                     Padding(
//                                       padding: EdgeInsetsDirectional.only(
//                                           bottom: 5.0),
//                                       child: Text(
//                                         favorites[i].artist,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontSize: 10.0,
//                                             color:
//                                                 Colors.black.withOpacity(0.75)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(new MaterialPageRoute(builder: (context) {
//                           return new NowPlaying(widget.db, favorites, i, 0);
//                         }));
//                       },
//                     ),
//                   ),
//                 ),
//               );
//           }
//           return Text('end');
//         },
//       ),
//     );
//   }

//   Widget randomW() {
//     return new Container(
//       height: 215.0,
//       child: FutureBuilder(
//         future: widget.db.fetchRandomAlbum(),
//         builder: (context, AsyncSnapshot<List<Song>> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               // TODO: Handle this case.
//               break;
//             case ConnectionState.waiting:
//               return CircularProgressIndicator();
//             case ConnectionState.active:
//               // TODO: Handle this case.
//               break;
//             case ConnectionState.done:
//               List<Song> albums = snapshot.data;
//               return ListView.builder(
//                 itemCount: albums.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 35.0),
//                   child: new Card(
//                     elevation: 12.0,
//                     child: new InkResponse(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               child: getImage(albums[i]) != null
//                                   ? new Image.file(
//                                       getImage(albums[i]),
//                                       height: 120.0,
//                                       width: 180.0,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : new Image.asset(
//                                       "images/back.jpg",
//                                       height: 120.0,
//                                       width: 180.0,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                             SizedBox(
//                               width: 180.0,
//                               child: Padding(
//                                 // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                                 padding:
//                                     EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       albums[i].album,
//                                       style: new TextStyle(
//                                           fontSize: 12.0,
//                                           fontWeight: FontWeight.w500,
//                                           color:
//                                               Colors.black.withOpacity(0.70)),
//                                       maxLines: 1,
//                                     ),
//                                     SizedBox(height: 5.0),
//                                     Padding(
//                                       padding: EdgeInsetsDirectional.only(
//                                           bottom: 5.0),
//                                       child: Text(
//                                         albums[i].artist,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontSize: 10.0,
//                                             color:
//                                                 Colors.black.withOpacity(0.75)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(new MaterialPageRoute(builder: (context) {
//                           return new CardDetail(widget.db, albums[i]);
//                         }));
//                       },
//                     ),
//                   ),
//                 ),
//               );
//           }
//           return Text('end');
//         },
//       ),
//     );
//   }

//   Widget recentW() {
//     return new Container(
//       height: 215.0,
//       child: FutureBuilder(
//         future: widget.db.fetchRecentSong(),
//         builder: (context, AsyncSnapshot<List<Song>> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               break;
//             case ConnectionState.waiting:
//               return CircularProgressIndicator();
//             case ConnectionState.active:
//               break;
//             case ConnectionState.done:
//               List<Song> recents = snapshot.data;
//               return ListView.builder(
//                 itemCount: recents.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 35.0),
//                   child: InkWell(
//                     onTap: () {
//                       MyQueue.songs = recents;
//                       Navigator.of(context)
//                           .push(new MaterialPageRoute(builder: (context) {
//                         return new NowPlaying(widget.db, recents, i, 0);
//                       }));
//                     },
//                     child: new Card(
//                       elevation: 12.0,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(6.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               child: Hero(
//                                 tag: recents[i].id,
//                                 child: getImage(recents[i]) != null
//                                     ? Container(
//                                         height: 120.0,
//                                         width: 180.0,
//                                         decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                           image: FileImage(
//                                             getImage(recents[i]),
//                                           ),
//                                           fit: BoxFit.cover,
//                                         )),
//                                       )
//                                     : new Image.asset(
//                                         "images/back.jpg",
//                                         height: 120.0,
//                                         width: 180.0,
//                                         fit: BoxFit.cover,
//                                       ),
//                               ),
//                             ),
//                             SizedBox(
//                                 width: 180.0,
//                                 child: Padding(
//                                   // padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                                   padding:
//                                       EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 0.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text(
//                                         recents[i].title,
//                                         style: new TextStyle(
//                                             fontSize: 12.0,
//                                             fontWeight: FontWeight.w500,
//                                             color:
//                                                 Colors.black.withOpacity(0.70)),
//                                         maxLines: 1,
//                                       ),
//                                       SizedBox(height: 5.0),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 5.0),
//                                         child: Text(
//                                           recents[i].artist,
//                                           style: TextStyle(
//                                               fontSize: 10.0,
//                                               color: Colors.black
//                                                   .withOpacity(0.75)),
//                                           maxLines: 1,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//           }
//           return Text('end');
//         },
//       ),
//     );
//   }

//   launchUrl(int i) async {
//     if (i == 1)
//       launch("http://github.com/avirias");
//     else if (i == 2)
//       launch("http://facebook.com/avirias");
//     else if (i == 3) launch("https://instagram.com/avirias/");
//   }
// }
