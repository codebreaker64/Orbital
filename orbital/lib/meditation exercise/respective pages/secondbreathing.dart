import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('4-7-8 Breathing'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
              child: Column(
                children: [
                  Image.asset('images/478.jpg'),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                            'Before starting the breathing pattern, adopt a comfortable sitting position and place the tip of the tongue on the tissue right behind the top front teeth. To use the 4-7-8 technique, focus on the following breathing pattern\n',
                            style: GoogleFonts.openSans(
                              fontSize: 16.0,
                            )),
                        Image.asset('images/wobreathe.jpeg',
                            width: 200, height: 200),
                        Text(
                          '• Breathe in through the nose for 2 seconds',
                          style: GoogleFonts.racingSansOne(fontSize: 16.0),
                        ),
                        Text(
                          '• Hold the breath for a count of 3.5 seconds',
                          style: GoogleFonts.racingSansOne(fontSize: 16.0),
                        ),
                        Text(
                          '• Exhale through the mouth for 4 seconds',
                          style: GoogleFonts.racingSansOne(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\nAccording to some advocates of 4-7-8 breathing, the longer and more frequently a person uses the technique, the more effective it becomes.\n',
                    style: GoogleFonts.openSans(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
