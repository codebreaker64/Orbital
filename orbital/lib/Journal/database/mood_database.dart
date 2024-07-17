import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbital/Journal/data.dart';

final _myBox = Hive.box("moodDatabase");

class MoodDatabase {
  List moodList = [];
  List defaultValue = [];

  //create initial default data
  void createDefaultData() {
    moodList = [];
    defaultValue = [];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load data if it already exist
  void loadData() {
    // If it's a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      moodList = _myBox.get("CURRENT_HABIT_LIST", defaultValue: []);
    } else {
      // If it's not a new day, load today's list
      moodList = _myBox.get(todaysDateFormatted(), defaultValue: []);
    }
  }

  //update database
  void updateDatabase() {
    //update todays entry
    _myBox.put(todaysDateFormatted(), moodList);
    //update universal habit List in case it changed (new habit, edit habit, delete habit)
    _myBox.put("CURRENT_HABIT_LIST", moodList);
  }
}
