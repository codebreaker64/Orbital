import 'package:flutter/material.dart';

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(), // Changed from HomePage() to DashboardPage()
    );
  }
}

class DashboardPage extends StatelessWidget {
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
