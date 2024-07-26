import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase/supabase.dart';
import 'package:orbital/pages/login.dart'; // Replace with the actual import path

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockGoRouter mockGoRouter;
  late FakeSupabase fakeSupabase;

  setUp(() {
    mockGoRouter = MockGoRouter();
    fakeSupabase = FakeSupabase();

    // Register the go method for the MockGoRouter
    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: LoginPage(supabaseClient: fakeSupabase),
        ),
      ),
    );

    // Verify that the login page widgets are present
    expect(find.text('Peacepal'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Enter email and password
    await tester.enterText(find.widgetWithText(TextField, 'Enter Your Email'), 'test@gmail.com');
    await tester.enterText(find.widgetWithText(TextField, 'Enter Your password'), 'password123');

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that we navigated to the main page
    verify(() => mockGoRouter.go('/main')).called(1);

    // Simulate failed login by changing the credentials
    await tester.enterText(find.widgetWithText(TextField, 'Enter Your password'), 'wrong_password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the error SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Login failed. Please check your credentials.'), findsOneWidget);
  });
}

// Fake Supabase implementation
class FakeSupabase extends Fake implements SupabaseClient {
  @override
  GoTrueClient get auth => FakeGotrue();
}

class FakeGotrue extends Fake implements GoTrueClient {
  final _user = User(
    id: 'id',
    email: 'test@gmail.com',
    appMetadata: {},
    userMetadata: {},
    aud: 'aud',
    createdAt: DateTime.now().toIso8601String(),
  );

  @override
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
    String? phone,
    String? captchaToken,
  }) async {
    if (password == 'password123') {
      return AuthResponse(
        session: Session(
          accessToken: 'fake_token',
          tokenType: 'bearer',
          user: _user,
        ),
        user: _user,
      );
    } else {
      return AuthResponse(); // Simulate failed login
    }
  }
}




