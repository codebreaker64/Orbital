import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BreathingApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreathingHomePage3(),
    );
  }
}

class BreathingHomePage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting the breath'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
              child: Column(
                children: [
                  Image.asset('images/counting.jpg'),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Counting the breath is another good exercise.\n',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          'images/wobreathe.jpeg',
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          '1. Sit in a comfortable position with your back straight. Close your eyes and take a few deep breaths in and out breathe naturally.\n',
                          style: GoogleFonts.openSans(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '2. Now, as you inhale, mentally count to one and slowly exhale.\n',
                          style: GoogleFonts.openSans(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '3. Inhale again, counting to two, and slowly exhale.\n',
                          style: GoogleFonts.openSans(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '4. Repeat this cycle as long as you feel like doing it, counting as you go.',
                          style: GoogleFonts.openSans(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
