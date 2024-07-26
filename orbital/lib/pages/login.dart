import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  const LoginPage({super.key, required this.supabaseClient});

  @override
  State<LoginPage> createState() => _LoginPageState();
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
      final response = await widget.supabaseClient.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );  

      if (response.session != null) {
        // Sign-in successful
        if (mounted) {
          context.go('/main');
        }
      } else {
        // Sign-in failed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              dismissDirection: DismissDirection.horizontal,
              content: Text('Login failed. Please check your credentials.'),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
      // Handle any exceptions
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            dismissDirection: DismissDirection.horizontal,
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
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
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Peacepal',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(80), // Image radius
                  child: Image.asset('images/peacepal_logo.jpeg', fit: BoxFit.cover),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0),
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
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/forgot-password');
                },
                child: const Text("Forgot your password?", style: TextStyle(color: Colors.blue))),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 253, 253, 253),
                    backgroundColor: const Color.fromARGB(255, 32, 121, 94),
                    fixedSize: const Size(200, 50),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {
                    context.push('/signup');
                  },
                  child: const Text("Don't have an account? Sign up"),
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
