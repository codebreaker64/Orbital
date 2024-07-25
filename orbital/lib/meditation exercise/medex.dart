import 'package:flutter/material.dart';
import 'package:orbital/meditation%20exercise/respective%20pages/firstbreathing.dart';
import 'package:orbital/meditation%20exercise/respective%20pages/secondbreathing.dart';
import 'package:orbital/meditation%20exercise/respective%20pages/thirdbeathing.dart';
import 'package:orbital/pages/dashboard.dart';

class Medex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Meditation Exercises"),
        ),
        leading: null,
      ),
      body: Column(
        children: [
          Image.asset("images/meditationCover.jpg"),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  left: 30.0,
                  child: Text(
                    "Meditation Exercises",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 30.0,
                  width: 100,
                  height: 70.0,
                  child: Image.asset(
                    'images/breathing1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 150,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BreathingHomePage()),
                      );
                    },
                    child: Text(
                      '1. The stimulating breath \n(Bellows breath) ',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 150.0,
                  left: 30.0,
                  width: 100,
                  height: 70.0,
                  child: Image.asset(
                    'images/breathing2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 150,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BreathingHomePage1()),
                      );
                    },
                    child: Text(
                      '2. Relaxing breathing \n(4-7-8) exercise',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 250.0,
                  left: 30.0,
                  width: 100,
                  height: 70.0,
                  child: Image.asset(
                    'images/breathing3.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 240,
                  left: 150,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BreathingHomePage3()),
                      );
                    },
                    child: Text(
                      '3. Counting the breath',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
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
