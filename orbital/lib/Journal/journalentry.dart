import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:orbital/Journal/database/mood_database.dart';
import 'package:orbital/Journal/moodtile.dart';
import 'package:orbital/Journal/mood_tracker.dart';

class Journalentry extends StatefulWidget {
  const Journalentry({super.key});

  @override
  State<Journalentry> createState() => _JournalState();

  void createNewMood() {}
}

class _JournalState extends State<Journalentry> {
  DateTime today = DateTime.now();
  MoodDatabase db = MoodDatabase();
  final _myBox = Hive.box("moodDatabase");

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  final _newMoodController = TextEditingController();
  final _moodController = TextEditingController();
  final _dateController = TextEditingController();

  void createNewMood() {
    showDialog(
      context: context,
      builder: (context) {
        return Moodtracker(
            key: const Key('addMood'),
            controller: _newMoodController,
            onSave: saveNewName,
            onCancel: cancelName,
            moodController: _moodController,
            dateController: _dateController);
      },
    );
  }

  void saveNewName() {
    setState(() {
      db.moodList.add([
        _newMoodController.text,
        _moodController.text,
        _dateController.text
      ]);
    });
    _newMoodController.clear();
    _moodController.clear();
    _dateController.clear();
    Navigator.of(context).pop(); // Close the dialog after saving
    db.updateDatabase();
  }

  void cancelName() {
    _newMoodController.clear();
    _moodController.clear();
    _dateController.clear();
    Navigator.of(context).pop();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.moodList[index][0] = _newMoodController.text;
      db.moodList[index][1] = _moodController.text;
      db.moodList[index][2] = _dateController.text;
    });
    _newMoodController.clear();
    _moodController.clear();
    _dateController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  //Editing the mood setting:
  void openHabitSettings(int index) {
    setState(() {
      _newMoodController.text = db.moodList[index][0];
      _moodController.text = db.moodList[index][1];
      _dateController.text = db.moodList[index][2];
    });
    showDialog(
      context: context,
      builder: (context) {
        return Moodtracker(
          controller: _newMoodController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelName,
          moodController: _moodController,
          dateController: _dateController,
        );
      },
    );
  }

  void delete(int index) {
    setState(() {
      db.moodList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Journal Page')),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: db.moodList.length,
        itemBuilder: (context, index) {
          return Moodtile(
            moodNote: db.moodList[index][0],
            moodWise: db.moodList[index][1],
            date: db.moodList[index][2],
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => delete(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewMood,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
