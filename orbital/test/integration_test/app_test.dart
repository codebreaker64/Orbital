import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:orbital/Journal/mood_tracker.dart';
import 'package:orbital/music/music.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:orbital/pages/login.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:orbital/pages/custom_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/chatcontroller.dart';

// Custom mock classes
class MockGoRouter extends Mock implements GoRouter {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class TestChatController extends ChatController {
  @override
  Future<void> sendMessage(String message) async {
    messages.add(ChatMessage(sender: 'You', message: message));
    // Simulate a delay for the "API call"
    await Future.delayed(const Duration(milliseconds: 500));
    messages.add(ChatMessage(sender: 'neil', message: 'This is a test response'));
    textController.clear();
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockGoRouter mockGoRouter;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  setUp(() {
    mockGoRouter = MockGoRouter();
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    
    SharedPreferences.setMockInitialValues({});
    
    Get.put(FluttermojiController());

    // Mock the auth property of SupabaseClient
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    
    // Register the go method for the MockGoRouter
    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  group('end-to-end test', () {
    testWidgets('MusicApp widget test', (WidgetTester tester) async {
      // Build the MusicApp widget
      await tester.pumpWidget(
        const MaterialApp(
          home: MusicApp(),
        ),
      );

      // Verify the initial state of the widget
      expect(find.text('Chill bro'), findsOneWidget);
      expect(find.text('Hovey Benjamin'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNWidgets(1)); // Initial state should show the play icon

      // Tap on the play button
      await tester.tap(find.byIcon(Icons.play_arrow).first);
      await tester.pump();

      // Verify the play button has changed to a pause button indicating isPlaying is true
      expect(find.byIcon(Icons.pause), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsNothing);
      expect(find.text('Chill bro'), findsOneWidget); // Check if the selected music is playing
      expect(find.text('Hovey Benjamin'), findsOneWidget);

      // Ensure proper disposal of the widget tree
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Moodtracker widget test', (WidgetTester tester) async {
      // Define the necessary controllers
      final TextEditingController controller = TextEditingController();
      final TextEditingController moodController = TextEditingController();
      final TextEditingController dateController = TextEditingController();

      // Define the necessary callbacks
      void onSave() {}
      void onCancel() {}

      // Build the Moodtracker widget
      await tester.pumpWidget(
        MaterialApp(
          home: Moodtracker(
            controller: controller,
            moodController: moodController,
            dateController: dateController,
            onSave: onSave,
            onCancel: onCancel,
          ),
        ),
      );

      // Verify the initial state of the widget
      expect(find.text('How are you feeling today?'), findsOneWidget);
      expect(find.text('Select your mood above'), findsOneWidget);
      expect(find.byKey(const Key('Pick a date')), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Tap on the Happy mood icon and verify the mood is selected
      await tester.tap(find.byKey(const Key('mood_happy')));
      await tester.pump();
      expect(moodController.text, 'Happy');
      expect(find.text('You are feeling Happy'), findsOneWidget);

      // Tap on the Pick a date button and select a date
      await tester.tap(find.byKey(const Key('Pick a date')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('15')); // Select 15th of the month
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(dateController.text, contains('15 - 7 - 2024'));

      // Enter text into the TextField and verify the input
      await tester.enterText(find.byType(TextField), 'This is a test entry.');
      await tester.pump();
      expect(controller.text, 'This is a test entry.');

      // Tap the Save button
      await tester.tap(find.text('Save'));
      await tester.pump();

      // Tap the Cancel button
      await tester.tap(find.byKey(const Key('Cancel')));
      await tester.pump();
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

  testWidgets('Custom Avatar widget test', (WidgetTester tester) async {
    // Build the CustomAvatar widget
    await tester.pumpWidget(
      const GetMaterialApp(
        home: CustomAvatar(),
      ),
    );

    // Verify the FluttermojiCircleAvatar is present
    expect(find.byType(FluttermojiCircleAvatar), findsOneWidget);

    // Verify the 'Customize:' text is present
    expect(find.text('Customize:'), findsOneWidget);

    // Verify the Save button is present
    expect(find.byType(FluttermojiSaveWidget), findsOneWidget);

    // Verify the FluttermojiCustomizer is present
    expect(find.byType(FluttermojiCustomizer), findsOneWidget);

    // Tap the Save button
    await tester.tap(find.byType(FluttermojiSaveWidget));
    await tester.pumpAndSettle(const Duration(seconds: 1));  // Wait for animations and async operations

    // Verify the SnackBar is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Avatar has been saved'), findsOneWidget);
  });

  testWidgets('Companion widget test', (WidgetTester tester) async {
    final testChatController = TestChatController();
    
    await tester.pumpWidget(GetMaterialApp(
      home: GetBuilder<ChatController>(
        init: testChatController,
        builder: (_) => const Companion(),
      ),
    ));

    // Verify that the Companion widget is rendered
    expect(find.byType(Companion), findsOneWidget);

    // Verify that the TextField is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the send button is present
    expect(find.byIcon(Icons.send), findsOneWidget);

    // Enter a message in the TextField
    await tester.enterText(find.byType(TextField), 'Hello, World!');
    await tester.pump(); // Process the TextField input

    // Tap the send button
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump(); // Process the button tap

    // Verify that the user's message was added to the list
    expect(find.text('You:'), findsOneWidget);
    expect(find.text('Hello, World!'), findsOneWidget);

    // Wait for the simulated "API call" to complete
    await tester.pump(const Duration(seconds: 1)); // Adjust this duration if necessary

    // Verify that the companion's response is displayed
    expect(find.text('neil:'), findsOneWidget);
    expect(find.text('This is a test response'), findsOneWidget);

    // Verify that the TextField is cleared after sending a message
    expect(testChatController.textController.text, isEmpty);
  });

  });
}