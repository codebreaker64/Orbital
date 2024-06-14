import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:orbital/Journal/database/moodDatabase.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:table_calendar/table_calendar.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  MoodDatabase db = MoodDatabase();
  final _myBox = Hive.box("moodDatabase");
  DateTime today = DateTime.now();

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(today, day);
              },
              onDaySelected: _onDaySelected,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
