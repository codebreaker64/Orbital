//import "dart:nativewrappers/_internal/vm/lib/ffi_patch.dart";

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import "pages/forgot_password.dart";
import "pages/password_updated.dart";
import "pages/update_password.dart";
import "pages/signup.dart";

const supabaseUrl = 'https://nwoibzvklxvfxhwlxloa.supabase.co';
const supabaseKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53b2lienZrbHh2Znhod2x4bG9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYyODU2NzEsImV4cCI6MjAzMTg2MTY3MX0.54GwJDi18MkMhvitOQY7sgvPfl-_QR6hSCqnK9EtkNU');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Peacepal',
                      style: TextStyle(
                        fontSize: 30, // Font size
                        fontWeight: FontWeight.bold, // Bold font
                        color: Color.fromARGB(255, 0, 0, 0), // Text color
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      "images/peacepal_logo.jpeg",
                      width: 150,
                      height: 150,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 20, // Font size
                        fontWeight: FontWeight.bold, // Bold font
                        color: Color.fromARGB(255, 0, 0, 0), // Text color
                      ),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your UserName',
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your password',
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 168),
                  child:
                      Text(textAlign: TextAlign.left, 'Forget your password?'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 253, 253, 253),
                      backgroundColor: Color.fromARGB(255, 32, 121, 94),
                      fixedSize: Size(200, 50), // Text color // Button padding
                      textStyle: TextStyle(fontSize: 20), // Text style
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Dont have an account? Sign up',
                    )),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFABEDE2));
  }
}
