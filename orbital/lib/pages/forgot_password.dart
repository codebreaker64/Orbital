import 'package:flutter/material.dart';
import 'package:orbital/pages/update_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 90),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset("images/forgot_password_logo.png"),
            ),
          ),
          Text("Forgot Password?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
          Text("Type your email to reset your password.",
              style: TextStyle(fontSize: 15)),
          Center(
            child: Container(
              width: 300,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  await supabase.auth.resetPasswordForEmail(
                    emailController.text.trim(),
                    redirectTo: "io.supabase.flutterquickstart://login-callback/update-password");
                  Navigator.pushNamed(context, '/update-password');
                }
              },
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    ));
  }
}
