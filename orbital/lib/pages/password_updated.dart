import 'package:flutter/material.dart';
import 'package:orbital/pages/forgot_password.dart';

class PasswordUpdated extends StatelessWidget {
  const PasswordUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: const Text('Return to Login'))
        ],
      ),
    );
  }
}