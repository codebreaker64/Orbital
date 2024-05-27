import 'package:flutter/material.dart';


class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'), // Changed the app bar title
      ),
      body: Center(
        child: Text(
          'Welcome to the Dashboard!', // Changed the body text
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
