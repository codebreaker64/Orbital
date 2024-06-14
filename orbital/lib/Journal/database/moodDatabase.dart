import 'package:hive_flutter/hive_flutter.dart';
import 'package:orbital/Journal/data.dart';

final _myBox = Hive.box("moodDatabase");

class MoodDatabase {
  List moodList = [];

  //create initial default data
  void createDefaultData() {
    moodList = [
      ["gay"],
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load data if it already exist
  void loadData() {
    //iif it's a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      moodList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < moodList.length; i++) {
        //this is just setting every habit completed to false since it's a new day
        moodList[i][1] = false;
      }
    }
    //if it's not a new day, load todays List
    else {
      moodList = _myBox.get(todaysDateFormatted());
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
