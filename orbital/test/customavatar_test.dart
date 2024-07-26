import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:orbital/pages/custom_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    // Set up a mock for SharedPreferences
    SharedPreferences.setMockInitialValues({});
    
    Get.put(FluttermojiController());
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
}
