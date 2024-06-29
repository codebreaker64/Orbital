import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:orbital/pages/LoginPage.dart';

// MockSupabaseClient to mock SupabaseClient
class MockSupabaseClient extends Mock implements SupabaseClient {
  @override
  GoTrueClient get auth =>
      MockGoTrueClient(); // Ensure auth returns MockGoTrueClient
}

// MockGoTrueClient to mock GoTrueClient
class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  group('LoginPage Tests', () {
    late MockSupabaseClient mockClient;
    late MockGoTrueClient mockAuth;

    setUp(() {
      mockClient = MockSupabaseClient();
      mockAuth = MockGoTrueClient();
      when(mockClient.auth).thenReturn(mockAuth);
    });

    testWidgets('Login button triggers login process',
        (WidgetTester tester) async {
      // Arrange
      when(mockClient.auth.signInWithPassword(
        email: 'j@gmail.com',
        password: 'laosai1234', // Ensure password is not null
      )).thenAnswer((_) async => AuthResponse(
            session: Session(
              accessToken: 'access_token',
              tokenType: 'token_type',
              user: User(
                id: 'id',
                appMetadata: {},
                userMetadata: {},
                aud: 'aud',
                createdAt: DateTime.now().toIso8601String(),
              ),
            ),
            user: User(
              id: 'id',
              appMetadata: {},
              userMetadata: {},
              aud: 'aud',
              createdAt: DateTime.now().toIso8601String(),
            ),
          ));

      // Build the LoginPage widget
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      // Enter email and password
      await tester.enterText(find.byType(TextField).first, 'j@gmail.com');
      await tester.enterText(find.byType(TextField).last, 'laosai1234');

      // Tap the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Rebuild the widget with the new state

      // Verify that the login process was triggered
      verify(mockAuth.signInWithPassword(
        email: 'j@gmail.com',
        password: 'laosai1234',
      )).called(
          1); // Ensure the method was called exactly once with the expected arguments
    });
  });
}
