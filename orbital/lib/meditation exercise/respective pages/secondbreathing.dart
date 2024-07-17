import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BreathingApp1 extends StatelessWidget {
  const BreathingApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BreathingHomePage1(),
    );
  }
}

class BreathingHomePage1 extends StatelessWidget {
  const BreathingHomePage1({super.key});
  // Corrected class name and syntax
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4-7-8 Breathing'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.asset('images/478.jpg'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                    'Before starting the breathing pattern, adopt a comfortable sitting position and place the tip of the tongue on the tissue right behind the top front teeth.To use the 4-7-8 technique, focus on the following breathing pattern\n'),
                Image.asset(width: 200, height: 200, 'images/wobreathe.jpeg'),
                const Text(
                  '• Breathe in through the nose for 2 seconds',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '• Hold the breath for a count of 3.5 seconds',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Text(
                  '• Exhale through the mouth for 4 seconds',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          const Text(
            '\nAccording to some advocates of 4-7-8 breathing, the longer and more frequently a person uses the technique, the more effective it becomes.\n',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Reference: ',
            style: TextStyle(fontSize: 16.0),
          ),
          InkWell(
            child: const Text(
              'Medical News Today',
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            onTap: () =>
                launchUrl(Uri.parse('https://www.medicalnewstoday.com/articles/324417')),
          )
        ],
      )),
    );
  }
}
