import 'package:flutter/material.dart';
import "package:hive_flutter/adapters.dart";
import 'package:orbital/music/music.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/dashboard.dart';
import 'package:orbital/pages/forgot_password.dart';
import 'package:orbital/pages/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import "pages/update_password.dart";
import 'package:orbital/pages/LoginPage.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';

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
          path: '/music-library',
          builder: (context, state) => musicApp(),
        ),
        GoRoute(
          path: '/companion',
          builder: (context, state) => Companion(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => Signup(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => ForgotPassword(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => Dashboard(),
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
