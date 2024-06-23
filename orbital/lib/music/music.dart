import 'package:flutter/material.dart';
import 'package:orbital/music/musictile.dart';
// Import your musictile widget

class musicApp extends StatefulWidget {
  @override
  State<musicApp> createState() => _musicAppState();
}

class _musicAppState extends State<musicApp> {
  List musicList = [
    {
      'title': "Tech House Vibes",
      'singer': "Alejandro Mangana",
      'url': "https://assets.mixkit.co/music/preview/mixkit-summer-fun-13.mp3",
      'coverUrl':
          'images/midsummer.jpg', // Ensure this path is correct in pubspec.yaml
    },
    {
      'title': "Feeling Happy",
      'singer': "Ahjay Stelino",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-feeling-happy-5.mp3",
      'coverUrl':
          'images/smile.jpeg', // Ensure this path is correct in pubspec.yaml
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayList'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) => musictile(
                title: musicList[index]['title'],
                singer: musicList[index]['singer'],
                cover: musicList[index]
                    ['coverUrl'], // Pass the coverUrl as asset path
              ),
            ),
          ),
          Container(), // Optional: Add any additional widgets below the ListView
        ],
      ),
    );
  }
}
