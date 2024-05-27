import 'package:flutter/material.dart';
import 'package:orbital/main.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "images/lady.jpg",
                  width: 300,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20, // Font size
                    fontWeight: FontWeight.bold, // Bold font
                    color: Color.fromARGB(255, 0, 0, 0), // Text color
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email@domain.com',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  //controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 170),
                child: Align(
                  //alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // Handle forget password logic
                    },
                    child: Text(
                      'Forget your password?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    // Password match validation
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords do not match!'),
                        ),
                      );
                      return;
                    }

                    try {
                      // Attempt to sign up using Supabase
                      final AuthResponse res = await supabase.auth.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      final User? user = res.user;

                      if (user != null) {
                        // Navigate to another page after successful signup
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Signup failed.'),
                          ),
                        );
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                        ),
                      );
                    }
                  },
                  child: Text('Sign up'),
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
                  child: TextButton(
                    onPressed: () {
                      // Handle login logic
                      // Example: Navigate to a different page after login
                    },
                    child: Text(
                      'Dont have an account? Sign up',
                    ),
                  )),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFABEDE2),
    );
  }
}

// Replace AnotherPage with the actual page you want to navigate to
class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('Welcome to another page!'),
      ),
    );
  }
}
