import 'package:flutter/material.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:orbital/meditation%20exercise/medex.dart';
import 'package:orbital/music/music.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/custom_avatar.dart';
import 'package:orbital/pages/forgot_password.dart';
import 'package:orbital/pages/password_updated.dart';
import 'package:orbital/pages/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:orbital/pages/login.dart';
import 'package:orbital/Journal/journalentry.dart';
import 'package:orbital/pages/update_password.dart';
import 'package:orbital/pages/dashboard.dart';
import 'package:get/get.dart';
import 'package:fluttermoji/fluttermoji.dart';

const supabaseUrl = 'https://nwoibzvklxvfxhwlxloa.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53b2lienZrbHh2Znhod2x4bG9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYyODU2NzEsImV4cCI6MjAzMTg2MTY3MX0.54GwJDi18MkMhvitOQY7sgvPfl-_QR6hSCqnK9EtkNU';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive box
  await Hive.openBox("moodDatabase");

  // Initialize Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // Initialize Fluttermoji controller
  Get.put(FluttermojiController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/password-updated',
          builder: (context, state) => const PasswordUpdated()
        ),
        GoRoute(
          path: '/custom-avatar',
          builder: (context, state) => const CustomAvatar()
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const Signup(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const Dashboard(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPassword(),
        ),
        GoRoute(
          path: '/companion',
          builder: (context, state) => const Companion(),
        ),
        GoRoute(
          path: '/update-password',
          builder: (context, state) => const UpdatePassword(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => LoginPage(supabaseClient: Supabase.instance.client),
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) => const Main(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Color(0xFFABEDE2)),
        scaffoldBackgroundColor: const Color(0xFFABEDE2),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF20795E),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),
    const Medex(),
    const Companion(),
    const MusicApp(),
    const Journalentry(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_support), label: 'Meditation'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Companion'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: 'Music'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Journal'),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        backgroundColor: const Color(0xFFABEDE2),
        selectedItemColor: const Color(0xFF20795E),
        unselectedItemColor: const Color(0xFF000000),
        onTap: _onItemTapped,
      ),
    );
  }
}
