import 'package:flutter/material.dart';
import "package:hive_flutter/adapters.dart";
import 'package:orbital/music/music.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/forgot_password.dart';
import 'package:orbital/pages/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'pages/LoginPage.dart';
import 'pages/update_password.dart';
import 'pages/dashboard.dart';

const supabaseUrl = 'https://nwoibzvklxvfxhwlxloa.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53b2lienZrbHh2Znhod2x4bG9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYyODU2NzEsImV4cCI6MjAzMTg2MTY3MX0.54GwJDi18MkMhvitOQY7sgvPfl-_QR6hSCqnK9EtkNU';

// Function to clear all Hive boxes
Future<void> main() async {
  //initialize hive
  await Hive.initFlutter();

  //opening up a box:
  await Hive.openBox("moodDatabase");

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  Get.put(FluttermojiController());
  runApp(MyApp());
}

// Iterate over each box and clear it
// Function to delete all Hive boxes from disk

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/signup',
          builder: (context, state) => Signup(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => Dashboard(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => ForgotPassword(),
        ),
        GoRoute(
          path: '/companion',
          builder: (context, state) => Companion(),
        ),
        GoRoute(
          path: '/update-password',
          builder: (context, state) => UpdatePassword(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => LoginPage(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: Color(0xFFABEDE2)
        ),
        scaffoldBackgroundColor: Color(0xFFABEDE2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF20795E),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  //default index of 0
  int _selectedIndex = 0;
  //laying out all the icons in the nav bar
  final List<Widget> _pages = [
    Dashboard(),
    Text('test'),
    Companion(),
    musicApp(),
    Journalentry()
  ];

  //ontap action.
  void _onItemTapped(int index) {
    setState(() {
        _selectedIndex = index;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.contact_support), label: 'Mediatation'),
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Companion'),
            BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Music'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Journal')
          ],
          //looking at curretindex and selected index.
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          backgroundColor: Color(0xFFABEDE2),
          selectedItemColor: Color(0xFF20795E),
          unselectedItemColor: Color(0xFF000000),

          ///onItemtapped item.
          onTap: _onItemTapped
          ),
    );
  }
}