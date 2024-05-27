import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<void> _signInWithEmailPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "password",
      );
      setState(() {
        _user = userCredential.user;
      });
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
        actions: [
          if (_user != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _signOut,
            )
        ],
      ),
      body: Center(
        child: _user == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You are not signed in.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signInWithEmailPassword,
                    child: Text('Sign In'),
                  ),
                ],
              )
            : StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(_user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('No data found.');
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Signed in as: ${_user!.email}'),
                      SizedBox(height: 20),
                      Text('User Data:'),
                      Text('Name: ${userData['name']}'),
                      Text('Age: ${userData['age']}'),
                    ],
                  );
                },
              ),
      ),
    );
  }
}