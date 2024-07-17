import 'package:flutter/material.dart'; // Import this for Slidable
import 'package:flutter_slidable/flutter_slidable.dart';

class Moodtile extends StatelessWidget {
  final String moodNote;
  final String moodWise;
  final String date;

  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  const Moodtile(
      {super.key,
      required this.moodNote,
      required this.moodWise,
      required this.date,
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
                backgroundColor: const Color.fromARGB(255, 9, 9, 9),
                foregroundColor: Colors.white,
                icon: Icons.settings,
              ),
              SlidableAction(
                onPressed: deleteTapped,
                backgroundColor: const Color(0xFFFE4A49),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (moodWise == "Angry")
                  Image.asset(
                    "images/angry.png",
                    width: 50,
                    height: 50,
                  ),
                if (moodWise == "Sad")
                  Image.asset(
                    "images/sad.png",
                    width: 50,
                    height: 50,
                  ),
                if (moodWise == "Disappointed")
                  Image.asset(
                    "images/disappointed.png",
                    width: 50,
                    height: 50,
                  ),
                if (moodWise == "Happy")
                  Image.asset(
                    "images/happy.png",
                    width: 50,
                    height: 50,
                  ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Date: $date"),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Note: ${moodNote.trim()}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
