import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counting the breath'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                  Color.fromARGB(255, 126, 189, 240),
                  Color.fromARGB(255, 153, 208, 155)
                  ],
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
                          'Counting the breath exercise, also known as "breath counting," is a simple yet effective mindfulness technique that can help improve focus, reduce stress, and promote relaxation.\n',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Steps:',
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
