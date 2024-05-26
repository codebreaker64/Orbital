//import "dart:nativewrappers/_internal/vm/lib/ffi_patch.dart";

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widget_tree.dart';

import "pages/dashboard.dart";
import "pages/forgot_password.dart";
import "pages/password_updated.dart";
import "pages/update_password.dart";
import "pages/signup.dart";



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFFABEDE2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF20795E),
            foregroundColor: Colors.white
          )
        )
      ),
      home: Scaffold(
        body: const Dashboard(),
      ),
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
