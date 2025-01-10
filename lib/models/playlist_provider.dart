import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // Playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: "Violin Music",
      artisName: "Violin",
      albuArtImagePath: "assets/images/Violin.jpg",
      audioPath: "audio/Violin music.mp3",
    ),
    Song(
      songName: "Violin Interrupted",
      artisName: "ortensialily",
      albuArtImagePath: "assets/images/Violin 2.jpg",
      audioPath: "audio/violin-interrupted.mp3",
    ),
  ];

  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Initially not playing
  bool _isPlaying = false;

  // Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  // Play a song
  void play() async {
    if (_currentSongIndex == null) return;

    final String path = _playlist[_currentSongIndex!].audioPath;

    // Stop current playback if playing
    await _audioPlayer.stop();

    // Play new song
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // Pause the current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume playback
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Toggle between pause and resume
  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // Seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play the next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      currentSongIndex =
          (_currentSongIndex! + 1) % _playlist.length; // Loop back to start
    }
  }

  // Play the previous song
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      currentSongIndex =
          (_currentSongIndex! - 1 + _playlist.length) % _playlist.length;
    }
  }

  // Listen to duration changes
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (_totalDuration != newDuration) {
        _totalDuration = newDuration;
        notifyListeners();
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (_currentDuration != newPosition) {
        _currentDuration = newPosition;
        notifyListeners();
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      playNextSong();
    });
  }

  // Release audio resources
  void releaseAudioPlayer() async {
    await _audioPlayer.stop();
    await _audioPlayer.release();
  }

  // Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    if (newIndex != null && newIndex != _currentSongIndex) {
      _currentSongIndex = newIndex;
      play();
    }
    notifyListeners();
  }
}
