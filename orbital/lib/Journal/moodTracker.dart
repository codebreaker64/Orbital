import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orbital/Journal/Journal.dart';
import 'package:orbital/pages/LoginPage.dart';
import 'package:orbital/Journal/journalentry.dart';
import 'package:table_calendar/table_calendar.dart';

class Moodtracker extends StatelessWidget {
  final controller;
  final VoidCallback onSave;

  const Moodtracker(
      {super.key, required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text("How are you feeling today?")),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Image.asset(
              "images/happy.png",
              width: 50,
              height: 150,
            ),
            Image.asset(
              "images/angry.png",
              width: 50,
              height: 150,
            ),
            Image.asset(
              "images/sad.png",
              width: 50,
              height: 150,
            ),
            Image.asset(
              "images/disappointed.png",
              width: 50,
              height: 150,
            )
          ]),
          Text("Jot down your thoughts"),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 350, // Set the width of the TextField
                  height: 200, //
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.grey, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                      ),
                      hintText: 'write down your thoughts',
                    ),
                    maxLines: 5,
                  ))),
          ElevatedButton(
            onPressed: onSave,
            child: Text('Save'),
          ),
        ])));
  }
}
