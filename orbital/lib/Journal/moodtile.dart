import 'package:flutter/material.dart';
import 'package:orbital/Journal/Journal.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:orbital/Journal/moodTracker.dart';
import 'package:table_calendar/table_calendar.dart';

class Moodtile extends StatelessWidget {
  final String moodNote;
  const Moodtile({super.key, required this.moodNote});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              Text(moodNote),
            ])));
  }
}
