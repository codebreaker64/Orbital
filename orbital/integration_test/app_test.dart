import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:orbital/Journal/moodtracker.dart';
import 'package:orbital/music/music.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('MusicApp widget test', (WidgetTester tester) async {
      // Build the MusicApp widget
      await tester.pumpWidget(
        MaterialApp(
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
      expect(find.byKey(Key('Pick a date')), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Tap on the Happy mood icon and verify the mood is selected
      await tester.tap(find.byKey(Key('mood_happy')));
      await tester.pump();
      expect(moodController.text, 'Happy');
      expect(find.text('You are feeling Happy'), findsOneWidget);

      // Tap on the Pick a date button and select a date
      await tester.tap(find.byKey(Key('Pick a date')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('15')); // Select 15th of the month
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(dateController.text, contains('15-'));

      // Enter text into the TextField and verify the input
      await tester.enterText(find.byType(TextField), 'This is a test entry.');
      await tester.pump();
      expect(controller.text, 'This is a test entry.');

      // Tap the Save button
      await tester.tap(find.text('Save'));
      await tester.pump();

      // Tap the Cancel button
      await tester.tap(find.byKey(Key('Cancel')));
      await tester.pump();
    });
  });
}