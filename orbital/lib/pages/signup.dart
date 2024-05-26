import 'package:flutter/material.dart';
import 'package:orbital/main.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when not needed to free up resources
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
              // Logo or image
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "images/lady.jpg",
                  width: 300,
                  height: 200,
                ),
              ),
              // Title text
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // Name input field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
              // Email input field
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
              // Password input field
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
              // Confirm password input field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
              // Forget password text button
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 170),
                child: Align(
                  child: TextButton(
                    onPressed: () {
                      // Handle forget password logic
                    },
                    child: Text(
                      'Forget your password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              // Signup button
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
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF20795E),
                    fixedSize: Size(200, 50),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // Navigate to login page
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    // Handle login logic
                  },
                  child: Text('Already have an account? Sign in'),
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

// Placeholder for another page
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
