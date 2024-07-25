import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize the Supabase client
final supabase = Supabase.instance.client;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  "images/sign_up_logo.png",
                  width: 300,
                  height: 200,
                ),
              ),
              // Title text
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
              // Email input field
              Form(
                key: _formKey,
                child:Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email@domain.com',
                  ),
                  validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|outlook\.com|hotmail\.com)$").hasMatch(value.trim())) {
                    return 'Please enter your gmail/outlook email';
                  }
                  return null;
                  },
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
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
                        const SnackBar(
                          dismissDirection: DismissDirection.horizontal,
                          content: Text('Passwords do not match!'),
                        ),
                      );
                      return;
                    }
          if (_formKey.currentState!.validate()) {
                      try {
                        // Attempt to sign up using Supabase
                        await supabase.auth.signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          data: {
                              'name': nameController.text.trim(),
                            }, 
                          emailRedirectTo: 'io.supabase.flutterquickstart://callback/',
                        );
                        if(context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              dismissDirection: DismissDirection.horizontal,
                              content: Text('Email verification link has been sent. Please verify your email.'),
                            ),
                          ); 
                        }
                      } catch (error) {
                        if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              dismissDirection: DismissDirection.horizontal,
                              content: Text('Error: $error'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF20795E),
                    fixedSize: const Size(200, 50),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Sign up'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    context.push("/");
                  },
                  child: const Text('Already have an account? Sign in'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFABEDE2),
    );
  }
}

// Placeholder for another page
class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: const Center(
        child: Text('Welcome to another page!'),
      ),
    );
  }
}
