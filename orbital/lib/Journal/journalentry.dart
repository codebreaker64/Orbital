import 'package:flutter/material.dart';
import 'package:orbital/Journal/Journal.dart';
import 'package:orbital/Journal/moodtile.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:orbital/Journal/moodTracker.dart';
import 'package:table_calendar/table_calendar.dart';

class Journalentry extends StatefulWidget {
  const Journalentry({super.key});

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journalentry> {
  List moodList = [];
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  final _newMoodController = TextEditingController();

  void createNewMood() {
    showDialog(
      context: context,
      builder: (context) {
        return Moodtracker(
          controller: _newMoodController,
          onSave: saveNewName,
        );
      },
    );
  }

  void saveNewName() {
    setState(() {
      moodList.add([_newMoodController.text]);
    });
    _newMoodController.clear();
    Navigator.of(context).pop(); // Close the dialog after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: moodList.length,
        itemBuilder: (context, index) {
          return Moodtile(moodNote: moodList[index][0]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewMood,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
