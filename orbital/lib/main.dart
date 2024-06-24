import 'package:flutter/material.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'pages/LoginPage.dart';
import 'pages/update_password.dart';

const supabaseUrl = 'https://nwoibzvklxvfxhwlxloa.supabase.co';
const supabaseKey =
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53b2lienZrbHh2Znhod2x4bG9hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYyODU2NzEsImV4cCI6MjAzMTg2MTY3MX0.54GwJDi18MkMhvitOQY7sgvPfl-_QR6hSCqnK9EtkNU';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(MyApp());
}

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
          builder: (context, state) => Dashboard(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
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
