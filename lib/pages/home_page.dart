import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the Playlist Provider
  late final dynamic playListProvider;

  @override
  void initState() {
    super.initState();
    // get Playlist Provider
    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  // go to a song

  void goToSong(int songIndex) {
    // update current song index
    playListProvider.currentSongIndex = songIndex;
    // navigate to song page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "P L A Y L I S I",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, Value, child) {
        // get the playlist
        final List<Song> playlist = Value.playlist;

        // return ListView UI
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            // get individual song
            final Song song = playlist[index];

            // return ListTile UI
            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artisName),
              leading: Image.asset(song.albuArtImagePath),
              onTap: () => goToSong(index),
            );
          },
        );
      }),
    );
  }
}
