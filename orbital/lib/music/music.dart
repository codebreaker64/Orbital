import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:orbital/music/musictile.dart';

class MusicApp extends StatefulWidget {
  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List musicList = [
    {
      'title': "Tech House Vibes",
      'singer': "Alejandro Mangana",
      'url': "https://assets.mixkit.co/music/preview/mixkit-summer-fun-13.mp3",
      'coverUrl': 'images/midsummer.jpg',
    },
    {
      'title': "Feeling Happy",
      'singer': "Ahjay Stelino",
      'url': "https://assets.mixkit.co/music/preview/mixkit-feeling-happy-5.mp3",
      'coverUrl': 'images/smile.jpeg',
    },
    {
      'title': "Hazy after hours",
      'singer': "Alejandro Magaña (A. M.)",
      'url': "https://assets.mixkit.co/music/preview/mixkit-hazy-after-hours-132.mp3",
      'coverUrl': 'images/hazy.jpeg',
    },
  ];

  String currentTitle = "";
  String currentCover = "images/default_profile_pic.jpg";
  String currentSinger = "";
  Duration currentPosition = Duration.zero;
  Duration musicDuration = Duration.zero;
  IconData btnIcon = Icons.play_arrow;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong = "";

  String get _positionText => _formatDuration(currentPosition);
  String get _durationText => _formatDuration(musicDuration);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      await audioPlayer.pause();
      await audioPlayer.stop();
      await audioPlayer.play(UrlSource(url));
      setState(() {
        currentSong = url;
        btnIcon = Icons.pause;
        isPlaying = true;
      });
    } else if (!isPlaying) {
      await audioPlayer.play(UrlSource(url));
      setState(() {
        currentSong = url;
        btnIcon = Icons.pause;
        isPlaying = true;
      });
    } else {
      await audioPlayer.pause();
      setState(() {
        btnIcon = Icons.play_arrow;
        isPlaying = false;
      });
    }
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        musicDuration = duration;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Playlist'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) => musictile(
                onTap: () {
                  playMusic((musicList[index]['url']) as String);
                  setState(() {
                    currentTitle = musicList[index]['title'];
                    currentCover = musicList[index]['coverUrl'];
                    currentSinger = musicList[index]['singer'];
                  });
                },
                title: musicList[index]['title'],
                singer: musicList[index]['singer'],
                cover: musicList[index]['coverUrl'],
              ),
            ),
          ),
  
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x55212121),
                  blurRadius: 8.0,
                )
              ],
            ),
            child: Column(
              children: [
                Slider(
                  onChanged: (value) {
                    final duration = musicDuration;
                    if (duration == null) {
                      return;
                    }
                    final position = value * duration.inMilliseconds;
                    audioPlayer.seek(Duration(milliseconds: position.round()));
                  },
                  value: (currentPosition.inMilliseconds > 0 &&
                          currentPosition.inMilliseconds < musicDuration.inMilliseconds)
                      ? currentPosition.inMilliseconds / musicDuration.inMilliseconds
                      : 0.0,
                ),
                Text(
                  currentPosition != null
                      ? '$_positionText / $_durationText'
                      : musicDuration != null
                          ? _durationText
                          : '',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 2.0, bottom: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(currentCover, fit: BoxFit.cover),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentTitle,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            currentSinger,
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16.0),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                            setState(() {
                              btnIcon = Icons.play_arrow;
                              isPlaying = false;
                            });
                          } else {
                            audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = true;
                            });
                          }
                        },
                        iconSize: 42,
                        icon: Icon(btnIcon),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

