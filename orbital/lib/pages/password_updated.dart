import 'package:flutter/material.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:orbital/pages/forgot_password.dart';

class PasswordUpdated extends StatelessWidget {
  const PasswordUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have successfully',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            Text(
              'changed your password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            ElevatedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Return to Login')),
            Image.asset('images/password_updated.png'),
          ],
        ),
      ),
    );
  }
}