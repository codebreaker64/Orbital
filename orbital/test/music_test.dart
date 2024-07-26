import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbital/music/music.dart';

void main() {
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
    expect(find.byIcon(Icons.play_arrow),
        findsNWidgets(1)); // Initial state should show the play icon

    // Tap on the play button
    await tester.tap(find.byIcon(Icons.play_arrow).first); //search by finding icon!
    await tester.pump();

    // Verify the play button has changed to a pause button indicating isPlaying is true
    expect(find.byIcon(Icons.pause), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsNothing);
    expect(find.text('Chill bro'), findsOneWidget); //check if the selected music is playing 
    expect(find.text('Hovey Benjamin'), findsOneWidget);
  });
}
