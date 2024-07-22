import 'package:flutter/material.dart';
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
        body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset("images/forgot_password_logo.png"),
              ),
            ),
            const Text("Forgot Password?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0)),
            const Text("Type your email to reset your password.",
                style: TextStyle(fontSize: 15)),
            Center(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|outlook\.com)$").hasMatch(value)) {
                      return 'Please enter your gmail/outlook email you have used for SignUp';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    try{
                      supabase.auth.resetPasswordForEmail(
                      emailController.text.trim(),
                      redirectTo: "io.supabase.flutterquickstart://callback/update-password");
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password Reset link has been sent. Please click on the link.'),
                          ),
                        );
                    } catch (error) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                        ),
                      );
                    }
                  }
                  return;
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      )
    ));
  }
}
