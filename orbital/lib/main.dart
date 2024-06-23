import 'package:flutter/material.dart';
import "package:hive/hive.dart";
import "package:hive_flutter/adapters.dart";
import "package:orbital/pages/forgot_password.dart";
import 'package:orbital/Journal/journalentry.dart';
import "package:orbital/Journal/moodTracker.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
import "pages/LoginPage.dart";
import "pages/update_password.dart";

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
          path: '/update-password',
          builder: (context, state) => UpdatePassword(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => Journalentry(),
        ),
      ],
    );

    return MaterialApp.router(
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFABEDE2),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF20795E),
                  foregroundColor: Colors.white))),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/update-password': (context) => UpdatePassword(),
        '/login': (context) => LoginPage()
      },
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFABEDE2),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF20795E),
                  foregroundColor: Colors.white))),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/update-password': (context) => UpdatePassword(),
        '/login': (context) => LoginPage()
      },
    );
  }
}
