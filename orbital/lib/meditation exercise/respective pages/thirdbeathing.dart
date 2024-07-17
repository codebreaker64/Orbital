import 'package:flutter/material.dart';

class BreathingApp3 extends StatelessWidget {
  const BreathingApp3({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BreathingHomePage3(),
    );
  }
}

class BreathingHomePage3 extends StatelessWidget {
  const BreathingHomePage3({super.key});
  // Corrected class name and syntax
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counting the breath'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.asset('images/counting.jpg'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Counting the breath is another good exercise.\n'),
                Image.asset(width: 200, height: 200, 'images/wobreathe.jpeg'),
                const Text(
                  '1. Sit in a comfortable position with your back straight. Qclose your eyes and take a few deep breaths in and out breathe naturally.\n',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '2. Now, as you inhale, mentally count to one and slowly exhale.\n',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '3. Inhale again, counting to two, and slowly exhale.\n',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const Text(
                    '4. Repeat this cycle as long as you feel like doing it, counting as you go.',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
