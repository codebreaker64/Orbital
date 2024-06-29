import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                context.go('/');
              },
              child: const Text('Return to Login')),
            Image.asset('images/password_updated.png'),
          ],
        ),
      ),
    );
  }
}