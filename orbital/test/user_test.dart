import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase/supabase.dart';
import 'package:mockito/mockito.dart';
import 'package:orbital/pages/LoginPage.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  group('LoginPage Tests with FakeSupabase', () {
    testWidgets('Login button triggers login process - success', (WidgetTester tester) async {
      final mockSupabaseClient = MockSupabaseClient();
      final mockAuth = MockGoTrueClient();
      when(mockSupabaseClient.auth).thenReturn(mockAuth);

      when(mockAuth.signInWithPassword(email: 'test@gmail.com', password: 'password'))
          .thenAnswer((_) async => AuthResponse(
                session: Session(accessToken: '', tokenType: '', user: User(id: 'id', appMetadata: {}, userMetadata: {}, aud: 'aud', createdAt: DateTime.now().toIso8601String())),
                user: User(id: 'id', appMetadata: {}, userMetadata: {}, aud: 'aud', createdAt: DateTime.now().toIso8601String()),
              ));

      // Build the LoginPage widget with the mock SupabaseClient
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(supabaseClient: mockSupabaseClient),
      ));

      // Enter email and password
      await tester.enterText(find.byType(TextField).first, 'test@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild the widget with the new state

      // Verify that the login was successful
      expect(find.text('Login successful'), findsOneWidget);
      verify(mockAuth.signInWithPassword(email: 'test@gmail.com', password: 'password')).called(1);
    });

    testWidgets('Login button triggers login process - failure', (WidgetTester tester) async {
      final mockSupabaseClient = MockSupabaseClient();
      final mockAuth = MockGoTrueClient();
      when(mockSupabaseClient.auth).thenReturn(mockAuth);

      when(mockAuth.signInWithPassword(email: 'wrong@gmail.com', password: 'wrongpassword'))
          .thenAnswer((_) async => AuthResponse());

      // Build the LoginPage widget with the mock SupabaseClient
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(supabaseClient: mockSupabaseClient),
      ));

      // Enter email and password
      await tester.enterText(find.byType(TextField).first, 'wrong@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'wrongpassword');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild the widget with the new state

      // Verify that the login failed
      expect(find.text('Login failed. Please check your credentials.'), findsOneWidget);
      verify(mockAuth.signInWithPassword(email: 'wrong@gmail.com', password: 'wrongpassword')).called(1);
    });
  });
}


