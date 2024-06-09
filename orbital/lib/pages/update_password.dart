import 'package:flutter/material.dart';
import '../pages/password_updated.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});
  
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Update your password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(
                "Enter your new password",
                style: TextStyle(fontSize: 15)),
              Container(
                width: 300,
                child: TextFormField(
                  controller: newController,
                  decoration: const InputDecoration(
                    hintText: 'New Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ), 
              ),
              Container(
                width: 300,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value != newController.text.trim()) {
                      return 'Your password does not match';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      await supabase.auth.updateUser(
                        UserAttributes(
                          password: newController.text.trim(),
                        )
                      );
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => PasswordUpdated())
                      );                       
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}