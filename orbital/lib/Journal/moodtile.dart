import 'package:flutter/material.dart'; // Import this for Slidable
import 'package:orbital/Journal/Journal.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:orbital/Journal/moodTracker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Moodtile extends StatelessWidget {
  final String moodNote;

  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  const Moodtile(
      {super.key,
      required this.moodNote,
      required this.deleteTapped,
      required this.settingsTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Slidable(
          // Specify a key if the Slidable is dismissible.

          // The start action pane is the one at the left or the top side.
          endActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: settingsTapped,
                backgroundColor: Color.fromARGB(255, 9, 9, 9),
                foregroundColor: Colors.white,
                icon: Icons.settings,
              ),
              SlidableAction(
                onPressed: deleteTapped,
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(moodNote),
              ],
            ),
          ),
        ));
  }
}
