import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Moodtracker extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final TextEditingController moodController;
  final TextEditingController dateController;

  const Moodtracker({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.moodController,
    required this.dateController,
  });

  @override
  State<Moodtracker> createState() => _MoodtrackerState();
}

class _MoodtrackerState extends State<Moodtracker> {
  DateTime? datetime;
  String text = '';

  @override
  void initState() {
    super.initState();
    // Parse date if it exists
    if (widget.dateController.text.isNotEmpty) {
      final parts = widget.dateController.text.split('-');
      if (parts.length == 3) {
        datetime = DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      }
    }
  }

  void _selectMood(String mood) {
    setState(() {
      widget.moodController.text = mood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 50),
                child: Text("How are you feeling today?",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(width: 30, height: 40),
              InkWell(
                //fix it by putting key up here
                key: const Key('Cancel'),
                onTap: () {
                  // Your onTap code here
                  widget.onCancel();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 30.0,
                ),
              )
            ]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  key: const Key('mood_happy'),
                  onTap: () {
                    _selectMood("Happy");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "images/happy.png",
                        width: 50,
                        height: 50,
                      ),
                      const Text("Happy"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectMood("Angry");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "images/angry.png",
                        width: 50,
                        height: 50,
                      ),
                      const Text("Angry"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectMood("Sad");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "images/sad.png",
                        width: 50,
                        height: 50,
                      ),
                      const Text("Sad"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _selectMood("Disappointed");
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "images/disappointed.png",
                        width: 50,
                        height: 50,
                      ),
                      const Text("Disappointed"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.moodController.text.isNotEmpty
                  ? 'You are feeling ${widget.moodController.text}'
                  : 'Select your mood above',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: datetime ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  setState(() {
                    datetime = DateTime(selectedDate.year, selectedDate.month,
                        selectedDate.day);
                    widget.dateController.text = "${datetime!.day.toString()} - ${datetime!.month.toString()} - ${datetime!.year.toString()}";
                  });
                }
              },
              child: Text(
                key: const Key('Pick a date'),
                datetime == null
                    ? '${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()}'
                    : '${datetime!.day.toString().padLeft(2, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.year.toString()}',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 350,
                height: 200,
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: 'Write down your thoughts',
                  ),
                  maxLines: 5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: widget.onSave,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
