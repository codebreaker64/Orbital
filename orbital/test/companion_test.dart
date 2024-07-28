import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:orbital/pages/companion.dart';
import 'package:orbital/pages/chatcontroller.dart';

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
}
