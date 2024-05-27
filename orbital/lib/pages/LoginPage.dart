import 'package:flutter/material.dart';
import 'package:orbital/pages/dashboard.dart';
import 'package:orbital/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup.dart'; // Ensure you have the signup page
// Ensure you have a home page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.session != null) {
        // Sign-in successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DashboardApp()), // Navigate to HomePage after login
        );
      } else {
        // Sign-in failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed. Please check your credentials.')),
        );
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "images/peacepal_logo.jpeg",
                  width: 150,
                  height: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 168),
                child: Text(
                  'Forget your password?',
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 253, 253, 253),
                    backgroundColor: Color.fromARGB(255, 32, 121, 94),
                    fixedSize: Size(200, 50),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text("Don't have an account? Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFABEDE2),
    );
  }
}
