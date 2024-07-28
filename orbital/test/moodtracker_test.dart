import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbital/Journal/mood_tracker.dart';

void main() {
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
    //change to pick a date to directly find the date widget
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
    expect(dateController.text, contains('15-'));

    // Enter text into the TextField and verify the input
    await tester.enterText(find.byType(TextField), 'This is a test entry.');
    expect(controller.text, 'This is a test entry.');

    // Tap the Save button
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Tap the Cancel button
    //change to find by key and see how it loads up 
    await tester.tap(find.byKey(const Key('Cancel')));
    await tester.pump();
  });
}
