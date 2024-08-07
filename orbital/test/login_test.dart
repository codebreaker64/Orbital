import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:orbital/pages/login.dart'; // Replace with the actual import path

// Custom mock classes
class MockGoRouter extends Mock implements GoRouter {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late MockGoRouter mockGoRouter;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  setUp(() {
    mockGoRouter = MockGoRouter();
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    
    // Mock the auth property of SupabaseClient
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    
    // Register the go method for the MockGoRouter
    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: LoginPage(supabaseClient: mockSupabaseClient),
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

     // Mock successful login
    when(() => mockGoTrueClient.signInWithPassword(
      email: 'test@gmail.com',
      password: 'password123',
    )).thenAnswer((_) async => AuthResponse(
      session: Session(
        accessToken: 'fake_token',
        tokenType: 'bearer',
        user: User(
          id: 'user_id',
          email: 'test@gmail.com',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toString(),
        ),
      ),
    ));

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    
    // Verify that we navigated to the main page
    verify(() => mockGoRouter.go('/main')).called(1);

     // Mock failed login
    when(() => mockGoTrueClient.signInWithPassword(
      email: 'test@gmail.com',
      password: 'wrong_password',
    )).thenAnswer((_) async => AuthResponse());

    // Enter wrong password
    await tester.enterText(find.widgetWithText(TextField, 'Enter Your password'), 'wrong_password');

    // Tap the login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the error SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Login failed. Please check your credentials.'), findsOneWidget);
  });
}




