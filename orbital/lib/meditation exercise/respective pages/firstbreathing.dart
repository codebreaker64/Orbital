import 'package:flutter/material.dart';

class BreathingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedEx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreathingHomePage(),
    );
  }
}

class BreathingHomePage extends StatelessWidget {
  // Corrected class name and syntax
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bellow breath'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.asset('images/shallow.jpg'),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                      'The stimulating breath or bellows breath is a great way to boost your energy. This type of breathing practice is often done in yoga to help increase Prana, or life force energy.\n\n'
                      'The stimulating breath can help you increase your energy and help you be more alert. The bellows breath is a safe practice, but it could make you dizzy initially until your body gets used to the increased energy.\n\n'
                      'Strive for no more than 15 seconds or so on your first try, working up to a minute. Each time you practice this breath, you can increase your time little by little.\n'),
                  Image.asset(width: 200, height: 200, 'images/shoulder.png'),
                  const Text(
                      '1. Sit up tall with your back straight and relax your shoulders.\n'),
                  Image.asset(width: 200, height: 200, 'images/nose.jpg'),
                  const Text(
                      '2. Begin inhaling and exhaling rapidly through your nose. Keep your mouth closed but relaxed. The in and out breaths should be equal in duration, but as short and quick as possible. The bellows breath is a noisy breathing exercise.\n'),
                  Image.asset(width: 200, height: 200, 'images/cycle.png'),
                  const Text('3. Try for three complete breath cycles per second.'),
                  const Text(
                    '\n\n As you breathe, you will notice a quick movement of the diaphragm, like a bellows.\n'
                    '\n This technique should leave you feeling invigorated and alert.',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
